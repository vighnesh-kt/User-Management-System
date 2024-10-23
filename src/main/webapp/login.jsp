
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="mytag"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="login.css">
</head>
<title>Login</title>
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
		//showing registeration successfull msg from register.java
		String registerSuccess = (String) request.getAttribute("registerSuccess");
		if (registerSuccess != null) {
		%>
		<h3 class="error"><%=registerSuccess%></h3>
		<%
		}
		%>
		
		<% String alreadyRegistered=(String) request.getAttribute("alreadyRegistered");
		if(alreadyRegistered!=null){ //showing alreadyregistered from register.java
		%>
		<h3 class="error"><%=alreadyRegistered %></h3>
		<%
		}
		%>
		
		<% String invalidCredentials=(String) request.getAttribute("invalidCredentials");
		if(invalidCredentials!=null){
		%>
		<h3 class="error"><%=invalidCredentials %></h3>
		<%
		}
		%>

		<%
		Object update = request.getAttribute("updated");
		if (update != null) {
		%>
		<h3 class="error"><%=update%></h3>
		<%
		}
		%>
		
		<%Object recordDeleted= request.getAttribute("recordDeleted");
		if(recordDeleted!=null){
		%>
		<h3 class="error"><%=recordDeleted %></h3>
		<%
		}
		%>
		<form action="login" method="post">


			<div class="input-group">
				<label for="email">Email</label> <input type="email" id="email" name="email" required>
			</div>
			<div class="input-group">
				<label for="password">Password</label> <input type="password" id="password" name="pwd" required>
			</div>
			<button type="submit">login</button>
			<a href=register.jsp>Click here to register</a>
		</form>
	</div>

</body>
</html>