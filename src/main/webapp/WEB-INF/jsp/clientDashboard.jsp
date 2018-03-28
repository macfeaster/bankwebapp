<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<%@include file="pageHeader.jsp"%>
<body>
<%@include file="header.jsp"%>

<main id="content" class="mainContent sutd-template" role="main">
	<div class="container">
		<%@include file="errorMessage.jsp"%>
		<div id="accountBalance">
			<h1>Accounts</h1>

			<table cellpadding="5" class="table table-striped">
				<tr>
					<th>Account Type</th>
					<th>Account Number</th>
					<th>Balance</th>
				</tr>

				<c:forEach var="acc" items="${clientInfo.accounts}">
					<tr>
						<td>Changi College eAng Bao Savings Account</td>
						<td>CC-216-${acc.id}</td>
						<td>$${acc.amount}</td>
					</tr>
				</c:forEach>
			</table>

		</div>
		<hr />
		<div id="transHistory">
			<h1>Transactions</h1>
			<table cellpadding="5" class="table table-striped">
				<tr>
					<th>Transaction code</th>
					<th>From account</th>
					<th>To account</th>
					<th>Date</th>
					<th>Amount</th>
					<th>Status</th>
				</tr>
				<c:forEach var="trans" items="${clientInfo.transactions}">
					<tr>
						<td>${trans.transCode}</td>
						<td>CC-216-${trans.fromAccount.id}</td>
						<td>CC-216-${trans.toAccount.id}</td>
						<td>${trans.dateTime}</td>
						<td>${trans.amount}</td>
						<c:if test="${empty trans.status}">
							<td>Waiting</td>
						</c:if>
						<c:if test="${not empty trans.status}">
							<td>${trans.status}</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="createTransaction" style="padding-top: 50px">
			<form id="registrationForm" action="newTransaction" method="get">
				<button id="createTransBtn" type="submit" class="btn btn-primary">New Transaction</button>
			</form>
		</div>
	</div>
</main>
</body>
</html>
