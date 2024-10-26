package Dao;

import DBcontext.ConnectDB;

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
    public void addUser(String username, String email, String password, String role) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectDB.getConnection();
            String query = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password); // Mã hóa mật khẩu nếu cần
            stmt.setString(4, role);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu cần
        } finally {
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
