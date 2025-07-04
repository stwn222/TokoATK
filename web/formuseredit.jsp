<%-- 
    Document   : formuseredit
    Created on : Jul 2, 2025, 8:22:00 PM
    Author     : Andika
--%>

<%-- 
    Document   : formuseredit
    Created on : Jul 2, 2025, 12:20:00 AM
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
    
    // Ambil parameter username
    String username = request.getParameter("username");
    if(username == null || username.trim().isEmpty()) {
        response.sendRedirect("userlist.jsp");
        return;
    }
    
    // Ambil data user berdasarkan username
    User user = User.getByUsername(username);
    if(user == null) {
        session.setAttribute("error", "User tidak ditemukan!");
        response.sendRedirect("userlist.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit User - Toko ATK</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            background-color: #1A1831; 
        }
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
        input:disabled {
            background-color: #e9ecef;
            cursor: not-allowed;
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
        .btn-warning { 
            background-color: #20615B; 
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
            background-color: #20615B;
            border: 1px solid #A21232;
            color: white;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .user-info {
            background-color: #20615B;
            border: 1px solid #A21232;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .password-section {
            border-top: 2px solid #ddd;
            padding-top: 20px;
            margin-top: 20px;
        }
        .checkbox-group {
            margin-bottom: 15px;
        }
        .checkbox-group input[type="checkbox"] {
            margin-right: 8px;
            transform: scale(1.2);
        }
        .checkbox-group label {
            display: inline-block;
            font-weight: normal;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="header">
        <div>
            <h1>Edit User</h1>
            <p>Ubah data pengguna sistem</p>
        </div>
        <div>
            <a href="home.jsp" class="btn btn-primary">Home</a>
            <a href="userlist.jsp" class="btn btn-secondary">👥 Daftar User</a>
        </div>
    </div>
    
    <div class="content">
        <h2 class="form-title">✏️ Edit User: <%= user.getFullname() %></h2>
        
        <div class="user-info">
            <strong>👤 Mengedit user:</strong> <%= user.getUsername() %>
            <% if(user.getUsername().equals(session.getAttribute("username"))) { %>
                <span style="color: #28a745; font-weight: bold;">(Anda sedang mengedit profil sendiri)</span>
            <% } %>
        </div>
        
        <div class="form-info">
            <strong>ℹ️ Informasi:</strong> Field yang bertanda <span class="required">*</span> wajib diisi. 
            Username tidak dapat diubah untuk menjaga integritas data.
        </div>
        
        <%-- Tampilkan pesan error jika ada --%>
        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= session.getAttribute("error") %>
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>
        
        <form action="useredit_proses.jsp" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="original_username" value="<%= user.getUsername() %>">
            
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" 
                       id="username" 
                       name="username" 
                       value="<%= user.getUsername() %>"
                       disabled
                       title="Username tidak dapat diubah">
                <small style="color: #666; font-style: italic;">Username tidak dapat diubah</small>
            </div>
            
            <div class="form-group">
                <label for="fullname">Nama Lengkap <span class="required">*</span></label>
                <input type="text" 
                       id="fullname" 
                       name="fullname" 
                       value="<%= user.getFullname() %>"
                       placeholder="Masukkan nama lengkap"
                       required
                       maxlength="100">
            </div>
            
            <div class="password-section">
                <h3 style="color: #131D4F; margin-bottom: 15px;">🔒 Ubah Password</h3>
                
                <div class="checkbox-group">
                    <input type="checkbox" id="change_password" name="change_password" onchange="togglePasswordFields()">
                    <label for="change_password">Saya ingin mengubah password</label>
                </div>
                
                <div id="password_fields" style="display: none;">
                    <div class="form-group">
                        <label for="new_password">Password Baru</label>
                        <input type="password" 
                               id="new_password" 
                               name="new_password" 
                               placeholder="Masukkan password baru (min. 6 karakter)"
                               minlength="6"
                               maxlength="50"
                               disabled>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirm_password">Konfirmasi Password Baru</label>
                        <input type="password" 
                               id="confirm_password" 
                               name="confirm_password" 
                               placeholder="Ulangi password baru"
                               minlength="6"
                               maxlength="50"
                               disabled>
                    </div>
                </div>
            </div>
            
            <div class="btn-actions">
                <button type="submit" class="btn btn-warning">Update User</button>
                <a href="userlist.jsp" class="btn btn-secondary">Batal</a>
            </div>
        </form>
    </div>
    
    <script>
        function togglePasswordFields() {
            const checkbox = document.getElementById('change_password');
            const passwordFields = document.getElementById('password_fields');
            const newPassword = document.getElementById('new_password');
            const confirmPassword = document.getElementById('confirm_password');
            
            if (checkbox.checked) {
                passwordFields.style.display = 'block';
                newPassword.disabled = false;
                confirmPassword.disabled = false;
                newPassword.setAttribute('required', 'required');
                confirmPassword.setAttribute('required', 'required');
            } else {
                passwordFields.style.display = 'none';
                newPassword.disabled = true;
                confirmPassword.disabled = true;
                newPassword.removeAttribute('required');
                confirmPassword.removeAttribute('required');
                newPassword.value = '';
                confirmPassword.value = '';
            }
        }
        
        function validateForm() {
            const fullname = document.getElementById('fullname').value;
            const changePassword = document.getElementById('change_password').checked;
            
            // Validasi nama lengkap
            if (fullname.trim().length < 2) {
                alert('Nama lengkap minimal 2 karakter!');
                document.getElementById('fullname').focus();
                return false;
            }
            
            // Jika ingin mengubah password
            if (changePassword) {
                const newPassword = document.getElementById('new_password').value;
                const confirmPassword = document.getElementById('confirm_password').value;
                
                if (newPassword.length < 6) {
                    alert('Password baru minimal 6 karakter!');
                    document.getElementById('new_password').focus();
                    return false;
                }
                
                if (newPassword !== confirmPassword) {
                    alert('Password baru dan konfirmasi password tidak sama!');
                    document.getElementById('confirm_password').focus();
                    return false;
                }
            }
            
            // Konfirmasi sebelum submit
            const confirmMessage = changePassword ? 
                'Yakin ingin mengupdate user "' + fullname + '" beserta passwordnya?' :
                'Yakin ingin mengupdate user "' + fullname + '"?';
                
            return confirm(confirmMessage);
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
            const newPassword = document.getElementById('new_password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && newPassword !== confirmPassword) {
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
