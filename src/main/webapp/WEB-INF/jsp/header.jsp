<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<header class="sutd-template">
	<nav class="navbar navbar-expand-md navbar-dark bg-dark" style="background: #334e76 !important; border: none; box-shadow: 0 2px 5px rgba(0, 0, 0, .2);">
		<div class="container">
			<a class="navbar-brand" href="/"><img alt="SUTD Logo" style="max-width: 100px;" src="<c:url value="/resources/img/sutd-logo.png" />"></a>

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

<c:if test="${not empty sessionScope.authenticatedUser}">
	<!-- Logout form -->
	<form id="logoutForm" action="logout" method="post">
	</form>
</c:if>
