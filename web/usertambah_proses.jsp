<%-- 
    Document   : usertambah_proses
    Created on : Jul 2, 2025, 12:25:00 AM
    Author     : Andika
--%>

<%@page import="tokoatk.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
    
    try {
        // Ambil parameter dari form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String fullname = request.getParameter("fullname");
        
        // Validasi parameter tidak kosong
        if(username == null || username.trim().isEmpty() ||
           password == null || password.trim().isEmpty() ||
           confirmPassword == null || confirmPassword.trim().isEmpty() ||
           fullname == null || fullname.trim().isEmpty()) {
            session.setAttribute("error", "Semua field harus diisi!");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Trim whitespace
        username = username.trim();
        password = password.trim();
        confirmPassword = confirmPassword.trim();
        fullname = fullname.trim();
        
        // Validasi panjang username
        if(username.length() < 3 || username.length() > 20) {
            session.setAttribute("error", "Username harus antara 3-20 karakter!");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Validasi format username (hanya huruf, angka, underscore)
        if(!username.matches("^[a-zA-Z0-9_]+$")) {
            session.setAttribute("error", "Username hanya boleh mengandung huruf, angka, dan underscore!");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Validasi panjang password
        if(password.length() < 6 || password.length() > 50) {
            session.setAttribute("error", "Password harus antara 6-50 karakter!");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Validasi konfirmasi password
        if(!password.equals(confirmPassword)) {
            session.setAttribute("error", "Password dan konfirmasi password tidak sama!");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Validasi panjang nama lengkap
        if(fullname.length() < 2 || fullname.length() > 100) {
            session.setAttribute("error", "Nama lengkap harus antara 2-100 karakter!");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Cek apakah username sudah ada
        User existingUser = User.getByUsername(username);
        if(existingUser != null) {
            session.setAttribute("error", "Username '" + username + "' sudah digunakan! Pilih username lain.");
            response.sendRedirect("formusertambah.jsp");
            return;
        }
        
        // Buat user baru
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setFullname(fullname);
        
        // Simpan ke database/file
        boolean success = newUser.tambah();
        
        if(success) {
            // Berhasil ditambahkan
            session.setAttribute("success", "User '" + fullname + "' berhasil ditambahkan dengan username '" + username + "'!");
            response.sendRedirect("userlist.jsp");
        } else {
            // Gagal menyimpan
            session.setAttribute("error", "Gagal menambahkan user! Silakan coba lagi.");
            response.sendRedirect("formusertambah.jsp");
        }
        
    } catch(Exception e) {
        // Handle error
        session.setAttribute("error", "Terjadi kesalahan sistem: " + e.getMessage());
        response.sendRedirect("formusertambah.jsp");
        
        // Log error untuk debugging
        System.err.println("Error in usertambah_proses.jsp: " + e.getMessage());
        e.printStackTrace();
    }
%>
