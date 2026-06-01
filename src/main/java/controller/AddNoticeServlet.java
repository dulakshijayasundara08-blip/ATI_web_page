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

@WebServlet("/AddNoticeServlet")
public class AddNoticeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // 1. JSP Form එකේ 'name' ඇට්‍රිබියුට් වලට අනුව දත්ත ලබා ගැනීම
        String title = request.getParameter("title");
        String description = request.getParameter("description"); // JSP එකේ name="description" නිසා මෙය වෙනස් කරන ලදී

        // NetBeans Console එකේ දත්ත ලැබෙනවාද කියා බැලීමට
        System.out.println("====== ADD NOTICE ATTEMPT ======");
        System.out.println("Notice Title: " + title);
        System.out.println("Description Length: " + (description != null ? description.length() : 0));

        // 2. SQL Query එක (priority එක දැනට form එකේ නැති නිසා සරලව title සහ content/description පමණක් ඇතුළත් කරමු)
        String sql = "INSERT INTO notices (title, content, notice_date) VALUES (?, ?, NOW())";

        // 🛠️ try-with-resources මඟින් Connection ආරක්ෂිතව ක්ලෝස් කිරීම
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, title);
            pst.setString(2, description);

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                System.out.println("SUCCESS: Notice published to database!");
                // සාර්ථක නම් msg=success සමඟින් ආපහු JSP පිටුවට හරවා යවයි
                response.sendRedirect("add_notice.jsp?msg=success");
            } else {
                System.out.println("FAILED: Database did not insert the notice row!");
                response.sendRedirect("add_notice.jsp?error=failed");
            }

        } catch (Exception e) {
            System.out.println("🚨 SERVER ERROR IN ADD_NOTICE: " + e.getMessage());
            e.printStackTrace();
            // දෝෂයක් වුවහොත් error=servererror ලෙස JSP පිටුවට හරවා යවයි
            response.sendRedirect("add_notice.jsp?error=servererror");
        }
    }
}