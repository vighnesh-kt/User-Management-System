package com.ty;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connectionpool.ConPool;

@WebServlet("/login")
public class login extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String pass = req.getParameter("pwd");
		String email = req.getParameter("email");

		Connection conn = null;

		PrintWriter pw = resp.getWriter();
		try {
			conn = ConPool.giveConn();
			String sql = "SELECT * FROM register where email= ? And pwd = ?";
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setString(1, email);
			pstm.setString(2, pass);
			ResultSet rs = pstm.executeQuery();
			
			if (rs.next()) {
				session.setAttribute("userName", rs.getString("user_name"));
				session.setAttribute("userEmail", rs.getString("email"));
				session.setAttribute("userPass", rs.getString("pwd"));
				session.setAttribute("userPhone", rs.getLong("pnumber"));
				resp.sendRedirect("home.jsp");

			} else {
				req.setAttribute("invalidCredentials", "Invalid user credentials");

				RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
				rd.forward(req, resp);
			}
		} catch (SQLException e) {

			e.printStackTrace();
			pw.println("Something went wrong");

		} finally {
			if (conn != null) {
				ConPool.submitConn(conn);
			}
		}

	}
}
