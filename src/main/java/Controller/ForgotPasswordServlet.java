package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.Properties;
import java.util.Random;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        try (Connection conn = Database.getConnection()) {  // Use the central database connection
            // Kiểm tra username và email trong CSDL
            String query = "SELECT * FROM users WHERE username = ? AND email = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, email);
            ResultSet resultSet = statement.executeQuery();

            // Nếu username và email hợp lệ
            if (resultSet.next()) {
                // Tạo mật khẩu mới
                String newPassword = generateNewPassword();

                // Mã hóa mật khẩu mới bằng MD5
                String hashedPassword = hashPasswordMD5(newPassword);

                // Cập nhật mật khẩu đã mã hóa vào CSDL
                String updateQuery = "UPDATE users SET password = ? WHERE username = ? AND email = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, hashedPassword);  // Lưu mật khẩu đã mã hóa
                updateStmt.setString(2, username);
                updateStmt.setString(3, email);
                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    // Gửi email với mật khẩu mới
                    sendEmail(username, email, newPassword);

                    // Phản hồi lại người dùng
                    response.getWriter().println("Mật khẩu mới đã được gửi đến email của bạn.");
                } else {
                    // Nếu cập nhật mật khẩu không thành công
                    response.getWriter().println("Không thể cập nhật mật khẩu. Vui lòng thử lại sau.");
                }
            } else {
                // Nếu username hoặc email không đúng
                response.getWriter().println("Tên tài khoản hoặc email không hợp lệ.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Đã xảy ra lỗi. Vui lòng thử lại sau.");
        }
    }

    // Hàm tạo mật khẩu ngẫu nhiên
    private String generateNewPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {  // Tạo mật khẩu dài 8 ký tự
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    // Hàm mã hóa mật khẩu bằng MD5
    private String hashPasswordMD5(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password.getBytes());
        byte[] byteData = md.digest();

        // Chuyển đổi byte[] thành chuỗi hex
        StringBuilder sb = new StringBuilder();
        for (byte b : byteData) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();  // Trả về mật khẩu đã mã hóa (dưới dạng chuỗi hex)
    }

    // Hàm gửi email chứa mật khẩu mới
    private void sendEmail(String username, String recipientEmail, String newPassword) throws MessagingException {
        // Cấu hình SMTP
        String senderEmail = "khoangoquan@gmail.com"; // Thay thế bằng email của bạn
        String senderPassword = "mzrs xvca qstr zegw"; // Thay thế bằng mật khẩu email của bạn
        String host = "smtp.gmail.com";

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Xác thực email
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        // Tạo nội dung email với thông tin username và mật khẩu mới
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Khôi phục mật khẩu");

        String emailContent = "Hello " + username + ",\n\n" +
                "Đây là mật khẩu mới của bạn: " + newPassword + "\n\n" +
                "Vui lòng đổi mật khẩu ngay sau khi đăng nhập.";

        message.setText(emailContent);

        // Gửi email
        Transport.send(message);

    }
}
