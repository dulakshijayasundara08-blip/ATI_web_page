<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>

<%-- 🛡️ Session Security Validation --%>
<%
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
    <title>Upload Student Result - ATI Control Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; overflow-x: hidden; }
        .sidebar { height: 100vh; width: 260px; position: fixed; top: 0; left: 0; background-color: #0d1b52; color: #fff; padding-top: 20px; z-index: 100; box-shadow: 4px 0 10px rgba(0,0,0,0.1); }
        .sidebar .brand-area { padding: 10px 25px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 20px; }
        .sidebar a { padding: 12px 25px; text-decoration: none; font-size: 16px; color: #c2c7d0; display: flex; align-items: center; transition: all 0.3s; }
        .sidebar a:hover, .sidebar a.active { background-color: rgba(255,255,255,0.1); color: #fff; border-left: 4px solid #ffc107; }
        .main-content { margin-left: 260px; padding: 40px; }
        .form-card { background: white; border: none; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="brand-area">
            <h4 class="fw-bold m-0 text-warning"><i class="fa-solid fa-gauge me-2"></i>ATI CONTROL</h4>
        </div>
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-chart-pie me-2"></i> Dashboard</a>
        <a href="add_result.jsp" class="active"><i class="fa-solid fa-square-poll-vertical me-2"></i> Add Result</a>
        <div class="position-absolute bottom-0 w-100 border-top border-secondary">
            <a href="logout.jsp" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card form-card p-4 p-sm-5 bg-white">
                        <h2 class="fw-bold text-center mb-4" style="color: #0d1b52;">Upload Student Result</h2>
                        <form action="AddResultServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Student Index No:</label>
                                <input type="text" name="student_index" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Subject Name:</label>
                                <input type="text" name="subject" class="form-control" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold">Result / Grade:</label>
                                <input type="text" name="grade" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-info text-white w-100 py-2 fw-bold">Publish Result</button>
                        </form>
                    </div>

                    <div class="card form-card p-4 mt-5">
                        <h3 class="fw-bold mb-3">Published Results</h3>
                        <table class="table table-bordered table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th>Index</th>
                                    <th>Subject</th>
                                    <th>Grade</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    try (Connection con = DBConnection.getConnection();
                                         Statement st = con.createStatement();
                                         ResultSet rs = st.executeQuery("SELECT * FROM results")) {
                                        while(rs.next()){
                                %>
                                <tr>
                                    <td><%= rs.getString("student_index") %></td>
                                    <td><%= rs.getString("subject") %></td>
                                    <td><%= rs.getString("grade") %></td>
                                    <td>
                                        <a href="DeleteResultServlet?id=<%= rs.getInt("id") %>" 
                                           class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">
                                           <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% } } catch(Exception e) { e.printStackTrace(); } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>