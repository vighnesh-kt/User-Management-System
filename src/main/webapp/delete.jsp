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
<title>Delete Record</title>
</head>
<body>

<%
    HttpSession s = request.getSession(false); // Get the session
    Connection conn = null;
    PreparedStatement pstm = null; // Declare PreparedStatement here

    try {
        if (session != null) {
            conn = ConPool.giveConn();
            Long pno = (Long) s.getAttribute("userPhone");

            if (pno != null) {
                String sql = "DELETE FROM register WHERE pnumber = ?";
                pstm = conn.prepareStatement(sql);
                pstm.setLong(1, pno);

                int rowsAffected = pstm.executeUpdate();

                if (rowsAffected > 0) {
                    s.invalidate();
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    request.setAttribute("recordDeleted", "Record deleted successfully.");
                    rd.forward(request, response);
                } else {
                    out.println("No record found with the given Phone number");
                }
            } else {
                out.println("Phone Number is missing.");
            }
        } else {
            out.println("Session is invalid or does not exist.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error occurred while deleting record.");
    } finally {
        if (pstm != null) {
            try {
                pstm.close(); // Close PreparedStatement
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            ConPool.submitConn(conn); // Return connection to pool
        }
    }
%>
</body>
</html>