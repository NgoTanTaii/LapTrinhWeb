package Dao;


import DBcontext.Database;

import java.sql.*;

public class UserDAO {
    private Connection getConnection() throws SQLException {


        return Database.getConnection();
    }

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


    public void addUser(String username, String password, String email, String token, String status, String role) {
        String query = "INSERT INTO users (username, password, email, token, status, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);  // Có thể mã hóa mật khẩu trước khi lưu
            stmt.setString(3, email);
            stmt.setString(4, token);  // Token có thể là NULL
            stmt.setString(5, status);
            stmt.setString(6, role);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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

}