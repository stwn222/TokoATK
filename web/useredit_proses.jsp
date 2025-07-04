<%-- 
    Document   : useredit_proses
    Created on : Jul 2, 2025, 8:40:29 PM
    Author     : Andika
--%>
<%-- 
    Document   : useredit_proses
    Created on : Jul 2, 2025, 12:30:00 AM
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
    
    try {
        // Ambil parameter dari form
        String originalUsername = request.getParameter("original_username");
        String fullname = request.getParameter("fullname");
        String changePassword = request.getParameter("change_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");
        
        // Validasi parameter utama tidak kosong
        if(originalUsername == null || originalUsername.trim().isEmpty() ||
           fullname == null || fullname.trim().isEmpty()) {
            session.setAttribute("error", "Data tidak lengkap! Username dan nama lengkap harus diisi.");
            response.sendRedirect("userlist.jsp");
            return;
        }
        
        // Trim whitespace
        originalUsername = originalUsername.trim();
        fullname = fullname.trim();
        
        // Cari user yang akan diedit
        User user = User.getByUsername(originalUsername);
        if(user == null) {
            session.setAttribute("error", "User dengan username '" + originalUsername + "' tidak ditemukan!");
            response.sendRedirect("userlist.jsp");
            return;
        }
        
        // Validasi panjang nama lengkap
        if(fullname.length() < 2 || fullname.length() > 100) {
            session.setAttribute("error", "Nama lengkap harus antara 2-100 karakter!");
            response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
            return;
        }
        
        // Flag untuk menandai apakah ada perubahan
        boolean hasChanges = false;
        String changeMessage = "";
        
        // Update nama lengkap jika berbeda
        if(!user.getFullname().equals(fullname)) {
            user.setFullname(fullname);
            hasChanges = true;
            changeMessage += "nama lengkap";
        }
        
        // Proses perubahan password jika diminta
        if("on".equals(changePassword)) {
            // Validasi password baru
            if(newPassword == null || newPassword.trim().isEmpty() ||
               confirmPassword == null || confirmPassword.trim().isEmpty()) {
                session.setAttribute("error", "Password baru dan konfirmasi password harus diisi!");
                response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
                return;
            }
            
            newPassword = newPassword.trim();
            confirmPassword = confirmPassword.trim();
            
            // Validasi panjang password
            if(newPassword.length() < 6 || newPassword.length() > 50) {
                session.setAttribute("error", "Password baru harus antara 6-50 karakter!");
                response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
                return;
            }
            
            // Validasi konfirmasi password
            if(!newPassword.equals(confirmPassword)) {
                session.setAttribute("error", "Password baru dan konfirmasi password tidak sama!");
                response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
                return;
            }
            
            // Cek apakah password berbeda dengan yang lama
            if(!user.getPassword().equals(newPassword)) {
                user.setPassword(newPassword);
                hasChanges = true;
                if(!changeMessage.isEmpty()) {
                    changeMessage += " dan password";
                } else {
                    changeMessage = "password";
                }
            } else {
                // Password sama dengan yang lama
                if(changeMessage.isEmpty()) {
                    session.setAttribute("error", "Password baru sama dengan password lama! Tidak ada perubahan yang disimpan.");
                    response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
                    return;
                }
            }
        }
        
        // Jika tidak ada perubahan
        if(!hasChanges) {
            session.setAttribute("error", "Tidak ada perubahan data yang disimpan!");
            response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
            return;
        }
        
        // Simpan perubahan ke database/file
        boolean success = user.update();
        
        if(success) {
            // Berhasil diupdate
            String successMessage = "Data user '" + user.getFullname() + "' berhasil diupdate (" + changeMessage + ")!";
            
            // Jika user mengedit profilnya sendiri, update session
            if(originalUsername.equals(session.getAttribute("username"))) {
                session.setAttribute("fullname", user.getFullname());
                successMessage += " Profil Anda telah diperbarui.";
            }
            
            session.setAttribute("success", successMessage);
            response.sendRedirect("userlist.jsp");
        } else {
            // Gagal menyimpan
            session.setAttribute("error", "Gagal mengupdate user! Silakan coba lagi.");
            response.sendRedirect("formuseredit.jsp?username=" + originalUsername);
        }
        
    } catch(Exception e) {
        // Handle error
        String username = request.getParameter("original_username");
        session.setAttribute("error", "Terjadi kesalahan sistem: " + e.getMessage());
        
        if(username != null && !username.trim().isEmpty()) {
            response.sendRedirect("formuseredit.jsp?username=" + username.trim());
        } else {
            response.sendRedirect("userlist.jsp");
        }
        
        // Log error untuk debugging
        System.err.println("Error in useredit_proses.jsp: " + e.getMessage());
        e.printStackTrace();
    }
%>
