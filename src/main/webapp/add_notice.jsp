<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
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
    <title>Add New Notice - ATI Control Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f6f9; }
        .sidebar { height: 100vh; width: 260px; position: fixed; background-color: #0d1b52; color: #fff; padding-top: 20px; z-index: 100; }
        .sidebar a { padding: 12px 25px; text-decoration: none; color: #c2c7d0; display: flex; align-items: center; }
        .sidebar a:hover, .sidebar a.active { background-color: rgba(255,255,255,0.1); color: #fff; border-left: 4px solid #ffc107; }
        .main-content { margin-left: 260px; padding: 40px; }
        .form-card { background: white; border: none; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="px-4 mb-4"><h4>ATI CONTROL</h4></div>
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-chart-pie me-2"></i> Dashboard</a>
        <a href="add_notice.jsp" class="active"><i class="fa-solid fa-bullhorn me-2"></i> Add Notice</a>
        <a href="logout.jsp" class="text-danger mt-5 px-4"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a>
    </div>

    <div class="main-content">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card form-card p-4">
                        <h2 class="fw-bold mb-4">Publish New Announcement</h2>
                        <form action="add_notice.jsp" method="post">
                            <div class="mb-3">
                                <label class="form-label">Notice Title</label>
                                <input type="text" name="title" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="4" required></textarea>
                            </div>
                            <button type="submit" name="btn_add" class="btn btn-primary w-100">Broadcast Notice</button>
                        </form>

                        <%
                            if(request.getParameter("btn_add") != null) {
                                String title = request.getParameter("title");
                                String desc = request.getParameter("description");
                                String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

                                try (Connection con = DBConnection.getConnection()) {
                                    String sql = "INSERT INTO notices (title, description, date) VALUES (?, ?, ?)";
                                    PreparedStatement pst = con.prepareStatement(sql);
                                    pst.setString(1, title);
                                    pst.setString(2, desc);
                                    pst.setString(3, date);
                                    pst.executeUpdate();
                                    out.println("<div class='alert alert-success mt-3'>Notice Published Successfully!</div>");
                                } catch(Exception e) {
                                    out.println("<div class='alert alert-danger mt-3'>Error: " + e.getMessage() + "</div>");
                                }
                            }
                        %>
                    </div>

                    <div class="card form-card p-4 mt-5">
                        <h3 class="fw-bold mb-3">Published Notices</h3>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    try (Connection con = DBConnection.getConnection();
                                         Statement st = con.createStatement();
                                         ResultSet rs = st.executeQuery("SELECT * FROM notices ORDER BY id DESC")) {
                                        while(rs.next()){
                                %>
                                <tr>
                                    <td><%= rs.getString("title") %></td>
                                    <td><%= rs.getString("date") %></td>
                                    <td>
                                        <a href="DeleteNoticeServlet?id=<%= rs.getInt("id") %>" 
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
</body>
</html>
<a href="admin_dashboard.jsp"></a>