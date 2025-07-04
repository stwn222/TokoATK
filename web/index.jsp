<%-- 
    Document   : index
    Created on : Jul 1, 2025, 11:53:41 PM
    Author     : Andika
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek apakah user sudah login
    if(session.getAttribute("fullname") == null) {
        // Belum login, redirect ke form login
        response.sendRedirect("formlogin.jsp");
    } else {
        // Sudah login, redirect ke home
        response.sendRedirect("home.jsp");
    }
%>