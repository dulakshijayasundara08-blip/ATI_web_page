<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>

<%
    // Visitor Counter Logic
    Integer counter = (Integer)application.getAttribute("counter");
    if(counter == null){ counter = 1; }
    else { counter++; }
    application.setAttribute("counter", counter);
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Inside Index</title>
</head>
<body>

    <marquee>
        <%
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT title FROM notices ORDER BY id DESC")) {
            while(rs.next()){
                out.print(rs.getString("title") + " | ");
            }
        } catch(Exception e) { e.printStackTrace(); }
        %>
    </marquee>

    <div>
        <%
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT image_path FROM gallery WHERE is_carousel=1 ORDER BY upload_date DESC LIMIT 10")) {
            while(rs.next()){
        %>
            <img src="<%= rs.getString("image_path") %>" width="400" alt="Gallery Image">
        <%
            }
        } catch(Exception e) { e.printStackTrace(); }
        %>
    </div>

    <h3>Total Visitors: <%= counter %></h3>

</body>
</html>