package Dao;

import java.sql.*;


public class PropertyProjectDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/webbds";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    protected Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }


}
