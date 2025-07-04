<%-- 
    Document   : saleslist
    Created on : Jul 2, 2025, 1:18:48 AM
    Author     : Andika
--%><%-- 
    Document   : saleslist
    Created on : Jul 2, 2025, 1:18:48 AM
    Author     : Andika
    Updated with Statistics Feature
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Sales"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek session login
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return;
    }

    ArrayList<Sales> list = Sales.getList();
    request.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Daftar Penjualan - Toko ATK</title>
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
                background: white;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #A21232;
                color: white;
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
            .btn-info {
                background-color: #17a2b8;
                color: white;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .header {
                background: #EFE4D2;
                color: black;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
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
            <h1>Daftar Penjualan</h1>
            <div>
                <a href="home.jsp" class="btn btn-primary">Home</a>
                <a href="formsalestambah.jsp" class="btn btn-success">Transaksi Baru</a>
                <button type="button" class="btn btn-info" onclick="showStat()">Show Statistik</button>
            </div>
        </div>

        <hr>

        <c:if test="${empty list}">
            <div class="empty-message">
                <p>Tidak ada data penjualan.</p>
            </div>
        </c:if>

        <c:if test="${not empty list}">
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>ID Transaksi</th>
                        <th>Waktu</th>
                        <th>Kasir</th>
                        <th>Total</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="sales" items="${list}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${sales.getId()}</td>
                        <td>${sales.getFormattedWaktu()}</td>
                        <td>${sales.getUsername()}</td>
                        <td>Rp <fmt:formatNumber type="number" pattern="0,000" value="${sales.getTotal()}" /></td>
                        <td>
                            <a href="formsalestambah.jsp?id=${sales.getId()}" class="btn btn-primary">Detail</a>
                            <a href="saleshapus.jsp?id=${sales.getId()}" 
                               onclick="return confirm('Yakin ingin menghapus transaksi ini?')" 
                               class="btn btn-danger">Hapus</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </c:if>
        
        <script>
            function showStat() {
                $.post("api.salestotal.jsp", function(result) {
                    try {
                        let obj = JSON.parse(result);
                        if (obj.error) {
                            alert("Error: " + obj.error);
                        } else {
                            alert("Statistik Penjualan:\n" +
                                  "Banyak transaksi: " + obj.banyak + " transaksi\n" +
                                  "Total penjualan: Rp " + obj.totalPenjualan.toLocaleString('id-ID') + "\n" +
                                  "Rata-rata per transaksi: Rp " + obj.rata2.toLocaleString('id-ID'));
                        }
                    } catch(e) {
                        alert("Error parsing data: " + e.message);
                    }
                }).fail(function() {
                    alert("Gagal mengambil data statistik!");
                });
            }
        </script>
    </body>
</html>