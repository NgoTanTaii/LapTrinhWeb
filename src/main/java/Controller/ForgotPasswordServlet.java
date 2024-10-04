package Controller;

import java.io.IOException;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.Properties;
import java.util.Random;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Kết nối đến CSDL
    private Connection connect() throws SQLException {
        String jdbcURL = "jdbc:mysql://localhost:3306/mysql"; // Thay thế bằng tên database của bạn
        String dbUser = "root"; // Thay thế bằng username CSDL của bạn
        String dbPassword = ""; // Thay thế bằng mật khẩu CSDL của bạn
        return DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        try (Connection conn = connect()) {
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

                // Cập nhật mật khẩu trong CSDL
                String updateQuery = "UPDATE users SET password = ? WHERE username = ? AND email = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, newPassword);
                updateStmt.setString(2, username);
                updateStmt.setString(3, email);
                updateStmt.executeUpdate();

                // Gửi email với mật khẩu mới
                sendEmail(username, email, newPassword);

                // Phản hồi lại người dùng
                response.getWriter().println("Mật khẩu mới đã được gửi đến email của bạn.");
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
