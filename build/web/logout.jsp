<%-- 
    Document   : logout
    Created on : Jul 2, 2025, 12:02:32 AM
    Author     : Andika
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Hapus semua session
    session.invalidate();
    
    // Set pesan logout berhasil
    HttpSession newSession = request.getSession(true);
    newSession.setAttribute("success", "Anda telah berhasil logout!");
    
    // Redirect ke halaman login
    response.sendRedirect("formlogin.jsp");
%>
