
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="mytag"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="login.css">
</head>
<body>
	<div class="login">
		<%
		String message = (String) request.getAttribute("message");
		String name = (String) request.getAttribute("userName");
		String email = (String) request.getAttribute("userEmail");
		Long phone = (Long) request.getAttribute("userPhone");
		
		%>


		<h2>Login</h2>
		<%
		if (message != null) {
		%>
		<h3 class="error"><%=message%></h1>
		<%
		}
		%>
		<%
		Object update= request.getAttribute("updated");
		if (update != null) {
		%>
		<h3 class="error"><%=update%></h1>
		<%
		}
		%>
		<form action="login" method="post">


			<div class="input-group">

				<label for="email">Email</label> <input type="email" id="email"
					name="email" required>

			</div>
			<div class="input-group">
				<label for="password">Password</label> <input type="password"
					id="password" name="pwd" required>
			</div>
			<button type="submit">login</button>
			<a href=register.jsp>Click here to register</a>
		</form>
	</div>

</body>
</html>