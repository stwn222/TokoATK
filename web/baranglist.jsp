<%-- 
    Document   : baranglist
    Created on : Jul 1, 2025, 11:56:15 PM
    Author     : Andika
--%>
<%-- 
    Document   : baranglist
    Created on : Jul 1, 2025, 11:56:15 PM
    Author     : Andika
    Updated for Project 1 Fase 3 - API Integration
--%>

<%@page import="tokoatk.Barang"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }

    // Ambil data barang
    ArrayList<Barang> list = Barang.getList();
    request.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Daftar Barang - Toko ATK</title>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #1A1831;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background-color: white;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: center;
            }
            th {
                color:white;
                background-color: #A21232;
            }
            .btn {
                padding: 5px 10px;
                margin: 2px;
                text-decoration: none;
                border-radius: 5px;
                border: none;
                cursor: pointer;
            }
            .btn-primary {
                background-color: #131D4F;
                color: white;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn-warning {
                background-color: #ffc107;
                color: black;
            }
            .btn-info {
                background-color: #17a2b8;
                color: white;
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
            .empty-message {
                color: white;
                text-align: center;
                font-size: 18px;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Daftar Barang</h1>
            <div>
                <a href="home.jsp" class="btn btn-primary">Home</a>
                <a href="formbarangtambah.jsp" class="btn btn-success">Tambah Barang</a>
                <button type="button" class="btn btn-info" onclick="showStat()">Show Statistik</button>
            </div>
        </div>

        <hr>

        <c:if test="${empty list}">
            <div class="empty-message">
                <p>Tidak ada data barang.</p>
            </div>
        </c:if>

        <c:if test="${not empty list}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nama Barang</th>
                        <th>Jenis</th>
                        <th>Harga</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="barang" items="${list}">
                        <tr>
                            <td>${barang.getId()}</td>
                            <td><span id="nama${barang.getId()}">${barang.getNama()}</span></td>
                            <td>${barang.getJenis()}</td>
                            <td>Rp <fmt:formatNumber type="number" pattern="0,000" value="${barang.getHarga()}" /></td>
                            <td>
                                <button type="button" class="btn btn-warning" onclick="gantiNama('${barang.getId()}')">Edit Nama</button>
                                <a href="formbarangedit.jsp?id=${barang.getId()}" class="btn btn-warning">Edit</a>
                                <a href="baranghapus.jsp?id=${barang.getId()}" 
                                   onclick="return confirm('Yakin ingin menghapus barang ${barang.getNama()}?')" 
                                   class="btn btn-danger">Hapus</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </body>
    
    <script>
        function gantiNama(id) {
            let namabaru = prompt("Edit nama barang?");
            if(namabaru && namabaru.trim() !== '') {
                $.post("api.baranggantinama.jsp", {id:id, namabaru:namabaru}, function(result) {
                    if(result.trim() === "ok") {
                        $('#nama'+id).html(namabaru);
                        alert("Nama barang berhasil diubah!");
                    } else {
                        alert("Gagal mengubah nama barang!");
                    }
                }).fail(function() {
                    alert("Error saat menghubungi server!");
                });    
            }
        }
        
        function showStat() {
            $.post("api.barangstat.jsp", function(result) {
                try {
                    let obj = JSON.parse(result);
                    if (obj.error) {
                        alert("Error: " + obj.error);
                    } else {
                        alert("Statistik Barang:\n" +
                              "Banyak data: " + obj.banyak + " item\n" +
                              "Rata-rata harga: Rp " + obj.rata2.toLocaleString('id-ID'));
                    }
                } catch(e) {
                    alert("Error parsing data: " + e.message);
                }
            }).fail(function() {
                alert("Gagal mengambil data statistik!");
            });
        }
    </script>
        
</html>