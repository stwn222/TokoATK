<%-- 
    Document   : formbarangedit
    Created on : Jul 1, 2025, 11:57:25 PM
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
    
    // Ambil ID dari parameter
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("baranglist.jsp");
        return;
    }
    
    // Baca data barang
    Barang barang = new Barang();
    if (!barang.baca(id)) {
        session.setAttribute("error", "Data barang tidak ditemukan!");
        response.sendRedirect("baranglist.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Barang - Toko ATK</title>
    <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #1A1831;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input, select {
                width: 300px;
                padding: 8px;
                border: 1px solid #ddd;
            }
            .btn {
                padding: 10px 20px;
                margin: 5px;
                text-decoration: none;
                border: none;
                cursor: pointer;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 20px auto;
                width: 500px;
                background: white;
                padding: 20px;
                border: 1px solid #A21232;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
                text-align: center;
            }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
                input, select{
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        input:focus , select:focus{
            outline: none;
            border-color: #A21232;
            box-shadow: 0 0 0 3px rgba(19, 29, 79, 0.1);
        }
        .btn { 
            padding: 12px 20px;
            margin: 5px;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            display: inline-block;
            transition: all 0.3s;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Edit Barang</h1>
        <a href="baranglist.jsp" class="btn btn-secondary">Kembali ke Daftar</a>
    </div>
    
    <hr>
    
    <%-- Tampilkan pesan error jika ada --%>
    <% if (session.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= session.getAttribute("error") %>
        </div>
        <% session.removeAttribute("error"); %>
    <% } %>
    <div class="container">
    <form action="barangedit.jsp" method="post">
        <div class="form-group">
            <label for="id">ID Barang:</label>
            <input type="text" id="id" name="id" value="<%= barang.getId() %>" readonly>
        </div>
        
        <div class="form-group">
            <label for="nama">Nama Barang:</label>
            <input type="text" id="nama" name="nama" value="<%= barang.getNama() %>" required>
        </div>
        
        <div class="form-group">
            <label for="jenis">Jenis:</label>
            <select id="jenis" name="jenis" required>
                <option value="">-- Pilih Jenis --</option>
                <option value="Alat Tulis" <%= "Alat Tulis".equals(barang.getJenis()) ? "selected" : "" %>>Alat Tulis</option>
                <option value="Buku" <%= "Buku".equals(barang.getJenis()) ? "selected" : "" %>>Buku</option>
                <option value="Kertas" <%= "Kertas".equals(barang.getJenis()) ? "selected" : "" %>>Kertas</option>
                <option value="Peralatan Kantor" <%= "Peralatan Kantor".equals(barang.getJenis()) ? "selected" : "" %>>Peralatan Kantor</option>
                <option value="Lainnya" <%= "Lainnya".equals(barang.getJenis()) ? "selected" : "" %>>Lainnya</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="harga">Harga:</label>
            <input type="number" id="harga" name="harga" value="<%= barang.getHarga() %>" min="0" required>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-warning">Update Barang</button>
            <a href="baranglist.jsp" class="btn btn-secondary">Batal</a>
        </div>
    </form>
        </div>
    
    <script>
        // Auto focus ke field nama
        document.getElementById('nama').focus();
        
        // Format input harga
        document.getElementById('harga').addEventListener('input', function(e) {
            let value = e.target.value;
            if (value < 0) {
                e.target.value = 0;
            }
        });
    </script>
</body>
</html>
