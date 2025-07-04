<%-- 
    Document   : salesproses
    Created on : Jul 4, 2025, 2:28:10 PM
    Author     : Andika
--%>
<%@page import="tokoatk.SalesDetail"%>
<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.Barang"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }

    String username = request.getParameter("username");
    String[] barangIds = request.getParameterValues("barang[]");
    String[] jumlahs = request.getParameterValues("jumlah[]");
    String[] hargas = request.getParameterValues("harga[]");
    
    boolean berhasil = false;
    String pesan = "";
    
    try {
        // Validasi input dasar
        if (username == null || username.trim().isEmpty()) {
            pesan = "Username tidak valid!";
        } else if (barangIds == null || jumlahs == null || hargas == null) {
            pesan = "Data tidak lengkap! Pastikan semua field terisi.";
        } else if (barangIds.length != jumlahs.length || jumlahs.length != hargas.length) {
            pesan = "Data tidak konsisten! Jumlah field tidak sama.";
        } else if (barangIds.length == 0) {
            pesan = "Tidak ada item yang dipilih!";
        } else {
            // Cek dan proses item yang valid
            boolean hasValidItem = false;
            
            // Validasi setiap item dulu
            for (int i = 0; i < barangIds.length; i++) {
                if (barangIds[i] != null && !barangIds[i].trim().isEmpty() && 
                    jumlahs[i] != null && !jumlahs[i].trim().isEmpty() &&
                    hargas[i] != null && !hargas[i].trim().isEmpty()) {
                    
                    try {
                        int jumlah = Integer.parseInt(jumlahs[i].trim());
                        int harga = Integer.parseInt(hargas[i].trim());
                        
                        if (jumlah > 0 && harga > 0) {
                            hasValidItem = true;
                            break;
                        }
                    } catch (NumberFormatException e) {
                        // Continue checking other items
                    }
                }
            }
            
            if (!hasValidItem) {
                pesan = "Tidak ada item valid yang dipilih! Pastikan semua field terisi dengan benar.";
            } else {
                // Buat transaksi baru
                Sales sales = new Sales();
                
                // Simpan sales - gunakan method tambah() yang tersedia
                boolean salesSaved = sales.tambah(username.trim());
                
                if (salesSaved) {
                    String salesId = sales.getId(); // Gunakan getter yang tersedia
                    
                    boolean allDetailsSuccess = true;
                    int itemCount = 0;
                    
                    // Simpan detail transaksi
                    for (int i = 0; i < barangIds.length; i++) {
                        if (barangIds[i] != null && !barangIds[i].trim().isEmpty() && 
                            jumlahs[i] != null && !jumlahs[i].trim().isEmpty() &&
                            hargas[i] != null && !hargas[i].trim().isEmpty()) {
                            
                            try {
                                int jumlah = Integer.parseInt(jumlahs[i].trim());
                                int harga = Integer.parseInt(hargas[i].trim());
                                
                                if (jumlah > 0 && harga > 0) {
                                    // Gunakan method addDetail() yang tersedia di Sales
                                    boolean detailSaved = sales.addDetail(barangIds[i].trim(), jumlah, harga);
                                    
                                    if (detailSaved) {
                                        itemCount++;
                                    } else {
                                        allDetailsSuccess = false;
                                        break;
                                    }
                                }
                            } catch (NumberFormatException e) {
                                allDetailsSuccess = false;
                                break;
                            } catch (Exception e) {
                                allDetailsSuccess = false;
                                break;
                            }
                        }
                    }
                    
                    if (allDetailsSuccess && itemCount > 0) {
                        berhasil = true;
                        pesan = "Transaksi berhasil disimpan dengan " + itemCount + " item!";
                    } else {
                        // Rollback sales jika detail gagal
                        try {
                            sales.hapus();
                        } catch (Exception e) {
                            // Ignore rollback error
                        }
                        pesan = "Gagal menyimpan detail transaksi!";
                    }
                } else {
                    pesan = "Gagal menyimpan transaksi utama!";
                }
            }
        }
    } catch (Exception e) {
        pesan = "Error sistem: " + e.getMessage();
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proses Transaksi - Toko ATK</title>
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
                margin-bottom: 20px;
            }
            .error {
                color: #dc3545;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
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
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Hasil Proses Transaksi</h2>
            
            <% if (berhasil) { %>
                <div class="success">
                    <p>✓ <%=pesan%></p>
                </div>
                <div>
                    <a href="saleslist.jsp" class="btn btn-primary">Lihat Daftar Transaksi</a>
                    <a href="formsalestambah.jsp" class="btn btn-success">Transaksi Baru</a>
                </div>
            <% } else { %>
                <div class="error">
                    <p>✗ <%=pesan%></p>
                </div>
                <div>
                    <a href="formsalestambah.jsp" class="btn btn-primary">Coba Lagi</a>
                    <a href="saleslist.jsp" class="btn btn-success">Kembali ke Daftar</a>
                </div>
            <% } %>
        </div>
    </body>
</html>