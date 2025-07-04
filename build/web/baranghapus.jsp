<%-- 
    Document   : baranghapus
    Created on : Jul 1, 2025, 11:58:03 PM
    Author     : Andika
--%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
    
    try {
        // Ambil ID dari parameter
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            session.setAttribute("error", "ID barang tidak valid!");
            response.sendRedirect("baranglist.jsp");
            return;
        }
        
        // Baca data barang untuk mendapatkan nama (untuk pesan)
        Barang barang = new Barang();
        if (barang.baca(id)) {
            String namaBarang = barang.getNama();
            
            // Hapus barang
            if (barang.hapus()) {
                session.setAttribute("success", "Barang '" + namaBarang + "' berhasil dihapus!");
            } else {
                session.setAttribute("error", "Gagal menghapus barang '" + namaBarang + "'!");
            }
        } else {
            session.setAttribute("error", "Data barang tidak ditemukan!");
        }
        
        response.sendRedirect("baranglist.jsp");
        
    } catch (Exception e) {
        session.setAttribute("error", "Terjadi kesalahan: " + e.getMessage());
        response.sendRedirect("baranglist.jsp");
    }
%>
