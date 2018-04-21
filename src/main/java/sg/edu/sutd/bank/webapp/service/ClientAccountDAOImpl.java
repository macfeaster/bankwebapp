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

package sg.edu.sutd.bank.webapp.service;

import sg.edu.sutd.bank.webapp.commons.ServiceException;
import sg.edu.sutd.bank.webapp.model.ClientAccount;
import sg.edu.sutd.bank.webapp.model.ClientTransaction;
import sg.edu.sutd.bank.webapp.model.TransactionStatus;
import sg.edu.sutd.bank.webapp.model.User;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClientAccountDAOImpl extends AbstractDAOImpl implements ClientAccountDAO {


	@Override
	public void create(ClientAccount clientAccount) throws ServiceException {
		Connection conn = connectDB();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = prepareStmt(conn, "INSERT INTO client_account(user_id, amount) VALUES(?,?)");
			int idx = 1;
			ps.setInt(idx++, clientAccount.getUser().getId());
			ps.setBigDecimal(idx++, clientAccount.getAmount());
			executeInsert(clientAccount, ps);
		} catch (SQLException e) {
			throw ServiceException.wrap(e);
		} finally {
			closeDb(conn, ps, rs);
		}
	}

	@Override
	public void update(ClientAccount clientAccount) throws ServiceException {
		Connection conn = connectDB();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = prepareStmt(conn, "UPDATE client_account SET amount = ? WHERE id = ?");
			ps.setBigDecimal(1, clientAccount.getAmount());
			ps.setInt(2, clientAccount.getId());
			executeUpdate(ps);
		} catch (SQLException e) {
			throw ServiceException.wrap(e);
		} finally {
			closeDb(conn, ps, rs);
		}
	}

	@Override
	public ClientAccount findById(int accountId) throws ServiceException {
		Connection conn = connectDB();
		PreparedStatement ps;
		ResultSet rs;

		try {
			ps = prepareStmt(conn, "SELECT * FROM client_account WHERE id = ?");
			ps.setInt(1, accountId);
			rs = ps.executeQuery();

			if (!rs.next())
				return null;

			ClientAccount acc = new ClientAccount();
			acc.setUser(new User(rs.getInt("user_id")));
			acc.setAmount(rs.getBigDecimal("amount"));
			acc.setId(rs.getInt("id"));

			return acc;
		} catch (SQLException e) {
			throw ServiceException.wrap(e);
		}
	}

	@Override
	public List<ClientAccount> findAllByUser(int userId) throws ServiceException {
		Connection conn = connectDB();
		PreparedStatement ps;
		ResultSet rs;

		try {
			ps = prepareStmt(conn, "SELECT * FROM client_account WHERE user_id = ?");
			ps.setInt(1, userId);
			rs = ps.executeQuery();

			List<ClientAccount> accounts = new ArrayList<>();

			while (rs.next()) {
				ClientAccount acc = new ClientAccount();
				acc.setUser(new User(rs.getInt("user_id")));
				acc.setAmount(rs.getBigDecimal("amount"));
				acc.setId(rs.getInt("id"));

				accounts.add(acc);
			}

			return accounts;
		} catch (SQLException e) {
			throw ServiceException.wrap(e);
		}
	}

	@Override
	public void performTransactions(List<ClientTransaction> transactions) throws ServiceException {
		Connection conn = connectDB();

		try {
			for (ClientTransaction transaction : transactions) {
				if (transaction.getStatus() == TransactionStatus.APPROVED) {
					// Fetch the transaction amount
					PreparedStatement ps = prepareStmt(conn, "SELECT * FROM client_transaction WHERE id = ?");
					ps.setInt(1, transaction.getId());
					ResultSet rs = ps.executeQuery();
					rs.next();
					transaction.setFromAccount(new ClientAccount(rs.getInt("from_account"), null));
					transaction.setToAccount(new ClientAccount(rs.getInt("to_account"), null));
					BigDecimal amount = rs.getBigDecimal("amount");
					transaction.setAmount(amount);

					// Deduct money from sender's account
					PreparedStatement psf = prepareStmt(conn, "UPDATE client_account SET amount = amount - ? WHERE id = ? AND amount >= ?");
					psf.setBigDecimal(1, amount);
					psf.setInt(2, transaction.getFromAccount().getId());
					psf.setBigDecimal(3, amount);

					// Insert money into recipient's account
					PreparedStatement pst = prepareStmt(conn, "UPDATE client_account SET amount = amount + ? WHERE id = ?");
					pst.setBigDecimal(1, amount);
					pst.setInt(2, transaction.getToAccount().getId());

					int from = psf.executeUpdate();
					int to = pst.executeUpdate();

					if (from != 1 || to != 1)
						throw new ServiceException(new IllegalStateException("From/to account not properly updated."));
				}
			}
		} catch (SQLException e) {
			throw ServiceException.wrap(e);
		}
	}
}
