<%@page import="connectionpool.ConPool" import="java.sql.Connection"
	
	import="java.sql.SQLException" import="javax.servlet.http.HttpSession"
	import="javax.servlet.http.HttpServletRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Details</title>
<link rel="stylesheet" type="text/css" href="details.css">

</head>
<body>
<div>
<%
	session = request.getSession(false);
	if (session.getAttribute("userEmail") == null) {
		response.sendRedirect("login.jsp");
	}
	String userEmail = (String) session.getAttribute("userEmail");
	String userName = (String) session.getAttribute("userName");
	Long userPhone = (Long) session.getAttribute("userPhone");
	//String userPass = (String) request.getAttribute("userPass");
	%>
	<h1>
		Name : <%=userName%></h1>
	<h1>
		Email : <%=userEmail%></h1>
	<h1>
		Phone Number : <%=userPhone%></h1>

	<a href="home.jsp"><button>Go back</button></a></div>
	
</body>
</html>