package Mail;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class EmailUtils {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USER = "khoangoquan@gmail.com"; // Thay đổi
    private static final String SMTP_PASSWORD = "mzrs xvca qstr zegw"; // Thay đổi (sử dụng App Password nếu dùng 2FA)

    public static void sendConfirmationEmail(String recipientEmail, String username, String confirmLink) {
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

        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
