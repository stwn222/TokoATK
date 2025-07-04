<%-- 
    Document   : api.barangstat
    Created on : Jul 2, 2025, 7:46:47 PM
    Author     : Andika
--%><%-- 
    Document   : api.barangstat
    Created on : Jul 2, 2025, 7:46:47 PM
    Author     : Andika
    Fixed for Project 1 Fase 3 - Statistics API
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    try {
        ArrayList<Barang> list = Barang.getList();
        
        if (list.isEmpty()) {
            out.print("{\"error\":\"Tidak ada data barang\"}");
        } else {
            int banyak = list.size();
            double totalHarga = 0;
            
            for (Barang barang : list) {
                totalHarga += barang.getHarga();
            }
            
            double rata2 = totalHarga / banyak;
            
            out.print("{\"banyak\":" + banyak + ",\"rata2\":" + rata2 + "}");
        }
    } catch (Exception e) {
        out.print("{\"error\":\"" + e.getMessage() + "\"}");
    }
%>