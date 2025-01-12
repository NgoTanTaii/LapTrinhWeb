package Dao;


import DBcontext.Database;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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

        String deleteCartSql = "DELETE FROM cart WHERE user_id = ?";
        String deleteUserSql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false); // Start transaction


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


    public boolean addUser(String username, String password, String email, String token, String status, String role) {
        // Mã hóa mật khẩu
        String encryptedPassword = encryptPassword(password);

        if (encryptedPassword == null) {
            return false;  // Trả về false nếu có lỗi trong quá trình mã hóa
        }

        // Câu truy vấn SQL để thêm người dùng
        String query = "INSERT INTO users (username, password, email, token, status, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            // Thiết lập các tham số cho PreparedStatement
            stmt.setString(1, username);
            stmt.setString(2, encryptedPassword);  // Mật khẩu đã mã hóa
            stmt.setString(3, email);
            stmt.setString(4, token);  // Token có thể là NULL
            stmt.setString(5, status);
            stmt.setString(6, role);

            // Thực thi câu lệnh và kiểm tra kết quả
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;  // Nếu ít nhất 1 dòng bị ảnh hưởng, trả về true
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Trả về false nếu có lỗi trong quá trình thực thi câu lệnh SQL
        }
    }

    private String encryptPassword(String password) {
        try {
            // Tạo đối tượng MessageDigest với thuật toán MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // Mã hóa chuỗi đầu vào thành mảng byte
            byte[] messageDigest = md.digest(password.getBytes());

            // Chuyển đổi mảng byte thành chuỗi hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                hexString.append(String.format("%02x", b));
            }

            return hexString.toString();  // Trả về mật khẩu đã mã hóa
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
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

    public static void main(String[] args) {
        UserDAO us = new UserDAO();
        System.out.println(us.addUser("123", "123", "khoangoquan@gmail.com", null, "active", "user"));
    }
}