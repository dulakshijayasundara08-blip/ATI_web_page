package controller;

import util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            
            if (con == null) {
                response.sendRedirect(contextPath + "/login.jsp?error=servererror");
                return;
            }

            String sql = "SELECT * FROM users WHERE username=?";
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, username);
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        String dbPassword = rs.getString("password");
                        
                        // 1. Role එකක් නැති නම් Default එකක් විදියට "user" ගන්න
                        String role = "user"; 
                        try {
                            role = rs.getString("role");
                        } catch (Exception e) {
                            // role තීරුව නැත්නම් නොසලකා හරින්න
                        }

                        // 2. Password එක සමානදැයි බලන්න
                        if (password != null && password.equals(dbPassword)) {
                            HttpSession session = request.getSession();
                            session.setAttribute("username", username);
                            session.setAttribute("role", role);

                            // 3. Admin ද බලන්න
                            if ("admin".equalsIgnoreCase(role)) {
                                response.sendRedirect(contextPath + "/admin_dashboard.jsp");
                            } else {
                                response.sendRedirect(contextPath + "/dashboard.jsp");
                            }
                        } else {
                            response.sendRedirect(contextPath + "/login.jsp?error=wrongpassword");
                        }
                    } else {
                        response.sendRedirect(contextPath + "/login.jsp?error=usernotfound");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/login.jsp?error=servererror");
        }
    }
}