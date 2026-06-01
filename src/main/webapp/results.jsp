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
    <title>Exam Results Portal - ATI Badulla</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        /* Navigation Style matching whole web portal */
        .navbar-custom {
            background-color: #0d1b52;
        }
        .navbar-custom .nav-link, .navbar-custom .navbar-brand {
            color: #fff !important;
        }
        .navbar-custom .nav-link:hover {
            color: #ffc107 !important;
        }
        
        /* Styled Search Box and Table */
        .search-card {
            background: white;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .form-control:focus {
            border-color: #0d1b52;
            box-shadow: 0 0 0 0.25rem rgba(13, 27, 82, 0.25);
        }
        .table-custom thead {
            background-color: #0d1b52;
            color: white;
        }
        .badge-grade {
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 20px;
        }
        .footer-custom {
            background-color: #0d1b52;
            color: #c2c7d0;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-custom sticky-top shadow">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="index.jsp">
                <i class="fa-solid fa-graduation-cap me-2"></i>ATI BADULLA
            </a>
            <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fa-solid fa-bars"></i>
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
                            <i class="fa-solid fa-right-to-bracket me-1"></i> Admin Portal
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <div class="card search-card p-4 p-sm-5 bg-white mb-4">
                    <div class="text-center mb-4">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-3 fs-3" style="background-color: rgba(13,110,253,0.1) !important; color: #0d6efd !important;">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <h2 class="fw-bold m-0" style="color: #0d1b52;">Examination Results Portal</h2>
                        <p class="text-muted small">Enter your official Student Index Number below to view your academic transcript grades.</p>
                    </div>

                    <form action="results.jsp" method="GET" class="row g-2 justify-content-center">
                        <div class="col-sm-8">
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="fa-solid fa-id-card"></i></span>
                                <input type="text" name="search_index" class="form-control py-2.5" 
                                       placeholder="e.g., BAD/IT/2024/F/01" 
                                       value="<%= (request.getParameter("search_index") != null) ? request.getParameter("search_index") : "" %>" required>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <button type="submit" class="btn btn-primary w-100 py-2.5 fw-bold rounded-pill shadow-sm" style="background-color: #0d1b52; border: none;">
                                <i class="fa-solid fa-magnifying-glass me-1"></i> Search Results
                            </button>
                        </div>
                    </form>
                </div>

                <%
                    String searchIndex = request.getParameter("search_index");
                    
                    if (searchIndex != null && !searchIndex.trim().isEmpty()) {
                        searchIndex = searchIndex.trim();
                        
                        String sql = "SELECT * FROM results WHERE student_index = ? ORDER BY subject ASC";
                        boolean dataFound = false;
                        int serialNo = 1;
                        
                        try (Connection con = DBConnection.getConnection();
                             PreparedStatement pst = con.prepareStatement(sql)) {
                            
                            pst.setString(1, searchIndex);
                            try (ResultSet rs = pst.executeQuery()) {
                %>
                                <div class="card search-card p-4 bg-white shadow-sm" id="resultsSection">
                                    <h4 class="fw-bold mb-3 text-secondary" style="font-size: 18px;">
                                        <i class="fa-solid fa-user me-2 text-primary"></i>Results for Index: <span class="text-dark"><%= searchIndex %></span>
                                    </h4>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover table-custom m-0 align-middle">
                                            <thead>
                                                <tr>
                                                    <th style="width: 10%;" class="text-center">#</th>
                                                    <th style="width: 65%;">Subject Name / Code</th>
                                                    <th style="width: 25%;" class="text-center">Obtained Grade</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                <%
                                                while (rs.next()) {
                                                    dataFound = true;
                                                    String subject = rs.getString("subject");
                                                    String grade = rs.getString("grade");
                                                    
                                                    // F Grade එකක් නම් රතු පාටින් පෙන්වීමට
                                                    String badgeClass = "bg-success";
                                                    if ("F".equalsIgnoreCase(grade)) {
                                                        badgeClass = "bg-danger";
                                                    } else if (grade.startsWith("C") || grade.startsWith("D")) {
                                                        badgeClass = "bg-warning text-dark";
                                                    }
                                %>
                                                    <tr>
                                                        <td class="text-center fw-semibold text-muted"><%= serialNo++ %></td>
                                                        <td class="fw-semibold text-dark"><%= subject %></td>
                                                        <td class="text-center">
                                                            <span class="badge badge-grade <%= badgeClass %>"><%= grade %></span>
                                                        </td>
                                                    </tr>
                                <%
                                                }
                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                <%
                                if (!dataFound) {
                %>
                                    <div class="alert alert-danger text-center p-4 shadow-sm rounded-3 mb-0" role="alert">
                                        <i class="fa-solid fa-triangle-exclamation fs-2 mb-2 d-block"></i>
                                        <h5 class="fw-bold">No Results Found!</h5>
                                        <p class="m-0 small">We couldn't find any examination records for the Index Number: <strong><%= searchIndex %></strong>. Please double-check and try again.</p>
                                    </div>
                <%
                                }
                            }
                        } catch (Exception e) {
                %>
                            <div class="alert alert-danger text-center">
                                <strong>🚨 Server Error:</strong> <%= e.getMessage() %>
                            </div>
                <%
                        }
                    }
                %>

            </div>
        </div>
    </div>

    <footer class="footer-custom py-4 text-center mt-auto border-top border-secondary">
        <div class="container">
            <p class="m-0 text-white-50 small">&copy; 2026 Advanced Technological Institute (ATI) Badulla. All Rights Reserved.</p>
            <small class="text-muted">Developed for Student Academic Management Portal</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>