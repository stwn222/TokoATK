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

public class SalesDetail {
    public Integer id;
    public String salesId;
    public String barangId;
    public Integer qty;
    public Integer harga;
    
    public Integer getId() {
        return id;
    }
    
    public String getSalesId() {
        return salesId;
    }
    
    public String getBarangId() {
        return barangId;
    }
            
    public String getBarangNama() {
        Barang barang = new Barang();
        if (barang.baca(barangId)) {
            return barang.getNama();
        }
        return "Barang tidak ditemukan";
    }
            
    public Integer getQty() {
        return qty;
    }
        
    public Integer getHarga() {
        return harga;
    }
            
    public Integer getTotal() {
        return harga * qty;
    }
    
    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();
            String sql = "INSERT INTO salesd (salesId, barangId, qty, harga) VALUES (?,?,?,?)";
            st = conn.prepareStatement(sql);
            st.setString(1, salesId);
            st.setString(2, barangId);
            st.setInt(3, qty);
            st.setInt(4, harga);
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
            
    public boolean baca(Integer id) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesd WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();

            if (rs.next()) {
                this.id = id;
                this.salesId = rs.getString("salesId");
                this.barangId = rs.getString("barangId");
                this.qty = rs.getInt("qty");
                this.harga = rs.getInt("harga");
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
            
    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();
            String sql = "DELETE FROM salesd WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
