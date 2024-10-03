<%@page import="connectionpool.ConPool" import="java.sql.Connection"
	import="java.io.IOException" import="java.io.PrintWriter"
	import="java.sql.PreparedStatement" import="java.sql.ResultSet"
	import="java.sql.SQLException" import="javax.servlet.http.HttpSession"
	import="javax.servlet.http.HttpServletRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="home.css">

</head>
<body>

	<%
	session = request.getSession(false);
	String pass = (String) session.getAttribute("userPass");
	String email = (String) session.getAttribute("userEmail");
	String name = (String) session.getAttribute("userName");
	Long phone = (Long) session.getAttribute("userPhone");
	if (email != null) {
	%>
	<h1>
		Welcome
		<%=name%>
	</h1>

	<a href='delete.jsp'>Click to delete User Credentials</a>
	<br>
	<a href='edit.jsp'>Click to update User Credentials</a>
	<br>
	<a href='details.jsp'>Click to view User Credentials</a>
	<%
	}else {
		%>
		<h1>Please login first!</h1>
		<a href='login.jsp'>Click here to login</a>
		<%
	}%>
</body>
</html>
