<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<%@include file="pageHeader.jsp"%>
<body>
<%@include file="header.jsp"%>

<main id="content" class="mainContent sutd-template" role="main">
	<div class="container">
		<h1>New Transaction</h1>
		<%@include file="errorMessage.jsp"%>
		<div id="createTransaction">
			<form id="newTransactionForm" action="newTransaction" method="post">
				<div class="form-group">
					<select class="form-control" name="fromAccountNum">
						<c:forEach var="acc" items="${accounts}">
							<option value="${acc.id}">Changi College eAng Bao Savings Account - CC-216-${acc.id} - $${acc.amount}</option>
						</c:forEach>
					</select>
				</div>
				<div id="input-group-transcode" class="form-group">
					<label for="transcode" class="control-label">Transaction code</label>
					<input type="text" class="form-control" id="transcode" name="transcode" placeholder="Transaction Code">
				</div>
				<div id="input-group-toAccount" class="form-group">
					<label for="toAccountNum" class="control-label">To (accounts number)</label>
					<input type="number" class="form-control" id="toAccountNum" name="toAccountNum" placeholder="To Account Number">
				</div>
				<div id="input-group-amount" class="form-group">
					<label for="amount" class="control-label">Amount</label>
					<input type="number" class="form-control" id="amount" name="amount" placeholder="amount">
				</div>
				<button id="createTransBtn" type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
		<hr />
		<small class="text-muted">
			Transactions larger than $10,000 will show up as pending on your statement,
			until a Changi College Bank employee approves the transfer of funds.
		</small>
	</div>
</main>
</body>
</html>
