<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*, com.shashi.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Product Stocks</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #E6F9E6;">
<%
	/* Kiểm tra thông tin đăng nhập */
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

<div class="text-center" style="color: #0e0a0a; font-size: 24px; font-weight: bold;">Stock Products</div>
<div class="container-fluid">
	<div class="table-responsive">
		<table class="table table-hover table-sm">
			<thead style="background-color: #00bbff; color: white; font-size: 18px;">
			<tr>
				<th>Image</th>
				<th>ProductId</th>
				<th>Name</th>
				<th>Type</th>
				<th>Price</th>
				<th>Sold Qty</th>
				<th>Stock Qty</th>
				<th colspan="2" style="text-align: center">Actions</th>
			</tr>
			</thead>
			<tbody style="background-color: white; font-size: 16px;">
			<%
				ProductServiceImpl productDao = new ProductServiceImpl();
				List<ProductBean> products = productDao.getAllProducts();

				// Sắp xếp danh sách sản phẩm theo số lượng bán giảm dần
				products.sort((p1, p2) -> {
					int soldQty1 = new OrderServiceImpl().countSoldItem(p1.getProdId());
					int soldQty2 = new OrderServiceImpl().countSoldItem(p2.getProdId());
					return Integer.compare(soldQty2, soldQty1); // Giảm dần
				});

				for (ProductBean product : products) {
					int soldQty = new OrderServiceImpl().countSoldItem(product.getProdId());
			%>
			<tr>
				<td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
				<td><a href="./updateProduct.jsp?prodid=<%=product.getProdId()%>"><%=product.getProdId()%></a></td>
				<%
					String name = product.getProdName();
					name = name.substring(0, Math.min(name.length(), 25)) + "..";
				%>
				<td><%=name%></td>
				<td><%=product.getProdType().toUpperCase()%></td>
				<td><%=product.getProdPrice()%></td>
				<td><%=soldQty%></td>
				<td><%=product.getProdQuantity()%></td>
				<td>
					<form method="post">
						<button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn btn-danger">Remove</button>
					</form>
				</td>
			</tr>
			<%
				}
				if (products.size() == 0) {
			%>
			<tr style="background-color: grey; color: white;">
				<td colspan="8" style="text-align: center;">No Items Available</td>
			</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="footer.html"%>
</body>
</html>
