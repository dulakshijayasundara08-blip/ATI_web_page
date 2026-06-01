,<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, util.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ATI Badulla - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --sidebar-bg: #0d1b52;
            --sidebar-hover: #1a2a6c;
            --body-bg: #f4f7f6;
        }
        body {
            background-color: var(--body-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        /* Sidebar Menu Styling */
        .sidebar {
            width: 260px;
            height: 100vh;
            background-color: var(--sidebar-bg);
            position: fixed;
            top: 0;
            left: 0;
            color: white;
            padding-top: 20px;
        }
        .sidebar .brand {
            padding: 10px 25px;
            font-size: 22px;
            font-weight: bold;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
        }
        .sidebar a {
            display: block;
            color: rgba(255,255,255,0.8);
            padding: 12px 25px;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.3s;
        }
        .sidebar a:hover, .sidebar a.active {
            background-color: var(--sidebar-hover);
            color: white;
            border-left: 4px solid #00d2ff;
        }
        .sidebar a i {
            margin-right: 10px;
            width: 20px;
        }
        /* Main Content Styling */
        .main-content {
            margin-left: 260px;
            padding: 40px;
        }
        .card-custom {
            background: white;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 30px;
        }
        .welcome-text {
            color: var(--sidebar-bg);
            font-weight: 700;
        }
    </style>
</head>
<body>

    <%
        // Session Check: Redirect to login page if user is not logged in
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String adminUser = (String) session.getAttribute("admin");

        // Identify the current active tab (Default is 'overview')
        String currentView = request.getParameter("view");
        if (currentView == null) {
            currentView = "overview"; 
        }
    %>

    <div class="sidebar">
        <div class="brand"><i class="fa-solid fa-graduation-cap"></i> ATI Admin</div>
        <a href="dashboard.jsp?view=overview" class="<%= currentView.equals("overview") ? "active" : "" %>">
            <i class="fa-solid fa-chart-pie"></i> Overview
        </a>
        <a href="dashboard.jsp?view=notice" class="<%= currentView.equals("notice") ? "active" : "" %>">
            <i class="fa-solid fa-bullhorn"></i> Notices
        </a>
        <a href="dashboard.jsp?view=course" class="<%= currentView.equals("course") ? "active" : "" %>">
            <i class="fa-solid fa-book"></i> Courses
        </a>
        <a href="dashboard.jsp?view=gallery" class="<%= currentView.equals("gallery") ? "active" : "" %>">
            <i class="fa-solid fa-images"></i> Gallery
        </a>
        <a href="dashboard.jsp?view=result" class="<%= currentView.equals("result") ? "active" : "" %>">
            <i class="fa-solid fa-square-poll-vertical"></i> Add Result
        </a>
        <div class="position-absolute bottom-0 w-100">
            <a href="Logout.jsp" class="text-danger border-top border-secondary">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="welcome-text">Welcome, <%= adminUser %> 👋</h2>
            <span class="badge bg-primary px-3 py-2">ATI Badulla Admin Panel</span>
        </div>

        <div class="card-custom">
            
            <% if (currentView.equals("overview")) { %>
                <h3>Dashboard Overview</h3>
                <p class="text-muted">Welcome to the administration panel. Use the left sidebar menu to navigate and manage system content.</p>
                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded border-start border-primary border-4">
                            <h5>Quick Action</h5>
                            <a href="dashboard.jsp?view=notice" class="btn btn-sm btn-primary mt-2">Go to Notices</a>
                        </div>
                    </div>
                </div>

            <% } else if (currentView.equals("notice")) { %>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fa-solid fa-bullhorn text-primary"></i> All Active Notices</h4>
                    <a href="add_notice.jsp" class="btn btn-success"><i class="fa-solid fa-plus"></i> Add New Notice</a>
                </div>
                
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 10%;">ID</th>
                            <th style="width: 30%;">Notice Title</th>
                            <th style="width: 60%;">Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DBConnection.getConnection();
                                 Statement st = con.createStatement();
                                 ResultSet rs = st.executeQuery("SELECT * FROM notices ORDER BY id DESC")) {
                                    while(rs.next()) {
                        %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td class="fw-bold text-secondary"><%= rs.getString("title") %></td>
                                        <td><%= rs.getString("description") %></td>
                                    </tr>
                        <%
                                    }
                            } catch(Exception e) { e.printStackTrace(); }
                        %>
                    </tbody>
                </table>

            <% } else if (currentView.equals("course")) { %>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fa-solid fa-book text-success"></i> Manage Courses</h4>
                    <a href="add_course.jsp" class="btn btn-success"><i class="fa-solid fa-plus"></i> Add New Course</a>
                </div>
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Image</th>
                            <th>Course Name</th>
                            <th>Duration</th>
                            <th>Fee</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DBConnection.getConnection();
                                 Statement st = con.createStatement();
                                 ResultSet rs = st.executeQuery("SELECT * FROM courses")) {
                                    while(rs.next()) {
                        %>
                                    <tr>
                                        <td>
                                            <img src="<%= rs.getString("image_path") %>" style="width:60px; height:40px; object-fit:cover;" class="rounded shadow-sm">
                                        </td>
                                        <td class="fw-bold"><%= rs.getString("course_name") %></td>
                                        <td><%= rs.getString("duration") %></td>
                                        <td class="text-success fw-bold">Rs. <%= rs.getString("fee") %></td>
                                    </tr>
                        <%
                                    }
                            } catch(Exception e) { e.printStackTrace(); }
                        %>
                    </tbody>
                </table>

            <% } else if (currentView.equals("gallery")) { %>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fa-solid fa-images text-warning"></i> Slider & Gallery Images</h4>
                    <a href="upload_gallery.jsp" class="btn btn-success"><i class="fa-solid fa-upload"></i> Upload Image</a>
                </div>
                <p class="text-muted">The following images are currently used in the home page image carousel.</p>
                <div class="row g-3">
                    <%
                        try (Connection con = DBConnection.getConnection();
                             Statement st = con.createStatement();
                             ResultSet rs = st.executeQuery("SELECT * FROM gallery")) {
                                while(rs.next()) {
                    %>
                                <div class="col-md-3">
                                    <div class="card shadow-sm">
                                        <img src="<%= rs.getString("image_path") %>" class="card-img-top" style="height:150px; object-fit:cover;">
                                        <div class="card-body p-2 text-center">
                                            <span class="badge bg-info">Carousel Image</span>
                                        </div>
                                    </div>
                                </div>
                    <%
                                }
                        } catch(Exception e) { e.printStackTrace(); }
                    %>
                </div>

            <% } else if (currentView.equals("result")) { %>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fa-solid fa-square-poll-vertical text-info"></i> Student Exam Results</h4>
                    <a href="add_result.jsp" class="btn btn-success"><i class="fa-solid fa-plus"></i> Upload New Results</a>
                </div>
                <p class="text-muted">Click the 'Upload New Results' button to publish new student semester examination grades to the database.</p>
            <% } %>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>