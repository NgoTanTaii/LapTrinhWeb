package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;

@WebServlet("/schedule-appointment")
public class ScheduleAppointmentServlet extends HttpServlet {

    // Các thông tin cấu hình gửi email và cơ sở dữ liệu
    private static final String FROM_EMAIL = "khoangoquan@gmail.com";
    private static final String EMAIL_PASSWORD = "mzrs xvca qstr zegw";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy các tham số từ form đặt lịch
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
        int productCount = Integer.parseInt(request.getParameter("productCount"));

        // Kiểm tra các thông tin nhập vào
        if (address == null || address.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng nhập đầy đủ địa chỉ và số điện thoại.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Lấy email người dùng từ cơ sở dữ liệu
        String userEmail = getUserEmailByUsername(username);
        if (userEmail == null) {
            request.setAttribute("message", "Không thể tìm thấy email của người dùng.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Gửi email xác nhận đặt lịch
        boolean emailSent = sendAppointmentConfirmationEmail(userEmail, username, address, phone, appointmentDate, appointmentTime);
        if (emailSent) {
            // Sau khi đặt lịch thành công, xóa tất cả sản phẩm trong giỏ hàng
            clearCart(username);

            request.setAttribute("message", "Đặt lịch thành công! Thông tin xác nhận đã được gửi đến email của bạn.");
        } else {
            request.setAttribute("message", "Đã xảy ra lỗi khi gửi email xác nhận. Vui lòng thử lại.");
        }

        // Redirect to cart or confirmation page
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    private boolean sendAppointmentConfirmationEmail(String userEmail, String username, String address, String phone, String appointmentDate, String appointmentTime) {
        // Thiết lập thông tin cấu hình gửi email
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo phiên làm việc email với xác thực
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        try {
            // Tạo đối tượng Message để gửi email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
            message.setSubject("Xác nhận đặt lịch từ Homelander");

            // Cấu trúc nội dung email
            String emailContent = "Xin chào " + username + ",\n\n"
                    + "Cảm ơn bạn đã đặt lịch tại Homelander.\n"
                    + "Thông tin lịch hẹn của bạn:\n"
                    + "- Địa chỉ: " + address + "\n"
                    + "- Số điện thoại: " + phone + "\n"
                    + "- Ngày hẹn: " + appointmentDate + "\n"
                    + "- Giờ hẹn: " + appointmentTime + "\n\n"
                    + "Chúng tôi sẽ liên hệ sớm với bạn để xác nhận lịch hẹn.\n\n"
                    + "Trân trọng,\n"
                    + "Đội ngũ Homelander.";

            // Đặt nội dung email
            message.setText(emailContent);

            // Gửi email
            Transport.send(message);
            return true; // Email gửi thành công

        } catch (MessagingException e) {
            e.printStackTrace(); // In lỗi nếu có
            return false; // Trả về false nếu có lỗi trong quá trình gửi email
        }
    }


    // Phương thức lấy email người dùng dựa trên username
    private String getUserEmailByUsername(String username) {
        String email = null;
        String query = "SELECT email FROM users WHERE username = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return email;
    }

    // Lưu thông tin đặt lịch vào cơ sở dữ liệu và lấy appointmentId
    private int saveAppointment(String address, String phone, String appointmentDate, String appointmentTime, int productCount, String username) {
        String query = "INSERT INTO appointments (address, phone, appointment_date, appointment_time, property_count, username) VALUES (?, ?, ?, ?, ?, ?)";
        int appointmentId = -1;

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, address);
            stmt.setString(2, phone);
            stmt.setString(3, appointmentDate);
            stmt.setString(4, appointmentTime);
            stmt.setInt(5, productCount);
            stmt.setString(6, username);

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    appointmentId = rs.getInt(1);
                }
            }

            // Lấy thông tin đặt cọc và sản phẩm
            getDepositDetails(username, appointmentId);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentId;
    }

    // Lấy thông tin đặt cọc từ cơ sở dữ liệu và gửi email
    private void getDepositDetails(String username, int appointmentId) {
        String query = "SELECT d.property_id, d.deposit_amount, p.title FROM deposit_orders d " +
                "JOIN properties p ON d.property_id = p.property_id WHERE d.user_id = (SELECT id FROM users WHERE username = ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                StringBuilder depositInfo = new StringBuilder();
                double totalDepositAmount = 0;

                // Duyệt qua các kết quả và tạo thông tin đặt cọc
                while (rs.next()) {
                    String propertyName = rs.getString("title");
                    double depositAmount = rs.getDouble("deposit_amount");

                    depositInfo.append("Sản phẩm: ").append(propertyName)
                            .append(" - Tiền đặt cọc: ").append(depositAmount).append(" ₫\n");

                    totalDepositAmount += depositAmount;
                }

                // Nếu có thông tin đặt cọc, gửi email với thông tin đó
                if (depositInfo.length() > 0) {
                    sendAppointmentConfirmationEmailWithDeposit(username, depositInfo.toString(), totalDepositAmount);
                } else {
                    sendAppointmentConfirmationEmail(username, getUserEmailByUsername(username), "Địa chỉ", "Số điện thoại", "Ngày hẹn", "Giờ hẹn", null, 0);
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Gửi email xác nhận đặt lịch với thông tin đặt cọc
    private void sendAppointmentConfirmationEmailWithDeposit(String username, String depositDetails, double totalDepositAmount) {
        String toEmail = getUserEmailByUsername(username);  // Lấy email người dùng
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Xác nhận đặt lịch từ Homelander");

            // Nội dung email
            String emailContent = "Xin chào " + username + ",\n\n"
                    + "Cảm ơn bạn đã đặt lịch tại Homelander.\n"
                    + "Thông tin đặt cọc của bạn:\n" + depositDetails

                    + "Chúng tôi sẽ liên hệ sớm với bạn để xác nhận lịch hẹn.\n\n"

                    + "Trân trọng,\n"
                    + "Đội ngũ Homelander.";

            message.setText(emailContent);
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // Gửi email xác nhận đặt lịch không có đặt cọc
    private boolean sendAppointmentConfirmationEmail(String toEmail, String username, String address, String phone, String appointmentDate, String appointmentTime, String depositDetails, double totalDepositAmount) {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Xác nhận đặt lịch từ Homelander");

            // Nội dung email
            String emailContent = "Xin chào " + username + ",\n\n"
                    + "Cảm ơn bạn đã đặt lịch tại Homelander.\n"
                    + "Thông tin lịch hẹn của bạn:\n"
                    + "- Địa chỉ: " + address + "\n"
                    + "- Số điện thoại: " + phone + "\n"
                    + "- Ngày hẹn: " + appointmentDate + "\n"
                    + "- Giờ hẹn: " + appointmentTime + "\n\n";

            // Nếu có thông tin đặt cọc, thêm vào email
            if (depositDetails != null && !depositDetails.isEmpty()) {
                emailContent += "Thông tin đặt cọc:\n" + depositDetails
                        + "Tổng số tiền đặt cọc: " + totalDepositAmount + " ₫\n\n";
            }

            emailContent += "Chúng tôi sẽ liên hệ sớm với bạn để xác nhận lịch hẹn.\n\n"
                    + "Trân trọng,\n"
                    + "Đội ngũ Homelander.";

            message.setText(emailContent);
            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa tất cả sản phẩm trong giỏ hàng
    private void clearCart(String username) {
        String query = "DELETE FROM cart WHERE user_id = (SELECT id FROM users WHERE username = ?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
