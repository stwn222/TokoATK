<%-- 
    Document   : formsalestambah
    Created on : Jul 4, 2025
    Author     : Andika
--%>
<%@page import="tokoatk.Sales"%>
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

    String id = request.getParameter("id");
    Sales sales = null;
    String mode = "tambah"; // default mode
    
    if (id != null && !id.trim().isEmpty()) {
        // Mode detail/view
        mode = "detail";
        try {
            sales = new Sales();
            sales.baca(id);
        } catch (Exception e) {
            // Jika error, tetap mode tambah
            mode = "tambah";
            sales = null;
        }
    }
    
    // Ambil data barang untuk dropdown
    ArrayList<Barang> barangList = Barang.getList();
    request.setAttribute("barangList", barangList);
    request.setAttribute("sales", sales);
    request.setAttribute("mode", mode);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=mode.equals("tambah") ? "Transaksi Baru" : "Detail Transaksi"%> - Toko ATK</title>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #1A1831;
            }
            .container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input, select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background: white;
                margin-top: 20px;
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
                padding: 10px 20px;
                margin: 5px;
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
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn-warning {
                background-color: #ffc107;
                color: black;
            }
            .header {
                background: white;
                color: black;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                border: 2px solid #A21232;
                align-items: center;
            }
            .total-display {
                font-size: 24px;
                font-weight: bold;
                color: #131D4F;
                text-align: right;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1><%=mode.equals("tambah") ? "Transaksi Baru" : "Detail Transaksi " + (sales != null ? sales.id : "")%></h1>
            <div>
                <a href="saleslist.jsp" class="btn btn-primary">Kembali</a>
                <% if (mode.equals("detail") && sales != null) { %>
                    <a href="saleshapus.jsp?id=<%=sales.id%>" 
                       onclick="return confirm('Yakin ingin menghapus transaksi ini?')" 
                       class="btn btn-danger">Hapus Transaksi</a>
                <% } %>
            </div>
        </div>

        <div class="container">
            <% if (mode.equals("tambah")) { %>
                <!-- Form Transaksi Baru -->
                <form action="salesproses.jsp" method="post">
                    <div class="form-group">
                        <label>Kasir: <%=session.getAttribute("fullname")%></label>
                        <input type="hidden" name="username" value="<%=session.getAttribute("username")%>">
                    </div>
                    
                    <h3>Tambah Item</h3>
                    <div id="itemContainer">
                        <div class="item-row">
                            <div style="display: flex; gap: 10px; align-items: center; margin-bottom: 10px;">
                                <select name="barang[]" style="flex: 2;" onchange="updateHarga(this)">
                                    <option value="">Pilih Barang</option>
                                    <c:forEach var="barang" items="${barangList}">
                                        <option value="${barang.id}" data-harga="${barang.harga}">${barang.nama} - Rp <fmt:formatNumber type="number" pattern="0,000" value="${barang.harga}" /></option>
                                    </c:forEach>
                                </select>
                                <input type="number" name="jumlah[]" placeholder="Jumlah" style="flex: 1;" min="1" onchange="hitungTotal()">
                                <input type="number" name="harga[]" placeholder="Harga" style="flex: 1;" readonly>
                                <button type="button" class="btn btn-danger" onclick="hapusItem(this)">Hapus</button>
                            </div>
                        </div>
                    </div>
                    
                    <button type="button" class="btn btn-success" onclick="tambahItem()">Tambah Item</button>
                    <div class="total-display">
                        Total: Rp <span id="totalTransaksi">0</span>
                    </div>
                    
                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary">Simpan Transaksi</button>
                    </div>
                </form>
            <% } else { %>
                <!-- Detail Transaksi -->
                <div class="form-group">
                    <label>ID Transaksi: <%=sales != null ? sales.id : "N/A"%></label>
                </div>
                <div class="form-group">
                    <label>Waktu: <%=sales != null ? sales.waktu : "N/A"%></label>
                </div>
                <div class="form-group">
                    <label>Kasir: <%=sales != null ? sales.username : "N/A"%></label>
                </div>
                
                <h3>Detail Item</h3>
                <p>Detail item akan ditampilkan di sini (implementasi tergantung struktur class SalesDetail)</p>
                
                <div class="total-display">
                    Total: Rp <%=sales != null ? sales.getTotal() : "0"%>
                </div>
            <% } %>
        </div>

        <script>
            function tambahItem() {
                const container = document.getElementById('itemContainer');
                const newRow = document.createElement('div');
                newRow.className = 'item-row';
                newRow.innerHTML = `
                    <div style="display: flex; gap: 10px; align-items: center; margin-bottom: 10px;">
                        <select name="barang[]" style="flex: 2;" onchange="updateHarga(this)">
                            <option value="">Pilih Barang</option>
                            <% for (Barang barang : barangList) { %>
                                <option value="<%=barang.id%>" data-harga="<%=barang.harga%>"><%=barang.nama%> - Rp <%=String.format("%,d", (int)barang.harga)%></option>
                            <% } %>
                        </select>
                        <input type="number" name="jumlah[]" placeholder="Jumlah" style="flex: 1;" min="1" onchange="hitungTotal()">
                        <input type="number" name="harga[]" placeholder="Harga" style="flex: 1;" readonly>
                        <button type="button" class="btn btn-danger" onclick="hapusItem(this)">Hapus</button>
                    </div>
                `;
                container.appendChild(newRow);
            }
            
            function hapusItem(button) {
                const row = button.closest('.item-row');
                row.remove();
                hitungTotal();
            }
            
            function updateHarga(select) {
                const harga = select.options[select.selectedIndex].getAttribute('data-harga');
                const hargaInput = select.closest('.item-row').querySelector('input[name="harga[]"]');
                hargaInput.value = harga || '';
                hitungTotal();
            }
            
            function hitungTotal() {
                let total = 0;
                const rows = document.querySelectorAll('.item-row');
                
                rows.forEach(row => {
                    const jumlah = row.querySelector('input[name="jumlah[]"]').value || 0;
                    const harga = row.querySelector('input[name="harga[]"]').value || 0;
                    total += parseInt(jumlah) * parseFloat(harga);
                });
                
                document.getElementById('totalTransaksi').textContent = total.toLocaleString('id-ID');
            }
        </script>
    </body>
</html>