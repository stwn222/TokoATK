<%-- 
    Document   : salesdetailhapus
    Created on : Jul 2, 2025, 1:20:20 AM
    Author     : Andika
--%>
<%@page import="tokoatk.SalesDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        String salesId = request.getParameter("salesId");
        
        SalesDetail detail = new SalesDetail();
        if (detail.baca(id)) {
            if (detail.hapus()) {
                session.setAttribute("success", "Barang berhasil dihapus dari transaksi");
            } else {
                session.setAttribute("error", "Gagal menghapus barang dari transaksi");
            }
        } else {
            session.setAttribute("error", "Detail transaksi tidak ditemukan");
        }
        
        response.sendRedirect("formsalestambah.jsp?id=" + salesId);
    } catch (Exception e) {
        session.setAttribute("error", "Error: " + e.getMessage());
        response.sendRedirect("saleslist.jsp");
    }
%>
