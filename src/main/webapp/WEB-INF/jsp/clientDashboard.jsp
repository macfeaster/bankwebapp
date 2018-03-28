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
			<h3>Account Balance:  </h3>
			<div>${clientInfo.account.amount}</div>
		</div>
		<div id="transHistory">
			<h3>Transaction History:  </h3>
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
						<td>${trans.fromAccount.id}</td>
						<td>${trans.toAccount.id}</td>
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
