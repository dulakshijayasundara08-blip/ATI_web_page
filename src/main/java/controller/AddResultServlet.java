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

@WebServlet("/AddResultServlet")
public class AddResultServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. JSP Form එකෙන් එවන දත්ත ලබා ගැනීම
        String studentIndex = request.getParameter("student_index");
        String subject = request.getParameter("subject");
        String grade = request.getParameter("grade");

        // NetBeans Console එකේ දත්ත ලැබෙනවාද කියා බැලීමට
        System.out.println("====== ADD EXAM RESULT ATTEMPT ======");
        System.out.println("Student Index: " + studentIndex);
        System.out.println("Subject: " + subject);
        System.out.println("Grade: " + grade);

        // 2. SQL Query එක (results ටේබල් එකට දත්ත ඇතුළත් කිරීම)
        String sql = "INSERT INTO results (student_index, subject, grade) VALUES (?, ?, ?)";

        // try-with-resources මඟින් Connection එක ආරක්ෂිතව ක්ලෝස් කිරීම
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, studentIndex);
            pst.setString(2, subject);
            pst.setString(3, grade);
            
            int row = pst.executeUpdate();
            
            if (row > 0) {
                System.out.println("SUCCESS: Exam result added to database!");
                // 💡 සාර්ථක නම් msg=success සමඟින් addResult.jsp පිටුවට හරවා යවයි (Capital R)
                response.sendRedirect("add_result.jsp?msg=success");
            } else {
                System.out.println("FAILED: Database did not insert the result row!");
                response.sendRedirect("add_result.jsp?error=failed");
            }
            
        } catch (Exception e) {
            System.out.println("🚨 SERVER ERROR IN ADD_RESULT: " + e.getMessage());
            e.printStackTrace();
            // දෝෂයක් වුවහොත් error=failed ලෙස addResult.jsp පිටුවට හරවා යවයි
            response.sendRedirect("add_result.jsp?error=failed");
        }
    }
}