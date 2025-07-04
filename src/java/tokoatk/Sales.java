/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Andika
 */
package tokoatk;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Sales {
    public String id;
    public LocalDateTime waktu;
    public String username;
    
    public LocalDateTime getWaktu() {
        return waktu;
    }
    
    public String getId() {
        return id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getFormattedWaktu() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return waktu.format(formatter);
    }
    
    public boolean baca(String id) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesm WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            rs = st.executeQuery();

            if (rs.next()) {
                this.id = rs.getString("id");
                this.waktu = rs.getTimestamp("waktu").toLocalDateTime();
                this.username = rs.getString("username");
                conn.close();
                return true;
            }
            conn.close();
            return false;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    public boolean tambah(String username) {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();
            
            LocalDateTime dt = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmssSSS");
            id = dt.format(formatter);
            waktu = dt;

            String sql = "INSERT INTO salesm (id, waktu, username) VALUES (?,?,?)";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            st.setTimestamp(2, Timestamp.valueOf(dt));
            st.setString(3, username);
            st.executeUpdate();
            conn.close();
            
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();
            String sql = "DELETE FROM salesm WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    public boolean addDetail(String barangId, Integer qty, Integer harga) {
        SalesDetail detail = new SalesDetail();
        detail.salesId = this.id;
        detail.barangId = barangId;
        detail.qty = qty;
        detail.harga = harga;
        return detail.tambah();
    }
    
    public ArrayList<SalesDetail> getDetail() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;
        ArrayList<SalesDetail> result = new ArrayList<>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesd WHERE salesId=?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.id);
            rs = st.executeQuery();

            while(rs.next()) {
                SalesDetail entry = new SalesDetail();
                entry.id = rs.getInt("id");
                entry.salesId = rs.getString("salesId");
                entry.barangId = rs.getString("barangId");
                entry.qty = rs.getInt("qty");
                entry.harga = rs.getInt("harga");
                result.add(entry);
            }
            conn.close();
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public static ArrayList<Sales> getList() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;
        ArrayList<Sales> result = new ArrayList<>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesm ORDER BY waktu DESC";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while(rs.next()) {
                Sales entry = new Sales();
                entry.id = rs.getString("id");
                entry.waktu = rs.getTimestamp("waktu").toLocalDateTime();
                entry.username = rs.getString("username");
                result.add(entry);
            }
            conn.close();
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public Integer getTotal() {
        Integer total = 0;
        for (SalesDetail detail : getDetail()) {
            total += detail.getTotal();
        }
        return total;
    }
}