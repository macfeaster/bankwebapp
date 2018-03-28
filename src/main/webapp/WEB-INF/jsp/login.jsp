<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<link rel="icon" href="<c:url value="/resources/img/sutd-logo.ico" />">

	<title>SUTD BANK</title>

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.11.3.js" />"></script>

	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/bankwebapp.css" />">

</head>

<body>
<header class="sutd-template">
	<nav class="navbar navbar-expand-md navbar-dark bg-dark" style="background: #334e76 !important; border: none; box-shadow: 0 2px 5px rgba(0, 0, 0, .2);">
		<div class="container">
			<a class="navbar-brand" href="#"><img alt="SUTD Logo" style="max-width: 100px;" src="<c:url value="/resources/img/sutd-logo.png" />"></a>

			<div class="navbar-nav">
				<c:if test="${empty sessionScope.authenticatedUser}">
					<a class="nav-item nav-link" href="login">Login</a>
					<span class="navbar-text">or</span>
					<a class="nav-item nav-link" href="register">Register</a>
				</c:if>
				<c:if test="${not empty sessionScope.authenticatedUser}">
					<a class="nav-item nav-link" href="logout">Logout</a>
				</c:if>
			</div>
		</div>
	</nav>
</header>

<!-- Login form -->
<c:if test="${empty authenticatedUser}">
	<main class="mainContent sutd-template" role="main">
		<div>
			<h2 style="text-align: center">Login</h2>
			<div class="containter loginForm">
				<form id="loginForm" action="login" method="post">
					<div id="messageBox" class="hidden"></div>
					<c:if test="${not empty req_error}">
						<div id="errorMsg">
							<p class="text-danger">${req_error}</p>
						</div>
					</c:if>
					<c:remove var="req_error" scope="session" />
					<div id="input-group-username" class="form-group">
						<label for="username" class="control-label">User name</label>
						<input type="text" class="form-control" id="username" name="username" placeholder="User name">
					</div>
					<div id="input-group-password" class="form-group">
						<label for="password" class="control-label">Password</label>
						<input type="password" class="form-control" id="password" name="password" placeholder="Password">
					</div>
					<button id="loginButton" type="submit" class="btn btn-primary">Sign in</button>
				</form>
			</div>
		</div>
	</main>
</c:if>
<!-- jQuery and line numbering JavaScript -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.11.3.js" />"></script>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/login.js" />"></script>
</body>
</html>
