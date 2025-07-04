<%-- 
    Document   : saleshapus
    Created on : Jul 4, 2025
    Author     : Andika
--%>
<%@page import="tokoatk.Sales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }

    String id = request.getParameter("id");
    boolean berhasil = false;
    String pesan = "";
    
    try {
        if (id != null && !id.trim().isEmpty()) {
            Sales sales = new Sales();
            sales.baca(id);
            
            if (sales.hapus()) {
                berhasil = true;
                pesan = "Transaksi berhasil dihapus!";
            } else {
                pesan = "Gagal menghapus transaksi!";
            }
        } else {
            pesan = "ID transaksi tidak valid!";
        }
    } catch (Exception e) {
        pesan = "Error: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hapus Transaksi - Toko ATK</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #254D70;
            }
            .container {
                background: #EFE4D2;
                padding: 30px;
                border-radius: 10px;
                text-align: center;
                max-width: 500px;
                margin: 50px auto;
            }
            .success {
                color: #28a745;
                font-size: 18px;
                font-weight: bold;
            }
            .error {
                color: #dc3545;
                font-size: 18px;
                font-weight: bold;
            }
            .btn {
                padding: 10px 20px;
                margin: 10px;
                text-decoration: none;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                display: inline-block;
            }
            .btn-primary {
                background-color: #131D4F;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Hasil Hapus Transaksi</h2>
            
            <% if (berhasil) { %>
                <div class="success">
                    <p>✓ <%=pesan%></p>
                </div>
            <% } else { %>
                <div class="error">
                    <p>✗ <%=pesan%></p>
                </div>
            <% } %>
            
            <a href="saleslist.jsp" class="btn btn-primary">Kembali ke Daftar Transaksi</a>
        </div>
    </body>
</html>