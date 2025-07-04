<%-- 
    Document   : barangtambah
    Created on : Jul 1, 2025, 11:56:59 PM
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
        // Ambil parameter dari form
        String id = request.getParameter("id");
        String nama = request.getParameter("nama");
        String jenis = request.getParameter("jenis");
        String hargaStr = request.getParameter("harga");
        
        // Validasi input
        if (id == null || nama == null || jenis == null || hargaStr == null ||
            id.trim().isEmpty() || nama.trim().isEmpty() || jenis.trim().isEmpty() || hargaStr.trim().isEmpty()) {
            
            session.setAttribute("error", "Semua field harus diisi!");
            response.sendRedirect("formbarangtambah.jsp");
            return;
        }
        
        // Convert harga ke integer
        Integer harga = Integer.parseInt(hargaStr);
        
        if (harga < 0) {
            session.setAttribute("error", "Harga tidak boleh negatif!");
            response.sendRedirect("formbarangtambah.jsp");
            return;
        }
        
        // Buat object barang baru
        Barang barang = new Barang();
        barang.id = id.trim();
        barang.nama = nama.trim();
        barang.jenis = jenis.trim();
        barang.harga = harga;
        
        // Simpan ke database
        if (barang.tambah()) {
            session.setAttribute("success", "Barang berhasil ditambahkan!");
            response.sendRedirect("baranglist.jsp");
        } else {
            session.setAttribute("error", "Gagal menambahkan barang. ID mungkin sudah ada.");
            response.sendRedirect("formbarangtambah.jsp");
        }
        
    } catch (NumberFormatException e) {
        session.setAttribute("error", "Format harga tidak valid!");
        response.sendRedirect("formbarangtambah.jsp");
    } catch (Exception e) {
        session.setAttribute("error", "Terjadi kesalahan: " + e.getMessage());
        response.sendRedirect("formbarangtambah.jsp");
    }
%>
