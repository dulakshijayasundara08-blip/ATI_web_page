<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Gallery - ATI Badulla</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; }
        .navbar { background-color: #0d1b52 !important; }
        .gallery-container { position: relative; overflow: hidden; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: all 0.4s ease; cursor: pointer; height: 250px; }
        .gallery-container img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .gallery-container:hover img { transform: scale(1.1); }
        .gallery-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(13, 27, 82, 0.7); display: flex; justify-content: center; align-items: center; opacity: 0; transition: opacity 0.4s ease; }
        .gallery-container:hover .gallery-overlay { opacity: 1; }
        .gallery-overlay i { color: #fff; font-size: 2rem; transform: scale(0.7); transition: transform 0.4s ease; }
        .gallery-container:hover .gallery-overlay i { transform: scale(1); }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp"><i class="fa-solid fa-graduation-cap me-2"></i>ATI BADULLA</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="courses.jsp">Courses</a></li>
                    <li class="nav-item"><a class="nav-link active" href="gallery.jsp">Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-warning btn-sm fw-bold px-3 text-dark" href="login.jsp">
                            <i class="fa-solid fa-right-to-bracket me-1"></i>Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="bg-white py-5 mb-5 shadow-sm">
        <div class="container text-center" data-aos="fade-down">
            <h1 class="display-4 fw-bold" style="color: #0d1b52;">Campus Event Gallery</h1>
            <p class="text-muted lead">Glimpses of memorable moments at ATI Badulla.</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row g-4">
            <%
                try (Connection con = DBConnection.getConnection();
                     Statement st = con.createStatement();
                     ResultSet rs = st.executeQuery("SELECT image_path FROM gallery ORDER BY id DESC")) {
                    
                    int animDelay = 100;
                    boolean hasImages = false;
                    
                    while (rs.next()) {
                        hasImages = true;
                        String imageName = rs.getString("image_path");
                        // පින්තූරය පෙන්වීමට DisplayImageServlet භාවිතා කිරීම
                        String displayUrl = "displayImage?name=" + imageName;
            %>
                        <div class="col-sm-6 col-md-4" data-aos="zoom-in" data-aos-delay="<%= animDelay %>">
                            <div class="gallery-container" onclick="openLightbox('<%= displayUrl %>')">
                                <img src="<%= displayUrl %>" alt="Campus Event Image">
                                <div class="gallery-overlay">
                                    <i class="fa-solid fa-magnifying-glass-plus"></i>
                                </div>
                            </div>
                        </div>
            <%
                        animDelay += 50;
                    }
                    if (!hasImages) {
            %>
                        <div class="col-12 text-center py-5">
                            <h3 class="text-muted">No images uploaded yet.</h3>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    out.print("<div class='alert alert-danger'>Database Error: " + e.getMessage() + "</div>");
                }
            %>
        </div>
    </div>

    <div class="modal fade" id="lightboxModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content bg-transparent border-0">
                <div class="modal-body p-0 text-center">
                    <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <img id="lightboxImg" src="" class="img-fluid rounded shadow-lg" style="max-height: 85vh;">
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ once: true });
        function openLightbox(imageSrc) {
            document.getElementById('lightboxImg').src = imageSrc;
            var myModal = new bootstrap.Modal(document.getElementById('lightboxModal'));
            myModal.show();
        }
    </script>
</body>
</html>