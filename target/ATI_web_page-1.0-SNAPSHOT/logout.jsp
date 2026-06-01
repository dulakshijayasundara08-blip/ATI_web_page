<%-- 
    Document   : Logout
    Created on : May 19, 2026, 6:55:18 PM
    Author     : my
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Remove the admin attribute from the session
    session.removeAttribute("admin");
    
    // 2. Invalidate the entire session completely
    session.invalidate();
    
    // 3. Redirect back to the login page
    response.sendRedirect("login.jsp");
%>