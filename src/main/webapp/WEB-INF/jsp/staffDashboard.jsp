<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="en">
<%@include file="pageHeader.jsp"%>
<body>
	<%@include file="header.jsp"%>
	<main id="content" class="mainContent sutd-template" role="main">
	<div class="container">
		<div id="messageBox" class="hidden"></div>
			<c:if test="${not empty req_error}">
				<div id="errorMsg" class="alert alert-danger">
					<p class="text-danger">${req_error}</p>
				</div>
			</c:if>
			<c:remove var="req_error" scope="session" /> 
		<div id="registrationList" >
			<h2>Client Registration</h2>
				<c:if test="${not empty registrationList}">
				<form id="editRegistrationForm" action="staffDashboard" method="post" >
					<table border="1" cellpadding="5" class="commonTable">
						<tr>
							<th style="width: 150px">Full name</th>
							<th style="width: 150px">FIN</th>
							<th style="width: 150px">Date of birth</th>
							<th style="width: 150px">occupation</th>
							<th style="width: 250px">Address</th>
							<th style="width: 100px">Decision</th>
						</tr>
						<c:forEach var="client" items="${sessionScope.registrationList}">
							<tr>
								<td>${client.fullName}</td>
								<td>${client.fin}</td>
								<td>${client.dateOfBirth}</td>
								<td>${client.occupation}</td>
								<td>${client.address}</td>
								<td><select name="decision" id="staffDecision">
										<option value="waiting"></option>
										<option value="approve">Approve</option>
										<option value="decline">Decline</option>
									</select>
									<input type="hidden" name="user_id" value="${client.user.id}"> 
									<input type="hidden" name="user_email" value="${client.email}">
								</td>
							</tr>
						</c:forEach>
					</table>
				<input type="hidden" name="actionType" value="registrationDecisionAction">
				<!-- Record internal toolbar -->
				<div>
					<div class="btn-group toolbar" role="group">
						<button id="regDecisionBtn" type="submit" value="staffDashboard" class="btn btn-primary">Update</button>
					</div>
				</div>
			</form>
			</c:if>
				<c:if test="${empty registrationList}">
				<div>Empty</div>	
			</c:if>
		</div>

		<hr />
		
		<div id="transactionList">
			<h1>Client Transactions</h1>
			<c:if test="${not empty transList}">
				<form id="editTransactionForm" action="staffDashboard" method="post" >
					<table cellpadding="5" class="table table-striped">
						<tr>
							<th>Transaction code</th>
							<th>From account</th>
							<th>To account</th>
							<th>Datatime</th>
							<th>Amount</th>
							<th>Decision</th>
						</tr>
						<c:forEach var="trans" items="${transList}">
							<tr>
								<td>${trans.transCode}</td>
								<td>CC-216-${trans.fromAccount.id}</td>
								<td>CC-216-${trans.toAccount.id}</td>
								<td>${trans.dateTime}</td>
								<td>${trans.amount}</td>
								<td><select name="decision">
										<option value="waiting"></option>
										<option value="approve">Approve</option>
										<option value="decline">Decline</option>
									</select>
									<input type="hidden" name="trans_id" value="${trans.id}"> 
								</td>
							</tr>
						</c:forEach>
					</table>
					<input type="hidden" name="actionType" value="transactionDecisionAction">
					<div id="submitBar">
						<div class="btn-group toolbar" role="group">
							<button id="transDecisionBtn" type="submit" value="staffDashboard" class="btn btn-primary">Update</button>
						</div>
					</div>
			</form>
			</c:if>
				<c:if test="${empty transList}">
				<div>Empty</div>	
			</c:if>
		</div>
	</div>
	</main>
</body>
</html>
