package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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

    // Kết nối tới CSDL
    private Connection getConnection() throws SQLException {
        // Kết nối tới CSDL (cấu hình tùy thuộc vào hệ thống của bạn)
        // Ví dụ sử dụng JDBC với MySQL
        String url = "jdbc:mysql://localhost:3306/mysql";
        String user = "root";
        String password = "";
        return DriverManager.getConnection(url, user, password);
    }
}
