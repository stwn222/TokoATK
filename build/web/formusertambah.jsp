<%-- 
    Document   : formusertambah
    Created on : Jul 2, 2025, 8:06:14 PM
    Author     : Andika
--%>
<%-- 
    Document   : formusertambah
    Created on : Jul 2, 2025, 12:15:00 AM
    Author     : Andika
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tambah User - Toko ATK</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            background-color: #1A1831; 
        }
        .header {
            background: white;
            border: 2px solid #A21232;
            color: black;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
            border: 2px solid #A21232;
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
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="password"]:focus {
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
        .btn-primary { 
            background-color: #131D4F; 
            color: white; 
        }
        .btn-success { 
            background-color: #28a745; 
            color: white; 
        }
        .btn-secondary { 
            background-color: #6c757d; 
            color: white; 
        }
        .btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .btn-actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #131D4F;
        }
        .required {
            color: #dc3545;
        }
        .form-info {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div>
            <h1>Tambah User Baru</h1>
            <p>Buat akun pengguna baru untuk sistem</p>
        </div>
        <div>
            <a href="home.jsp" class="btn btn-primary">Home</a>
            <a href="userlist.jsp" class="btn btn-secondary">👥 Daftar User</a>
        </div>
    </div>
    
    <div class="content">
        <h2 class="form-title">📝 Form Tambah User</h2>
        
        <div class="form-info">
            <strong>ℹ️ Informasi:</strong> Semua field yang bertanda <span class="required">*</span> wajib diisi
        </div>
        
        <%-- Tampilkan pesan error jika ada --%>
        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= session.getAttribute("error") %>
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>
        
        <form action="usertambah_proses.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">Username <span class="required">*</span></label>
                <input type="text" 
                       id="username" 
                       name="username" 
                       placeholder="Masukkan username (min. 3 karakter)"
                       required
                       minlength="3"
                       maxlength="20"
                       pattern="[a-zA-Z0-9_]+"
                       title="Username hanya boleh mengandung huruf, angka, dan underscore">
            </div>
            
            <div class="form-group">
                <label for="password">Password <span class="required">*</span></label>
                <input type="password" 
                       id="password" 
                       name="password" 
                       placeholder="Masukkan password (min. 6 karakter)"
                       required
                       minlength="6"
                       maxlength="50">
            </div>
            
            <div class="form-group">
                <label for="confirm_password">Konfirmasi Password <span class="required">*</span></label>
                <input type="password" 
                       id="confirm_password" 
                       name="confirm_password" 
                       placeholder="Ulangi password"
                       required
                       minlength="6"
                       maxlength="50">
            </div>
            
            <div class="form-group">
                <label for="fullname">Nama Lengkap <span class="required">*</span></label>
                <input type="text" 
                       id="fullname" 
                       name="fullname" 
                       placeholder="Masukkan nama lengkap"
                       required
                       maxlength="100">
            </div>
            
            <div class="btn-actions">
                <button type="submit" class="btn btn-success">✅ Simpan User</button>
                <a href="userlist.jsp" class="btn btn-secondary">❌ Batal</a>
            </div>
        </form>
    </div>
    
    <script>
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            const username = document.getElementById('username').value;
            const fullname = document.getElementById('fullname').value;
            
            // Validasi password match
            if (password !== confirmPassword) {
                alert('Password dan Konfirmasi Password tidak sama!');
                document.getElementById('confirm_password').focus();
                return false;
            }
            
            // Validasi username format
            const usernameRegex = /^[a-zA-Z0-9_]+$/;
            if (!usernameRegex.test(username)) {
                alert('Username hanya boleh mengandung huruf, angka, dan underscore!');
                document.getElementById('username').focus();
                return false;
            }
            
            // Validasi panjang minimal
            if (username.length < 3) {
                alert('Username minimal 3 karakter!');
                document.getElementById('username').focus();
                return false;
            }
            
            if (password.length < 6) {
                alert('Password minimal 6 karakter!');
                document.getElementById('password').focus();
                return false;
            }
            
            if (fullname.trim().length < 2) {
                alert('Nama lengkap minimal 2 karakter!');
                document.getElementById('fullname').focus();
                return false;
            }
            
            // Konfirmasi sebelum submit
            return confirm('Yakin ingin menambah user "' + fullname + '" dengan username "' + username + '"?');
        }
        
        // Auto hide alert messages after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
        
        // Real-time password confirmation validation
        document.getElementById('confirm_password').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#dc3545';
                this.title = 'Password tidak sama';
            } else {
                this.style.borderColor = '#ddd';
                this.title = '';
            }
        });
    </script>
</body>
</html>
