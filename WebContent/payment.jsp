<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*, com.shashi.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Payments</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #97cec7;">

<%
	/* Kiểm tra thông tin đăng nhập của người dùng */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		return; // Ngăn mã tiếp tục chạy khi không có session
	}

	String sAmount = request.getParameter("amount");
	double amount = 0;
	if (sAmount != null) {
		try {
			amount = Double.parseDouble(sAmount);
		} catch (NumberFormatException e) {
			amount = 0; // Giá trị mặc định nếu không đúng định dạng số
		}
	}
%>

<jsp:include page="header.jsp" />

<div class="container">
	<div class="row" style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
		<form action="./OrderServlet" method="post" class="col-md-6 col-md-offset-3"
			  style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
			<div style="font-weight: bold;" class="text-center">
				<div class="form-group">
					<img src="images/profile.jpg" alt="Payment Proceed" height="100px" />
					<h2 style="color: deepskyblue;">Credit Card Payment</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<label for="cardholder">Name of Card Holder</label>
					<input type="text" placeholder="Enter Card Holder Name" name="cardholder" class="form-control" id="cardholder" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<label for="cardnumber">Enter Credit Card Number</label>
					<input type="text" pattern="\d{4}-\d{4}-\d{4}-\d{4}" inputmode="numeric" placeholder="4242-4242-4242-4242" name="cardnumber" class="form-control" id="cardnumber" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 form-group">
					<label for="expmonth">Expiry Month</label>
					<input type="number" placeholder="MM" name="expmonth" class="form-control" id="expmonth" min="1" max="12" required>
				</div>
				<div class="col-md-6 form-group">
					<label for="expyear">Expiry Year</label>
					<input type="number" placeholder="YYYY" class="form-control" id="expyear" name="expyear" min="2024" required>
				</div>
			</div>
			<div class="row text-center">
				<div class="col-md-6 form-group">
					<label for="cvv">Enter CVV</label>
					<input type="number" placeholder="123" class="form-control" size="3" id="cvv" name="cvv" required>
					<input type="hidden" name="amount" value="<%=amount%>">
				</div>

				<div class="col-md-6 form-group">
					<label>&nbsp;</label>
					<button type="submit" class="form-control btn btn-success">
						Pay: <%=amount%> VND
					</button>
				</div>
			</div>
		</form>
	</div>
</div>

<%@ include file="footer.html"%>

</body>
</html>
