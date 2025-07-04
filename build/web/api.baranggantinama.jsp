<%-- 
    Document   : api.baranggantinama
    Created on : Jul 2, 2025, 7:45:19 PM
    Author     : Andika
--%><%-- 
    Document   : api.baranggantinama
    Created on : Jul 4, 2025
    Author     : Andika
    API for changing item name
--%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String namabaru = request.getParameter("namabaru");
    
    try {
        if (id != null && namabaru != null && !namabaru.trim().isEmpty()) {
            Barang barang = new Barang();
            barang.baca(id);
            barang.setNama(namabaru.trim());
            if(barang.update()) {
                out.print("ok");
            } else {
                out.print("fail");
            }
        } else {
            out.print("fail");
        }
    } catch (Exception e) {
        out.print("fail");
    }
%>