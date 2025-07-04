<%-- 
    Document   : home
    Created on : Jul 1, 2025, 11:58:11 PM
    Author     : Andika
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
    
    String fullname = session.getAttribute("fullname").toString();
    String username = session.getAttribute("username").toString();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard - Toko ATK</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            background-color: #1A1831;
        }
        .header {
            background-color: white;
            color: black;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-bottom: 2px solid #A21232;
        }
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 28px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .welcome-card {
            background: white;
            padding: 30px;
            border: 1px solid #A21232;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .menu-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            border: 2px solid #A21232;
        }
        .menu-card .icon {
            font-size: 48px;
            margin-bottom: 15px;
            display: block;
        }
        .menu-card h3 {
            margin: 15px 0 10px 0;
            color: #333;
            font-size: 20px;
        }
        .menu-card p {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.5;
        }
        .menu-card a {
            display: inline-block;
            padding: 12px 25px;
            background: #A21232;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: transform 0.2s;
        }
        .menu-card a:hover {
            transform: scale(1.1);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            border-color: #1A1831;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
        }
        .btn-logout:hover {
            background-color: #c82333;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }
        .stat-label {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Toko ATK</h1>
            <div class="user-info">
                <span>Selamat datang, <strong><%= fullname %></strong></span>
                <a href="logout.jsp" class="btn btn-logout">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="container">
        <%-- Tampilkan pesan success jika ada --%>
        <% if (session.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= session.getAttribute("success") %>
            </div>
            <% session.removeAttribute("success"); %>
        <% } %>
        
        <div class="welcome-card">
            <h2>Selamat Datang di Sistem Manajemen Toko ATK</h2>
            <p>Kelola data barang, user, dan transaksi toko Anda dengan mudah</p>
            <p><strong>Login sebagai:</strong> <%= username %> (<%= fullname %>)</p>
        </div>
        <div class="menu-grid">
            <div class="menu-card">
                <span class="icon">📦</span>
                <h3>Data Barang</h3>
                <p>Kelola data barang ATK, tambah, edit, dan hapus data barang</p>
                <a href="baranglist.jsp">Kelola Barang</a>
            </div>
            
            <div class="menu-card">
                <span class="icon">👥</span>
                <h3>Manajemen User</h3>
                <p>Kelola data pengguna sistem, tambah user baru, edit profil</p>
                <a href="userlist.jsp">Kelola Users</a>
            </div>
            
            <div class="menu-card">
                <span class="icon">🛒</span>
                <h3>Transaksi Penjualan</h3>
                <p>Catat dan kelola transaksi penjualan barang ATK</p>
                <a href="saleslist.jsp">Penjualan</a>
            </div>
            
<!--            <div class="menu-card">
                <span class="icon">📥</span>
                <h3>Stock Barang</h3>
                <p>Kelola stok barang masuk dan keluar</p>
                <a href="#" onclick="alert('Fitur akan segera tersedia!')">Kelola Stock</a>
            </div>-->
        </div>
    </div>
    
    <script>
        // Auto hide success message after 5 seconds
        setTimeout(function() {
            const successAlert = document.querySelector('.alert-success');
            if (successAlert) {
                successAlert.style.display = 'none';
            }
        }, 5000);
    </script>
</body>
</html>