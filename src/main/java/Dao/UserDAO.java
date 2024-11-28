package Dao;


import Controller.User;
import DBcontext.Database;

import java.sql.*;

public class UserDAO {
    public void updateUserRole(int userId, String role) {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, role);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức xóa người dùng
    public boolean deleteUser(int userId) {
        String deleteCartItemsSql = "DELETE FROM cartitems WHERE user_id = ?";
        String deleteCartSql = "DELETE FROM cart WHERE user_id = ?";
        String deleteUserSql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // Delete cart items
            try (PreparedStatement stmt = conn.prepareStatement(deleteCartItemsSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // Delete cart
            try (PreparedStatement stmt = conn.prepareStatement(deleteCartSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // Delete user
            try (PreparedStatement stmt = conn.prepareStatement(deleteUserSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            conn.commit(); // Commit transaction
            System.out.println("User with ID " + userId + " and related data was successfully deleted.");
            return true;

        } catch (SQLException e) {
            // Rollback transaction in case of error
            try {
                getConnection().rollback();
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
            System.err.println("Error while deleting user and related data: " + e.getMessage());
            return false;
        }
    }


    public void addUser(User user) throws SQLException {
        if (user == null || user.getUsername() == null || user.getEmail() == null || user.getPassword() == null) {
            System.out.println("Error: User object or required fields are null.");
            return;
        }

        String sql = "INSERT INTO users (username, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getStatus());

            int result = stmt.executeUpdate();
            if (result > 0) {
                System.out.println("User added successfully.");
            } else {
                System.out.println("Failed to add user.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }




    private Connection getConnection() throws SQLException {

        String url = "jdbc:mysql://localhost:3306/webbds";
        String user = "root";
        String password = "123456";
        return DriverManager.getConnection(url, user, password);
    }


    // Check if a user exists by Google ID
    public boolean checkUserExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add a new user to the database
    public void addUser(String userId, String name, String email) {
        String sql = "INSERT INTO users (google_id, name, email, status) VALUES (?, ?, ?, 'active')";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}


