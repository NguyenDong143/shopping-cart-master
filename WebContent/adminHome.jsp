<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page
		import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Admin Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #97cec7;">
<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("admin")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
	} else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
%>

<jsp:include page="header.jsp" />

<div class="container text-center" style="margin-top: 50px; background-color: #97cec7; padding: 20px; border-radius: 8px;">
	<h1>Admin Dashboard</h1>
	<p style="font-size: 18px; color: #333;">Manage your product inventory</p>

	<div class="btn-group-vertical" style="margin-top: 30px; width: 300px;">
		<form>
			<button type="submit" formaction="adminViewProduct.jsp" class="btn btn-primary btn-lg btn-block">
				View Products
			</button>
			<button type="submit" formaction="addProduct.jsp" class="btn btn-success btn-lg btn-block">
				Add Products
			</button>
			<button type="submit" formaction="removeProduct.jsp" class="btn btn-danger btn-lg btn-block">
				Remove Products
			</button>
		</form>
	</div>
</div>

<%@ include file="footer.html"%>
</body>
</html>
