<%-- 
    Document   : baranghapus
    Created on : Jul 1, 2025, 11:58:03 PM
    Author     : Andika
--%>
<%@page import="tokoatk.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
    
    try {
        // Ambil ID dari parameter
        String username = request.getParameter("username");
        
        if (username == null || username.trim().isEmpty()) {
            session.setAttribute("error", "User tidak valid!");
            response.sendRedirect("userlist.jsp");
            return;
        }
        
        // Baca data barang untuk mendapatkan nama (untuk pesan)
        User User = new User();
        if (User.baca(username)) {
            String user = User.getUsername();
            
            // Hapus barang
            if (User.hapus()) {
                session.setAttribute("success", "User '" + user + "' berhasil dihapus!");
            } else {
                session.setAttribute("error", "Gagal menghapus User '" + user + "'!");
            }
        } else {
            session.setAttribute("error", "Userename tidak ditemukan!");
        }
        
        response.sendRedirect("userlist.jsp");
        
    } catch (Exception e) {
        session.setAttribute("error", "Terjadi kesalahan: " + e.getMessage());
        response.sendRedirect("baranglist.jsp");
    }
%>
