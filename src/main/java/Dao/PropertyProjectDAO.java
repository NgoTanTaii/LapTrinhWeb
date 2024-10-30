package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyProjectDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/webbds";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String SELECT_ALL_PROPERTIES = "SELECT * FROM properties WHERE status = 'for sale'";

    public PropertyProjectDAO() {
    }

    // Hàm kết nối với CSDL
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
