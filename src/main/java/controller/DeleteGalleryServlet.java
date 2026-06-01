package controller;

import util.DBConnection;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteGalleryServlet")
public class DeleteGalleryServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        // ID එකක් ලැබී නැත්නම් කෙලින්ම පිටුවට යවන්න
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("upload_gallery.jsp?error=invalid_id");
            return;
        }

        String imagePath = null;

        try (Connection con = DBConnection.getConnection()) {
            // 1. මුලින්ම ඩේටාබේස් එකෙන් එම රූපයේ path එක ලබාගන්න
            String selectSql = "SELECT image_path FROM gallery WHERE id = ?";
            try (PreparedStatement psPath = con.prepareStatement(selectSql)) {
                psPath.setString(1, id);
                try (ResultSet rs = psPath.executeQuery()) {
                    if (rs.next()) {
                        imagePath = rs.getString("image_path");
                    }
                }
            }

            // 2. ඩේටාබේස් එකෙන් රූපයේ තොරතුරු මැකීම
            if (imagePath != null) {
                String deleteSql = "DELETE FROM gallery WHERE id = ?";
                try (PreparedStatement psDelete = con.prepareStatement(deleteSql)) {
                    psDelete.setString(1, id);
                    int status = psDelete.executeUpdate();

                    // 3. ඩේටාබේස් එකෙන් මැකුනා නම් පමණක් සැබෑ ෆයිල් එක මකන්න
                    if (status > 0) {
                        // පින්තූරය තියෙන සැබෑ ෆෝල්ඩරය සොයාගැනීම
                        String fullPath = getServletContext().getRealPath("") + File.separator + imagePath;
                        File file = new File(fullPath);
                        
                        if (file.exists()) {
                            file.delete(); // ෆයිල් එක මැකීම
                        }
                    }
                }
            }
            
            // සාර්ථකව මැකූ පසු upload_gallery.jsp වෙත යවන්න
            response.sendRedirect("upload_gallery.jsp?msg=deleted");
            
        } catch (Exception e) {
            e.printStackTrace(); // දෝෂයක් ආවොත් Log එකේ පෙන්වයි
            response.sendRedirect("upload_gallery.jsp?error=failed");
        }
    }
}