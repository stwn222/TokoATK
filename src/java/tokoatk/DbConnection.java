/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk;

/**
 *
 * @author Andika
 */
import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
    private static final String DBDRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DBCONNECTION = "jdbc:mysql://localhost:3306/tokoatk";
    private static final String DBUSER = "root";
    private static final String DBPASS = "";

    public static Connection connect() {
        try {
            Class.forName(DBDRIVER);
            return DriverManager.getConnection(DBCONNECTION, DBUSER, DBPASS);
        } catch(Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException("SQL Connection Error: " + e.getMessage());
        }
    }
}