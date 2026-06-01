package controller;

import util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String courseName = request.getParameter("course_name");
        String duration = request.getParameter("duration");
        String fee = request.getParameter("fee");

        String sql = "INSERT INTO courses (course_name, duration, fee) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, courseName);
            ps.setString(2, duration);
            ps.setString(3, fee);
            
            int result = ps.executeUpdate();
            
            // පියවර: මෙතැන ෆයිල් නම add_course.jsp ලෙස නිවැරදි කළා
            if (result > 0) {
                response.sendRedirect("add_course.jsp?msg=success");
            } else {
                response.sendRedirect("add_course.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_course.jsp?error=exception");
        }
    }
}