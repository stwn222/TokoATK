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
import java.util.ArrayList;

public class User {

    private String username;
    private String password;
    private String fullname;

    // Getter methods
    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getFullname() {
        return fullname;
    }

    // Setter methods
    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public static User getByUsername(String username) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM users WHERE username = ?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            rs = st.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullname(rs.getString("fullname"));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Method untuk login
    public boolean login(String username, String password) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            rs = st.executeQuery();

            if (rs.next()) {
                this.username = rs.getString("username");
                this.password = rs.getString("password");
                this.fullname = rs.getString("fullname");
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

    // Method untuk membaca data user berdasarkan username
    public boolean baca(String username) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();

            String sql = "SELECT * FROM users WHERE username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            rs = st.executeQuery();

            if (rs.next()) {
                this.username = rs.getString("username");
                this.password = rs.getString("password");
                this.fullname = rs.getString("fullname");
                conn.close();
                return true;
            }

            conn.close();
            return false;

        } catch (Exception ex) {
            return false;
        }
    }

    // Method untuk menambah user baru
    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();

            String sql = "INSERT INTO users (username, password, fullname) VALUES (?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, this.username);
            st.setString(2, this.password);
            st.setString(3, this.fullname);

            st.executeUpdate();
            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    // Method untuk update user
    public boolean update() {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();

            String sql = "UPDATE users SET password=?, fullname=? WHERE username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.password);
            st.setString(2, this.fullname);
            st.setString(3, this.username);

            st.executeUpdate();
            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    // Method untuk hapus user
    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();

            String sql = "DELETE FROM users WHERE username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.username);

            st.executeUpdate();
            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    // Method untuk mendapatkan list semua user
    public static ArrayList<User> getList() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;
        ArrayList<User> result = new ArrayList<User>();

        try {
            conn = DbConnection.connect();

            String sql = "SELECT * FROM users ORDER BY username";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.username = rs.getString("username");
                user.password = rs.getString("password");
                user.fullname = rs.getString("fullname");
                result.add(user);
            }

            conn.close();
            return result;

        } catch (Exception ex) {
            return new ArrayList<User>();
        }
    }
}
