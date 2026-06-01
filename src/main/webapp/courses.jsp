<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="util.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Courses - ATI Badulla</title>
    
    <!-- CSS Links -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f8f9fa; }
        .navbar-custom { background-color: #0d1b52; }
        .course-card { 
            transition: transform 0.3s ease, box-shadow 0.3s ease; 
            border: none; border-radius: 15px; overflow: hidden; 
        }
        .course-card:hover { transform: translateY(-8px); box-shadow: 0 12px 24px rgba(0,0,0,0.15); }
        .card-icon-box { 
            width: 60px; height: 60px; background-color: #eef1f6; 
            display: flex; align-items: center; justify-content: center; border-radius: 12px; 
        }
        .footer-custom { background-color: #0d1b52; color: #c2c7d0; }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top shadow">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="index.jsp">
                <i class="fa-solid fa-graduation-cap me-2"></i>ATI BADULLA
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-semibold align-items-center">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link active text-warning" href="courses.jsp">Courses</a></li>
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

    <!-- Header -->
    <div class="bg-white py-5 mb-4 shadow-sm">
        <div class="container text-center">
            <h1 class="display-5 fw-bold" style="color: #0d1b52;">Academic Programs</h1>
            <p class="text-muted lead">Explore our HND and Diploma programs.</p>
            <div class="mx-auto bg-warning" style="height: 4px; width: 60px; border-radius: 2px;"></div>
        </div>
    </div>

    <!-- Courses Grid -->
    <div class="container mb-5">
        <div id="courseContainer" class="row g-4">
            <%
                String sql = "SELECT * FROM courses ORDER BY id DESC";
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement pst = con.prepareStatement(sql);
                     ResultSet rs = pst.executeQuery()) {
                    
                    while (rs.next()) {
            %>
            <div class="col-md-4 course-item-card">
                <div class="card course-card h-100 p-4 bg-white shadow-sm border-top border-4" style="border-top-color: #0d1b52 !important;">
                    <div class="card-body p-0">
                        <div class="d-flex align-items-center mb-4">
                            <div class="card-icon-box me-3">
                                <i class="fa-solid fa-book-bookmark fa-xl" style="color: #0d1b52;"></i>
                            </div>
                            <h3 class="card-title fw-bold m-0" style="color: #0d1b52; font-size: 20px;"><%= rs.getString("course_name") %></h3>
                        </div>
                        <p class="text-muted"><i class="fa-regular fa-clock me-2"></i>Duration: <%= rs.getString("duration") %></p>
                        <p class="text-muted"><i class="fa-solid fa-sack-dollar me-2"></i>Fee: Rs. <%= rs.getString("fee") %></p>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.print("<div class='alert alert-danger'>Database Error: " + e.getMessage() + "</div>");
                }
            %>
        </div>
    </div>

    <footer class="footer-custom py-4 text-center mt-5">
        <p class="m-0">&copy; 2026 ATI Badulla. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>