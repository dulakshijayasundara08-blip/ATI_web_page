<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session Security Validation
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username");
    
    if (role == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ATI Control</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f6f9; }
        .sidebar { height: 100vh; width: 260px; position: fixed; top: 0; left: 0; background-color: #0d1b52; color: #fff; padding-top: 20px; box-shadow: 2px 0 5px rgba(0,0,0,0.1); }
        .sidebar a { padding: 14px 25px; text-decoration: none; color: #c2c7d0; display: flex; align-items: center; transition: 0.3s; }
        .sidebar a:hover, .sidebar a.active { background-color: rgba(255,255,255,0.1); color: #fff; border-left: 4px solid #ffc107; }
        .main-content { margin-left: 260px; padding: 40px; }
        .quick-btn { border-radius: 12px; padding: 20px; font-weight: 600; display: flex; align-items: center; justify-content: center; gap: 10px; transition: 0.3s; }
        .quick-btn:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .logout-btn { color: #ff6b6b !important; margin-top: 20px; border-top: 1px solid #2c3e50; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="px-4 mb-4 text-white"><h4>ATI CONTROL</h4></div>
        
        <a href="admin_dashboard.jsp" class="active"><i class="fa-solid fa-gauge me-3"></i> Dashboard</a>
        <a href="add_course.jsp"><i class="fa-solid fa-plus me-3"></i> Add Course</a>
        <a href="viewcourses.jsp"><i class="fa-solid fa-list me-3"></i> Manage Courses</a>
        <a href="add_notice.jsp"><i class="fa-solid fa-bullhorn me-3"></i> Add Notice</a>
        <a href="upload_gallery.jsp"><i class="fa-solid fa-images me-3"></i> Gallery</a> <a href="add_result.jsp"><i class="fa-solid fa-poll me-3"></i> Add Result</a>
        
        <a href="logout.jsp" class="logout-btn"><i class="fa-solid fa-right-from-bracket me-3"></i> Logout</a>
    </div>

    <div class="main-content">
        <h2 class="fw-bold mb-4">Welcome Back, <%= (username != null) ? username : "Administrator" %>!</h2>
        <p class="text-muted mb-5">Select an option below to manage the ATI Badulla website content.</p>
        
        <div class="row g-4">
            <div class="col-md-4"><a href="add_course.jsp" class="btn btn-primary quick-btn"><i class="fa-solid fa-circle-plus"></i> Add New Course</a></div>
            <div class="col-md-4"><a href="viewcourses.jsp" class="btn btn-outline-primary quick-btn"><i class="fa-solid fa-pen-to-square"></i> Manage Courses</a></div>
            <div class="col-md-4"><a href="add_notice.jsp" class="btn btn-success quick-btn text-white"><i class="fa-solid fa-bullhorn"></i> Post Announcement</a></div>
            <div class="col-md-4"><a href="upload_gallery.jsp" class="btn btn-info quick-btn text-white"><i class="fa-solid fa-images"></i> Manage Gallery</a></div>
            <div class="col-md-4"><a href="add_result.jsp" class="btn btn-warning quick-btn"><i class="fa-solid fa-square-poll-vertical"></i> Enter Results</a></div>
        </div>
    </div>

</body>
</html>