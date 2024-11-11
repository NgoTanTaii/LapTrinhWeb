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
    public void deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Phương thức thêm người dùng
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
}
