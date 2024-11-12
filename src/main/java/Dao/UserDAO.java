package Dao;

import Controller.User;
import DBcontext.ConnectDB;
import DBcontext.Database;

import java.sql.*;

public class UserDAO {
    // Phương thức cập nhật quyền người dùng
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


    public void addUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role, status, token) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            System.out.println("Inserting username: " + user.getUsername());

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getStatus());
            stmt.setString(6, user.getToken()); // Set token, could be null
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public boolean userExists(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectDB.getConnection();
            String query = "SELECT COUNT(*) FROM users WHERE username = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu đếm được > 0, có nghĩa là tên người dùng đã tồn tại
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (conn != null) try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false; // Không tồn tại
    }


    private Connection getConnection() throws SQLException {

        String url = "jdbc:mysql://localhost:3306/webbds";
        String user = "root";
        String password = "123456";
        return DriverManager.getConnection(url, user, password);
    }

    public User getUserByUsername(String username) throws SQLException {
        String query = "SELECT * FROM users WHERE username = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setToken(rs.getString("token"));
                user.setStatus(rs.getString("status"));
                user.setRole(rs.getString("role"));
                return user;
            }
        }
        return null;
    }


    // Check if a user exists by Google ID
    public boolean checkUserExists(String userId) {
        String sql = "SELECT COUNT(*) FROM users WHERE google_id = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // User exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // User does not exist
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


