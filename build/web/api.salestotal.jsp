<%-- 
    Document   : api.salestotal
    Created on : Jul 2, 2025, 7:47:09 PM
    Author     : Andika
--%><%-- 
    Document   : api.salestotal
    Created on : Jul 2, 2025, 7:47:09 PM
    Author     : Andika
    Fixed for Project 1 Fase 3 - Sales Total API
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Sales"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    try {
        ArrayList<Sales> list = Sales.getList();
        
        if (list.isEmpty()) {
            out.print("{\"error\":\"Tidak ada data penjualan\"}");
        } else {
            int banyak = list.size();
            double totalPenjualan = 0;
            
            for (Sales sales : list) {
                totalPenjualan += sales.getTotal();
            }
            
            double rata2 = totalPenjualan / banyak;
            
            out.print("{\"banyak\":" + banyak + ",\"totalPenjualan\":" + totalPenjualan + ",\"rata2\":" + rata2 + "}");
        }
    } catch (Exception e) {
        out.print("{\"error\":\"" + e.getMessage() + "\"}");
    }
%>