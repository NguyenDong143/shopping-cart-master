<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Add Product</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="css/changes.css">
</head>
<body style="background-color: #97cec7;">
<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("admin")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
		return;
	} else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		return;
	}
%>

<jsp:include page="header.jsp" />

<%
	String message = request.getParameter("message");
%>
<div class="container">
	<div class="row" style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
		<form action="./AddProductSrv" method="post" enctype="multipart/form-data" class="col-md-6 col-md-offset-3"
			  style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
			<div style="font-weight: bold;" class="text-center">
				<h2 style="color: deepskyblue;">Product Addition Form</h2>
				<% if (message != null) { %>
				<p style="color: #0e0a0a;">
					<%=message%>
				</p>
				<% } %>
			</div>
			<div class="row">
				<div class="col-md-6 form-group">
					<label for="product_name">Product Name</label>
					<input type="text" placeholder="Enter Product Name" name="name" class="form-control" id="product_name" required>
				</div>
				<div class="col-md-6 form-group">
					<label for="product_type">Product Type</label>
					<select name="type" id="product_type" class="form-control" required>
						<option value="CaFe">CaFe</option>
						<option value="TRASUA">TRÀ SỮA</option>
						<option value="CaFe máy">CaFe máy</option>
						<option value="NUOCGIAIKHAT">NƯỚC GIẢI KHÁT</option>
						<option value="other">Some Other Appliances</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="product_description">Product Description</label>
				<textarea name="info" class="form-control" id="product_description" required></textarea>
			</div>
			<div class="row">
				<div class="col-md-6 form-group">
					<label for="unit_price">Unit Price</label>
					<div class="input-group">
						<input type="number" placeholder="Enter Unit Price" name="price" class="form-control" id="unit_price" required>
						<span class="input-group-addon">VND</span>
					</div>
				</div>
				<div class="col-md-6 form-group">
					<label for="stock_quantity">Stock Quantity</label>
					<input type="number" placeholder="Enter Stock Quantity" name="quantity" class="form-control" id="stock_quantity" required>
				</div>
			</div>

			<div class="form-group">
				<label for="product_image">Product Image</label>
				<input type="file" placeholder="Select Image" name="image" class="form-control" id="product_image" required>
			</div>

			<div class="row">
				<div class="col-md-6 text-center" style="margin-bottom: 2px;">
					<button type="reset" class="btn btn-danger">Reset</button>
				</div>
				<div class="col-md-6 text-center">
					<button type="submit" class="btn btn-success">Add Product</button>
				</div>
			</div>
		</form>
	</div>
</div>

<%@ include file="footer.html"%>
</body>
</html>
