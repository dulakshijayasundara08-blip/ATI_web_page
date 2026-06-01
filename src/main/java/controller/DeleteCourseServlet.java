/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        
        // NetBeans Console එකේ පරික්ෂා කිරීමට
        System.out.println("====== DELETE COURSE ATTEMPT ======");
        System.out.println("Requested Course ID to Delete: " + idParam);

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);

                String sql = "DELETE FROM courses WHERE id=?";

                // 🛠️ Connection සහ PreparedStatement ස්වයංක්‍රීයව ක්ලෝස් වීමට try-with-resources භාවිතා කර ඇත
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement pst = con.prepareStatement(sql)) {

                    pst.setInt(1, id);
                    int rowCount = pst.executeUpdate();

                    if (rowCount > 0) {
                        System.out.println("SUCCESS: Course ID " + id + " deleted from database!");
                        // සාර්ථකව මැකුණා නම් delete_msg=success කියා viewCourses.jsp වෙත යවයි
                        response.sendRedirect("viewcourses.jsp?delete_msg=success");
                    } else {
                        System.out.println("FAILED: No course found with ID " + id);
                        response.sendRedirect("viewcourses.jsp?delete_error=notfound");
                    }
                }

            } catch (Exception e) {
                System.out.println("🚨 SERVER ERROR IN DELETE_COURSE: " + e.getMessage());
                e.printStackTrace();
                // කිසියම් දෝෂයක් වුවහොත් delete_error=servererror කියා හරවා යවයි
                response.sendRedirect("viewcourses.jsp?delete_error=servererror");
            }
        } else {
            response.sendRedirect("viewcourses.jsp");
        }
    }
}