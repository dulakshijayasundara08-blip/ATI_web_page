<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
    <title>View Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">

    <div class="container">
        <h2 class="mb-4">Course List</h2>
        
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Course Name</th>
                    <th>Duration</th>
                    <th>Fee</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection con = DBConnection.getConnection();
                         Statement st = con.createStatement();
                         ResultSet rs = st.executeQuery("SELECT * FROM courses")) {
                         
                        while(rs.next()){
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("course_name") %></td>
                    <td><%= rs.getString("duration") %></td>
                    <td><%= rs.getString("fee") %></td>
                    <td>
                        <a href="DeleteCourseServlet?id=<%= rs.getInt("id") %>" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Are you sure you want to delete this?')">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
        <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

</body>
</html>