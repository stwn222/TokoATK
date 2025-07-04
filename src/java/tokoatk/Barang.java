/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk;

/**
 *
 * @author Andika
 */

import java.sql.*;
import java.util.ArrayList;

public class Barang {
    public String id;
    public String nama;
    public String jenis;
    public Integer harga;

    public String getId() {
        return this.id;
    }

    public String getNama() {
        return this.nama;
    }

    public String getJenis() {
        return this.jenis;
    }

    public Integer getHarga() {
        return this.harga;
    }

    public boolean baca(String id) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM barang WHERE id = ?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            rs = st.executeQuery();

            if (rs.next()) {
                this.id = rs.getString("id");
                this.nama = rs.getString("nama");
                this.jenis = rs.getString("jenis");
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

    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();
            String sql = "INSERT INTO barang (id, nama, jenis, harga) VALUES (?, ?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, this.id);
            st.setString(2, this.nama);
            st.setString(3, this.jenis);
            st.setInt(4, this.harga);
            
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean update() {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();
            String sql = "UPDATE barang SET nama = ?, jenis = ?, harga = ? WHERE id = ?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.nama);
            st.setString(2, this.jenis);
            st.setInt(3, this.harga);
            st.setString(4, this.id);

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
            String sql = "DELETE FROM barang WHERE id = ?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.id);

            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static ArrayList<Barang> getList() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;
        ArrayList<Barang> result = new ArrayList<Barang>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM barang ORDER BY nama";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while (rs.next()) {
                Barang barang = new Barang();
                barang.id = rs.getString("id");
                barang.nama = rs.getString("nama");
                barang.jenis = rs.getString("jenis");
                barang.harga = rs.getInt("harga");
                result.add(barang);
            }
            conn.close();
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    // Method untuk generate ID otomatis
    public static String generateId() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)) as max_id FROM barang WHERE id LIKE 'B%'";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                int maxId = rs.getInt("max_id");
                conn.close();
                return String.format("B%03d", maxId + 1);
            }
            conn.close();
            return "B001";
        } catch (Exception ex) {
            ex.printStackTrace();
            return "B001";
        }
    }
}
