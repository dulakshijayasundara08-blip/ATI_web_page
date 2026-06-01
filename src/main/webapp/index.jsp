<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATI Badulla | Official Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f8f9fa; }
        .navbar-custom { background-color: #0d1b52; }
        .carousel-item img { height: 450px; object-fit: cover; filter: brightness(70%); }
        .news-ticker { background: #ffffff; padding: 15px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); margin-top: -30px; position: relative; z-index: 1000; border-left: 5px solid #ffc107; }
        .section-title { color: #0d1b52; font-weight: bold; margin-bottom: 25px; }
        .footer-custom { background: #0d1b52; color: #c2c7d0; padding: 30px 0; }
        .hover-card:hover { transform: translateY(-5px); transition: 0.3s; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top shadow">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="index.jsp">
                <i class="fa-solid fa-graduation-cap me-2"></i>ATI BADULLA
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-semibold">
                    <li class="nav-item"><a class="nav-link active text-warning" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="courses.jsp">Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="results.jsp">Results</a></li>
                    <li class="nav-item"><a class="nav-link" href="gallery.jsp">Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item">
                        <a class="btn btn-warning btn-sm text-dark ms-2 px-3 fw-bold rounded-pill" href="login.jsp">
                            <i class="fa-solid fa-user-lock me-1"></i> Admin
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <% 
                try (Connection con = DBConnection.getConnection();
                     Statement st = con.createStatement();
                     ResultSet rs = st.executeQuery("SELECT image_path FROM gallery WHERE is_carousel = 1")) {
                     
                     boolean first = true;
                     boolean hasImages = false;
                     
                     while(rs.next()){ 
                         hasImages = true;
                         String imageName = rs.getString("image_path");
            %>
                <div class="carousel-item <%= first ? "active" : "" %>">
                    <img src="displayImage?name=<%= imageName %>" class="d-block w-100" alt="Gallery">
                </div>
            <% 
                         first = false; 
                     } 
                     
                     if (!hasImages) {
            %>
                <div class="carousel-item active bg-dark text-white text-center py-5">
                    <h3>Welcome to ATI Badulla</h3>
                </div>
            <% 
                     }
                } catch(Exception e) { 
            %>
                <div class="carousel-item active bg-dark text-white text-center py-5">
                    <h3>Welcome to ATI Badulla</h3>
                </div>
            <% } %>
        </div>
        
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <div class="container">
        <div class="news-ticker shadow-sm">
            <h6 class="text-primary d-inline me-3 fw-bold"><i class="fas fa-bullhorn text-warning me-2"></i>LATEST:</h6>
            <marquee behavior="scroll" direction="left" onmouseover="this.stop();" onmouseout="this.start();">
                <% try (Connection con = DBConnection.getConnection();
                   Statement st = con.createStatement();
                   ResultSet rs = st.executeQuery("SELECT * FROM notices ORDER BY id DESC")) {
                   while(rs.next()){ %>
                <span class="me-5"><i class="fas fa-dot-circle text-danger me-2"></i><%= rs.getString("title") %> (<%= rs.getString("date") %>)</span>
                <% } } catch(Exception e) { %> <span>No notices available.</span> <% } %>
            </marquee>
        </div>
    </div>

    <div class="container mt-5">
        <div class="row g-5">
            <div class="col-md-7">
                <h3 class="section-title"><i class="fa-solid fa-book-open-reader me-2"></i>Academic Programs</h3>
                <div class="list-group shadow-sm">
                    <% try (Connection con = DBConnection.getConnection();
                       Statement st = con.createStatement();
                       ResultSet rs = st.executeQuery("SELECT * FROM courses ORDER BY id DESC LIMIT 5")) {
                       while(rs.next()){ %>
                    <div class="list-group-item d-flex justify-content-between align-items-center p-3">
                        <span><i class="fas fa-arrow-right text-warning me-3"></i><%= rs.getString("course_name") %></span>
                        <span class="badge bg-primary rounded-pill"><%= rs.getString("duration") %></span>
                    </div>
                    <% } } catch(Exception e) { %> <div class="list-group-item">Programs currently unavailable.</div> <% } %>
                </div>
            </div>

            <div class="col-md-5 text-center p-4 bg-white rounded shadow-sm hover-card">
                <h3 class="section-title"><i class="fa-solid fa-file-lines me-2"></i>Exam Results</h3>
                <p class="text-muted">Access your semester examination results here.</p>
                <a href="results.jsp" class="btn btn-warning btn-lg w-100 mt-3 fw-bold">
                    <i class="fas fa-search me-2"></i>Check Results Now
                </a>
            </div>
        </div>
    </div>

    <footer class="footer-custom text-center mt-5">
        <div class="container">
            <p class="mb-1">&copy; 2026 Advanced Technological Institute (ATI) Badulla.</p>
            <small>All Rights Reserved | Student Academic Portal</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>