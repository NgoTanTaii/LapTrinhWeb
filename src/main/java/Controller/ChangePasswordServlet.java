package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Phương thức giúp mã hóa mật khẩu bằng MD5
    private String encryptPasswordMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();  // Trả về chuỗi mã hóa MD5
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String username = (String) request.getSession().getAttribute("username"); // Giả sử tên người dùng đã lưu trong session

        // Kiểm tra tính hợp lệ của mật khẩu mới và mật khẩu xác nhận
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu cũ và mới bằng MD5
        String encryptedOldPassword = encryptPasswordMD5(oldPassword);
        String encryptedNewPassword = encryptPasswordMD5(newPassword);

        try (Connection conn = Database.getConnection()) {
            // Kiểm tra mật khẩu cũ
            String checkOldPasswordQuery = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkOldPasswordQuery);
            checkStmt.setString(1, username);
            checkStmt.setString(2, encryptedOldPassword); // Sử dụng mật khẩu cũ đã mã hóa
            ResultSet resultSet = checkStmt.executeQuery();

            if (resultSet.next()) {
                // Cập nhật mật khẩu mới
                String updatePasswordQuery = "UPDATE users SET password = ? WHERE username = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updatePasswordQuery);
                updateStmt.setString(1, encryptedNewPassword); // Mật khẩu mới đã mã hóa
                updateStmt.setString(2, username); // Tên người dùng
                updateStmt.executeUpdate();

                request.setAttribute("successMessage", "Mật khẩu đã được đổi thành công!");
            } else {
                request.setAttribute("errorMessage", "Mật khẩu cũ không đúng!");
            }

            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình đổi mật khẩu. Vui lòng thử lại.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        }
    }
}
