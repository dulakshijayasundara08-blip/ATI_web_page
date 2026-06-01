<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>
<%
    // Session Security
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gallery Management - ATI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar { height: 100vh; width: 260px; position: fixed; background-color: #0d1b52; color: #fff; padding-top: 20px; }
        .sidebar a { padding: 12px 25px; text-decoration: none; color: #c2c7d0; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: rgba(255,255,255,0.1); color: #fff; }
        .main-content { margin-left: 260px; padding: 40px; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h4 class="px-4 text-white">ATI CONTROL</h4>
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-chart-pie me-2"></i> Dashboard</a>
        <a href="upload_gallery.jsp" class="active"><i class="fa-solid fa-images me-2"></i> Gallery</a>
        <a href="logout.jsp" class="text-danger mt-5 px-4"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a>
    </div>

    <div class="main-content">
        <div class="card p-4 shadow-sm">
            <h2 class="mb-4">Upload Gallery Image</h2>
            <form action="UploadGalleryServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <input type="file" name="image_file" class="form-control" required>
                </div>
                <div class="mb-3">
                    <input type="checkbox" name="is_carousel" value="1" id="is_carousel">
                    <label for="is_carousel">Add to Carousel (Slider)</label>
                </div>
                <button type="submit" class="btn btn-info text-white">Upload & Save</button>
            </form>
        </div>

        <div class="card p-4 mt-4 shadow-sm">
            <h3>Gallery Images</h3>
            <table class="table mt-3">
                <thead><tr><th>Image</th><th>Action</th></tr></thead>
                <tbody>
                    <% 
                        try (Connection con = DBConnection.getConnection();
                             Statement st = con.createStatement();
                             ResultSet rs = st.executeQuery("SELECT * FROM gallery")) {
                            
                            while(rs.next()){
                                // database එකේ තියෙන්නේ පින්තූරයේ නම පමණක් බව සලකන්න
                                String imageName = rs.getString("image_path");
                    %>
                    <tr>
                        <td>
                            <img src="displayImage?name=<%= imageName %>" width="100" class="rounded border">
                        </td>
                        <td>
                            <a href="DeleteGalleryServlet?id=<%= rs.getInt("id") %>" 
                               class="btn btn-danger btn-sm" onclick="return confirm('Delete this image?')">
                               Delete
                            </a>
                        </td>
                    </tr>
                    <% } } catch(Exception e) { e.printStackTrace(); } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>