<%-- 
    Document   : formbarangtambah
    Created on : Jul 1, 2025, 11:56:40 PM
    Author     : Andika
--%>

<%@page import="tokoatk.Barang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }

    // Generate ID otomatis
    String newId = Barang.generateId();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tambah Barang - Toko ATK</title>
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
            <h1>Tambah Barang Baru</h1>
            <a href="baranglist.jsp" class="btn btn-secondary">Kembali ke Daftar</a>
        </div>

        <hr>
        <form action="barangtambah.jsp" method="post">
            <div class="container">
                <div class="form-group">
                    <label for="id">ID Barang</label>
                    <input type="text" id="id" name="id" value="<%= newId%>" readonly>
                </div>

                <div class="form-group">
                    <label for="nama">Nama Barang</label>
                    <input type="text" id="nama" name="nama" required>
                </div>

                <div class="form-group">
                    <label for="jenis">Jenis</label>
                    <select id="jenis" name="jenis" required>
                        <option value="">-- Pilih Jenis --</option>
                        <option value="Alat Tulis">Alat Tulis</option>
                        <option value="Buku">Buku</option>
                        <option value="Kertas">Kertas</option>
                        <option value="Peralatan Kantor">Peralatan Kantor</option>
                        <option value="Lainnya">Lainnya</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="harga">Harga</label>
                    <input type="number" id="harga" name="harga" min="0" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-success">Simpan Barang</button>
                    <a href="baranglist.jsp" class="btn btn-secondary">Batal</a>
                </div>
            </div>
        </form>
        <script>
            document.getElementById('nama').focus();

            document.getElementById('harga').addEventListener('input', function (e) {
                let value = e.target.value;
                if (value < 0) {
                    e.target.value = 0;
                }
            });
        </script>
    </body>
</html>
