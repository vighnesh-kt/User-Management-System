package com.ty;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import connectionpool.ConPool;

@WebServlet("/update")
public class update extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session.getAttribute("userEmail") == null) {
			resp.sendRedirect("login.jsp");

		}

		String name = req.getParameter("uname");
		String email = req.getParameter("uemail");
		String password = req.getParameter("upwd");
		String phone = req.getParameter("phonenum");

		Connection conn = null;
		PrintWriter pw = resp.getWriter();
		try {

			long phoneNum = Long.parseLong(phone);

			conn = ConPool.giveConn();

			String update = "UPDATE register SET sname=?, email=?, pwd=? WHERE pno=?";
			PreparedStatement pstm = conn.prepareStatement(update);
			pstm.setString(1, name);
			pstm.setString(2, email);
			pstm.setString(3, password);
			pstm.setLong(4, phoneNum);

			int rowsAffected = pstm.executeUpdate();

			if (rowsAffected > 0) {
				RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
				pw.print("<script>alert('Details Edited');</script>");
				req.setAttribute("updated", "Details Updated");
				rd.include(req, resp);
			} else {
				RequestDispatcher rd = req.getRequestDispatcher("home.jsp");
				pw.print("<script>alert('phone number does not exist');</script>");
				rd.include(req, resp);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			pw.print("something went wrong");
			resp.sendRedirect("home.jsp");
		} finally {

			if (conn != null) {
				ConPool.submitConn(conn);

			}
		}
	}
}
