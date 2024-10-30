package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Cấu hình SMTP cho Gmail
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USER = "khoangoquan@gmail.com"; // Thay đổi
    private static final String SMTP_PASSWORD = "mzrs xvca qstr zegw"; // Thay đổi (sử dụng App Password nếu dùng 2FA)

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Tạo token duy nhất
        String token = UUID.randomUUID().toString();
        System.out.println("Generated token: " + token); // Debugging

        // Lưu thông tin người dùng vào cơ sở dữ liệu với trạng thái 'inactive'
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/webbds?useSSL=false&serverTimezone=UTC", "root", "")) { // Thay đổi thông tin kết nối

            String checkQuery = "SELECT COUNT(*) FROM users WHERE username =?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);


            // Lấy kết quả kiểm tra
            ResultSet resultSet = checkStmt.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            if (count > 0) {
                // Nếu tài khoản đã tồn tại, lưu thông báo và quay lại trang đăng ký
                String errorMessage = "Tài khoản hoặc email đã tồn tại. Vui lòng thử lại với thông tin khác.";
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("register.jsp").forward(request, response); // Quay lại trang đăng ký
                return; // Dừng quá trình đăng ký
            }

            String insertQuery = "INSERT INTO users (username, password, email, token, status) VALUES (?, ?, ?, ?, 'inactive')";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, username);
            insertStmt.setString(2, password); // Nên mã hóa mật khẩu
            insertStmt.setString(3, email);
            insertStmt.setString(4, token);
            int rowsInserted = insertStmt.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted); // Debugging

            // Tạo đường dẫn xác nhận tài khoản
            String confirmLink = "http://localhost:8080/untitled4/confirm?token=" + token;
            System.out.println("Confirmation link: " + confirmLink); // Debugging

            // Gửi email xác nhận
            sendConfirmationEmail(email, username, confirmLink);

            // Hiển thị thông báo yêu cầu kiểm tra email
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h3>Đăng ký thành công! Vui lòng kiểm tra email của bạn để xác nhận tài khoản.</h3>");
            out.println("</body></html>");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Đã xảy ra lỗi trong quá trình đăng ký.");
        }
    }

    private void sendConfirmationEmail(String recipientEmail, String username, String confirmLink) {
        // Thiết lập cấu hình mail
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);

        // Tạo session với xác thực
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
            }
        });

        try {
            // Tạo thông điệp email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER, "HomeLander")); // Thay đổi tên ứng dụng
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Xác nhận đăng ký tài khoản");

            // Tạo nội dung email HTML
            String emailContent = "<html>"
                    + "<body>"
                    + "<h3>Chào " + username + ",</h3>"
                    + "<p>Cảm ơn bạn đã đăng ký tài khoản. Vui lòng nhấn vào liên kết dưới đây để xác nhận tài khoản của bạn:</p>"
                    + "<a href=\"" + confirmLink + "\">Xác nhận tài khoản</a>"
                    + "</body>"
                    + "</html>";

            // Thiết lập nội dung email
            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(emailContent, "text/html; charset=UTF-8");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            // Gửi email
            Transport.send(message);

            System.out.println("Email xác nhận đã được gửi đến " + recipientEmail);

        } catch (MessagingException | IOException e) {
            e.printStackTrace();
        }
    }
}
