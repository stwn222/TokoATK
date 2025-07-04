<%-- 
    Document   : login
    Created on : Jul 2, 2025, 12:01:55 AM
    Author     : Andika
--%>
<%@page import="tokoatk.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        // Ambil parameter dari form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validasi input
        if (username == null || password == null || 
            username.trim().isEmpty() || password.trim().isEmpty()) {
            
            session.setAttribute("error", "Username dan password harus diisi!");
            response.sendRedirect("formlogin.jsp");
            return;
        }
        
        // Proses login
        User user = new User();
        if (user.login(username.trim(), password)) {
            // Login berhasil
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullname", user.getFullname());
            session.setAttribute("success", "Login berhasil! Selamat datang " + user.getFullname());
            
            response.sendRedirect("home.jsp");
        } else {
            // Login gagal
            session.setAttribute("error", "Username atau password salah!");
            response.sendRedirect("formlogin.jsp");
        }
        
    } catch (Exception e) {
        // Error handling
        session.setAttribute("error", "Terjadi kesalahan sistem: " + e.getMessage());
        response.sendRedirect("formlogin.jsp");
    }
%>
