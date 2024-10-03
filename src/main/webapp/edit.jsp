<%@page import="connectionpool.ConPool" import="java.sql.Connection"
	import="java.io.IOException" import="java.io.PrintWriter"
	import="java.sql.Connection" import="java.sql.PreparedStatement"
	import="java.sql.ResultSet" import="java.sql.SQLException"
	import="javax.servlet.http.HttpSession"
	import="javax.servlet.http.HttpServletRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update User Details</title>
    <link rel="stylesheet" type="text/css" href="edit.css">
    
</head>
<body>
<%
    
    session = request.getSession(false);

   
    if ( session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    Long userPhone = (Long) session.getAttribute("userPhone");
    String userPass = (String) session.getAttribute("userPass");
%>

<h1>Update User Details</h1>

<form action="update" method="post">
    <label for="user_name">Name:</label>
    <input type="text" id="user_name" name="uname" value="<%= userName %>" required><br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="uemail" value="<%= userEmail %>" required><br><br>

    <label for="pwd">Password:</label>
    <input type="password" id="pwd" name="upwd" value="<%= userPass %>" required><br><br>

    
    <input type="hidden" id="pnumber" name="phonenum" value="<%= userPhone %>" required><br><br>

    <button type="submit">Update</button>
</form>
	
</body>
</html>
