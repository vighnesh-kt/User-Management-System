<%@page import="connectionpool.ConPool" import="java.sql.Connection"
	import="java.io.IOException" import="java.io.PrintWriter"
	import="java.sql.Connection" import="java.sql.PreparedStatement"
	import="java.sql.ResultSet" import="java.sql.SQLException"
	import="javax.servlet.http.HttpSession"
	import="javax.servlet.http.HttpServletRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
	Connection conn = null;

	try {

		conn = ConPool.giveConn();

		Long pno = (Long) session.getAttribute("userPhone");

		if (pno != null) {

			String sql = "DELETE FROM register WHERE pno = ?";
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setLong(1, pno);

			int rowsAffected = pstm.executeUpdate();

			if (rowsAffected > 0) {
		out.println("Record deleted successfully.");
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request, response);

			} else {
		out.println("No record found with the given Phone number");
			}
		} else {
			out.println("Phone Number is missing.");
		}

	} catch (SQLException e) {
		e.printStackTrace();
		out.println("Error occurred while deleting record.");
	} finally {
		if (conn != null) {
			ConPool.submitConn(conn);

		}
	}
	%>
</body>
</html>