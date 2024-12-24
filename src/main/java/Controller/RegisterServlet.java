package Controller;

import DBcontext.Database;
import Mail.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Tạo token duy nhất
        String token = UUID.randomUUID().toString();
        System.out.println("Generated token: " + token); // Debugging

        // Mã hóa mật khẩu bằng MD5
        String hashedPassword = hashPasswordWithMD5(password);
        if (hashedPassword == null) {
            response.getWriter().println("Đã xảy ra lỗi trong quá trình mã hóa mật khẩu.");
            return;
        }
        System.out.println("Hashed password: " + hashedPassword); // Debugging

        // Lưu thông tin người dùng vào cơ sở dữ liệu với trạng thái 'inactive'
        try (Connection conn = Database.getConnection()) {

            // Kiểm tra tài khoản đã tồn tại chưa
            String checkQuery = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);

            ResultSet resultSet = checkStmt.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            if (count > 0) {
                // Nếu tài khoản đã tồn tại, lưu thông báo và quay lại trang đăng ký
                String errorMessage = "Tài khoản đã tồn tại. Vui lòng thử lại với thông tin khác.";
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Thực hiện thêm người dùng vào cơ sở dữ liệu
            String insertQuery = "INSERT INTO users (username, password, email, token, status) VALUES (?, ?, ?, ?, 'inactive')";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, username);
            insertStmt.setString(2, hashedPassword); // Lưu mật khẩu đã mã hóa
            insertStmt.setString(3, email);
            insertStmt.setString(4, token);
            int rowsInserted = insertStmt.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);

            // Tạo đường dẫn xác nhận tài khoản
            String confirmLink = "http://localhost:8080/Batdongsan/confirm?token=" + token;
            System.out.println("Confirmation link: " + confirmLink); // Debugging

            // Gửi email xác nhận
            EmailUtils.sendConfirmationEmail(email, username, confirmLink);

            // Hiển thị thông báo yêu cầu kiểm tra email
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<html><body><h3>Đăng ký thành công! Vui lòng kiểm tra email của bạn để xác nhận tài khoản.</h3></body></html>");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Đã xảy ra lỗi trong quá trình đăng ký.");
        }
    }

    // Hàm mã hóa mật khẩu với MD5
    private String hashPasswordWithMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
