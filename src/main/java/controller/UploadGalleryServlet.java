package controller;

import util.DBConnection;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UploadGalleryServlet")
@MultipartConfig
public class UploadGalleryServlet extends HttpServlet {
    
    // ඔබගේ පින්තූර ගබඩා කරන ස්ථිර මාර්ගය
    private static final String UPLOAD_DIR = "C:\\Users\\my\\Downloads\\ATI_Images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("image_file");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // පින්තූරය ගොනුවට ලියන්න
        filePart.write(UPLOAD_DIR + File.separator + fileName);
        
        // database එකට fileName එක පමණක් යැවීම වඩා සුදුසුයි (පසුකාලීනව ImageServlet හරහා පෙන්වීමට)
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement("INSERT INTO gallery (image_path, is_carousel) VALUES (?, ?)")) {
            
            pst.setString(1, fileName); // මෙහි ගොනුවේ නම පමණක් දමන්න
            pst.setInt(2, (request.getParameter("is_carousel") != null) ? 1 : 0);
            pst.executeUpdate();
            
            response.sendRedirect("upload_gallery.jsp?msg=success");
        } catch (Exception e) {
            e.printStackTrace(); // දෝෂය බැලීමට මෙය වැදගත්
            response.sendRedirect("upload_gallery.jsp?error=failed");
        }
    }
}