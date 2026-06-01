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
    <title>Add New Course - ATI Control Panel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; }
        .sidebar { height: 100vh; width: 260px; position: fixed; top: 0; left: 0; background-color: #0d1b52; color: #fff; padding-top: 20px; z-index: 100; box-shadow: 4px 0 10px rgba(0,0,0,0.1); }
        .sidebar a { padding: 12px 25px; text-decoration: none; font-size: 16px; color: #c2c7d0; display: flex; align-items: center; }
        .sidebar a:hover, .sidebar a.active { background-color: rgba(255,255,255,0.1); color: #fff; border-left: 4px solid #ffc107; }
        .main-content { margin-left: 260px; padding: 40px; }
        .form-card { background: #fff; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="px-4 mb-4"><h4>ATI CONTROL</h4></div>
        
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
        <a href="add_course.jsp" class="active"><i class="fa-solid fa-circle-plus"></i> Add Course</a>
        <a href="viewcourses.jsp"><i class="fa-solid fa-book-open"></i> View Courses</a>
        <a href="add_notice.jsp"><i class="fa-solid fa-bullhorn"></i> Add Notice</a>
        <a href="upload_gallery.jsp"><i class="fa-solid fa-images"></i> Upload Gallery</a>
        <a href="add_result.jsp"><i class="fa-solid fa-square-poll-vertical"></i> Add Result</a>
        
        <div class="position-absolute bottom-0 w-100 border-top border-secondary">
            <a href="logout.jsp" class="text-danger"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card form-card p-5">
                        <h2 class="text-center fw-bold mb-4" style="color: #0d1b52;">Create New Course</h2>
                        
                        <% if(request.getParameter("msg") != null) { %>
                            <div class="alert alert-success">Course Added Successfully!</div>
                        <% } %>
                        
                        <form action="AddCourseServlet" method="post">
                            <div class="mb-3">
                                <label class="form-label">Course Name</label>
                                <input type="text" name="course_name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Duration</label>
                                <input type="text" name="duration" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Course Fee</label>
                                <input type="text" name="fee" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100" style="background-color: #0d1b52;">Register Course</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>