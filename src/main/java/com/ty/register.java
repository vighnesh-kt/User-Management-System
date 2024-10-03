package com.ty;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import connectionpool.ConPool; 

@WebServlet("/register")
public class register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("email");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConPool.giveConn();

            if (con == null) {
                pw.print("Failed to connect to the database.");
                return; 
            }

            // Checking if email already exists in the database
            String query = "SELECT * FROM register WHERE email = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("message", "Email already registered. Please log in.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            } else {
                // Email doesn't exist, proceed with registration
                String name = request.getParameter("user_name");
                String password = request.getParameter("pwd");
                String phone = request.getParameter("pnumber");

                // Close previous PreparedStatement and create a new one for the INSERT query
                ps.close();

                // Insert new user into the database
                query = "INSERT INTO register (sname, email, pwd, pno) VALUES(?, ?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                long phoneNum = Long.parseLong(phone);
                ps.setLong(4, phoneNum);

                ps.executeUpdate();

                // Redirect to login page after successful registration
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            pw.print("Something went wrong.");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.include(request, response);

        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) ConPool.submitConn(con); 
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
