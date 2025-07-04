<%-- 
    Document   : userlist
    Created on : Jul 2, 2025, 12:02:51 AM
    Author     : Andika
--%>

<%@page import="tokoatk.User"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
    
    // Ambil data users
    ArrayList<User> list = User.getList();
    request.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Daftar User - Toko ATK</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #1A1831; }
        .header {
            background: white;
            color: black;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 2px solid #A21232;
        }
        .content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        table { 
            border-collapse: collapse; 
            width: 100%; 
            margin-top: 20px;
        }
        th, td { 
            border: 1px solid black; 
            padding: 12px; 
            text-align: center; 
        }
        th { 
            background: #A21232;
            color: white;
            
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        .btn { 
                padding: 5px 10px;
                margin: 2px;
                text-decoration: none;
                border-radius: 5px;
                border: none;
                cursor: pointer;
        }
        .btn-primary { background-color: #131D4F; color: white; }
        .btn-success { background-color: #28a745; color: white; }
        .btn-danger { background-color: #dc3545; color: white; }
        .btn-warning { background-color: #ffc107; color: black; }
        .btn:hover { transform: translateY(-2px); }
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
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="header">
        <div>
            <h1>Manajemen User</h1>
            <p>Kelola data pengguna sistem</p>
        </div>
        <div>
            <a href="home.jsp" class="btn btn-primary">Home</a>
            <a href="formusertambah.jsp" class="btn btn-success">➕ Tambah User</a>
        </div>
    </div>
    
    <div class="content">
        <%-- Tampilkan pesan success jika ada --%>
        <% if (session.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= session.getAttribute("success") %>
            </div>
            <% session.removeAttribute("success"); %>
        <% } %>
        
        <%-- Tampilkan pesan error jika ada --%>
        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= session.getAttribute("error") %>
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>
        
        <c:if test="${empty list}">
            <div class="no-data">
                <h3>📭 Tidak ada data user</h3>
                <p>Belum ada user yang terdaftar dalam sistem</p>
                <a href="formusertambah.jsp" class="btn btn-success">Tambah User Pertama</a>
            </div>
        </c:if>
        
        <c:if test="${not empty list}">
            <div style="margin-bottom: 15px;">
                <strong>Total User: ${list.size()}</strong>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Username</th>
                        <th>Nama Lengkap</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${list}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <strong>${user.getUsername()}</strong>
                                <c:if test="${user.getUsername() == sessionScope.username}">
                                    <span style="color: #28a745; font-size: 12px;">(Anda)</span>
                                </c:if>
                            </td>
                            <td>${user.getFullname()}</td>
                            <td>
                                <a href="formuseredit.jsp?username=${user.getUsername()}" 
                                   class="btn btn-warning">✏️ Edit</a>
                                <c:if test="${user.getUsername() != sessionScope.username}">
                                    <a href="userhapus.jsp?username=${user.getUsername()}" 
                                       onclick="return confirm('Yakin ingin menghapus user ${user.getFullname()}?')" 
                                       class="btn btn-danger">🗑️ Hapus</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
    
    <script>
        // Auto hide alert messages after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html>
