/*
 * Copyright 2017 SUTD Licensed under the
	Educational Community License, Version 2.0 (the "License"); you may
	not use this file except in compliance with the License. You may
	obtain a copy of the License at

https://opensource.org/licenses/ECL-2.0

	Unless required by applicable law or agreed to in writing,
	software distributed under the License is distributed on an "AS IS"
	BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
	or implied. See the License for the specific language governing
	permissions and limitations under the License.
 */

package sg.edu.sutd.bank.webapp.servlet;

import sg.edu.sutd.bank.webapp.commons.ServiceException;
import sg.edu.sutd.bank.webapp.model.ClientAccount;
import sg.edu.sutd.bank.webapp.model.ClientTransaction;
import sg.edu.sutd.bank.webapp.model.TransactionCode;
import sg.edu.sutd.bank.webapp.model.TransactionStatus;
import sg.edu.sutd.bank.webapp.model.User;
import sg.edu.sutd.bank.webapp.service.AuthorizationService;
import sg.edu.sutd.bank.webapp.service.ClientAccountDAO;
import sg.edu.sutd.bank.webapp.service.ClientAccountDAOImpl;
import sg.edu.sutd.bank.webapp.service.ClientTransactionDAO;
import sg.edu.sutd.bank.webapp.service.ClientTransactionDAOImpl;
import sg.edu.sutd.bank.webapp.service.TransactionCodesDAO;
import sg.edu.sutd.bank.webapp.service.TransactionCodesDAOImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import static sg.edu.sutd.bank.webapp.servlet.ServletPaths.NEW_TRANSACTION;

@WebServlet(NEW_TRANSACTION)
public class NewTransactionServlet extends DefaultServlet {
	private static final long serialVersionUID = 1L;
	private ClientTransactionDAO clientTransactionDAO = new ClientTransactionDAOImpl();
	private ClientAccountDAO clientAccountDAO = new ClientAccountDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AuthorizationService.authenticatedWithRole(req, "client");

		try {
			List<ClientAccount> accounts = clientAccountDAO.findAllByUser(getUserId(req));
			req.getSession().setAttribute("accounts", accounts);
			forward(req, resp);
		} catch (ServiceException e) {
			sendError(req, e.getMessage());
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AuthorizationService.authenticatedWithRole(req, "client");
		String transcode = req.getParameter("transcode");
		int fromAccountNum = Integer.parseInt(req.getParameter("fromAccountNum"));
		int toAccountNum = Integer.parseInt(req.getParameter("toAccountNum"));
		BigDecimal amount = new BigDecimal(req.getParameter("amount"));

		try {
			// Validate the transaction code
			TransactionCodesDAO tcd = new TransactionCodesDAOImp();
			TransactionCode tc = tcd.findByCode(transcode, getUserId(req));

			if (tc == null)
				throw ServiceException.wrap(new IllegalArgumentException("Invalid or used transaction code."));

			// Make sure recipient account exists
			ClientAccountDAO cad = new ClientAccountDAOImpl();
			ClientAccount toAccount = cad.findById(toAccountNum);

			if (toAccount == null)
				throw ServiceException.wrap(new IllegalArgumentException("Non-existent recipient account number."));

			// Make sure recipient account exists
			ClientAccount fromAccount = cad.findById(fromAccountNum);
			if (fromAccount == null)
				throw ServiceException.wrap(new IllegalArgumentException("Non-existent recipient account number."));

			// Make sure user has sufficient funds
			if (fromAccount.getAmount().compareTo(amount) < 0)
				throw ServiceException.wrap(new IllegalArgumentException("Your account has insufficient funds for this transaction."));

			// Mark transaction code as used
			tc.setUsed(true);
			tcd.update(tc);

			// Log transaction
			ClientTransaction clientTransaction = new ClientTransaction();
			User user = new User(getUserId(req));
			clientTransaction.setUser(user);
			clientTransaction.setAmount(amount);
			clientTransaction.setTransCode(transcode);
			clientTransaction.setFromAccount(fromAccount);
			clientTransaction.setToAccount(toAccount);

			// For transactions of less than $10 000, the system will automatically
			// approve the transaction and transfer the funds
			if (amount.compareTo(new BigDecimal("10000")) < 0) {
				// Update balances
				fromAccount.setAmount(fromAccount.getAmount().subtract(amount));
				toAccount.setAmount(toAccount.getAmount().add(amount));
				clientAccountDAO.update(fromAccount);
				clientAccountDAO.update(toAccount);

				// Approve the transaction
				clientTransaction.setStatus(TransactionStatus.APPROVED);
			}

			// Save the transaction
			clientTransactionDAO.create(clientTransaction);

			// Redirect to client dashboard
			redirect(resp, ServletPaths.CLIENT_DASHBOARD_PAGE);
		} catch (ServiceException e) {
			sendError(req, e.getMessage());
			forward(req, resp);
		}
	}
}
