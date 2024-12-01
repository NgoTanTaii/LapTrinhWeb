package Dao;

import DBcontext.Database;

import java.sql.*;


public class PropertyProjectDAO {

    protected Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            connection = Database.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }


}
