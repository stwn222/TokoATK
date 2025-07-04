<%-- 
    Document   : salesdetailtambah
    Created on : Jul 2, 2025, 1:19:53 AM
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
        String salesId = request.getParameter("salesId");
        String barangId = request.getParameter("barangId");
        int qty = Integer.parseInt(request.getParameter("qty"));
        int harga = Integer.parseInt(request.getParameter("harga"));
        
        Sales sales = new Sales();
        sales.baca(salesId);
        
        if (sales.addDetail(barangId, qty, harga)) {
            session.setAttribute("success", "Barang berhasil ditambahkan ke transaksi");
        } else {
            session.setAttribute("error", "Gagal menambahkan barang ke transaksi");
        }
        
        response.sendRedirect("formsalestambah.jsp?id=" + salesId);
    } catch (Exception e) {
        session.setAttribute("error", "Error: " + e.getMessage());
        response.sendRedirect("saleslist.jsp");
    }
%>