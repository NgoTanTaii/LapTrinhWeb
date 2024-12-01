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


        System.out.println(productCount);

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

        // Lưu thông tin đặt lịch vào cơ sở dữ liệu và lấy appointmentId
        int appointmentId = saveAppointment(address, phone, appointmentDate, appointmentTime, productCount, username);

        // Gửi email xác nhận đặt lịch
        boolean emailSent = sendAppointmentConfirmationEmail(userEmail, username, address, phone, appointmentDate, appointmentTime);
        if (emailSent) {
            // Sau khi đặt lịch thành công, xóa tất cả sản phẩm trong giỏ hàng
            clearCart(username);  // Clear the cart after appointment is confirmed

            request.setAttribute("message", "Đặt lịch thành công! Thông tin xác nhận đã được gửi đến email của bạn.");
        } else {
            request.setAttribute("message", "Đã xảy ra lỗi khi gửi email xác nhận. Vui lòng thử lại.");
        }

        // Redirect to cart or confirmation page
        request.getRequestDispatcher("cart.jsp").forward(request, response);
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


    private int saveAppointment(String address, String phone, String appointmentDate, String appointmentTime, int productCount, String username) {
        String query = "INSERT INTO appointments (address, phone, appointment_date, appointment_time, property_count, username) VALUES (?, ?, ?, ?, ?, ?)";
        int appointmentId = -1;

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            // Cài đặt giá trị vào PreparedStatement
            stmt.setString(1, address);
            stmt.setString(2, phone);
            stmt.setString(3, appointmentDate);
            stmt.setString(4, appointmentTime);
            stmt.setInt(5, productCount);
            stmt.setString(6, username);

            // Thực hiện câu lệnh và lấy ID của đơn đặt lịch vừa tạo
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    appointmentId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentId;
    }


    // Phương thức gửi email xác nhận đặt lịch
    private boolean sendAppointmentConfirmationEmail(String toEmail, String username, String address, String phone, String appointmentDate, String appointmentTime) {
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

            String emailContent = "Xin chào " + username + ",\n\n"
                    + "Cảm ơn bạn đã đặt lịch tại Homelander.\n"
                    + "Thông tin lịch hẹn của bạn:\n"
                    + "- Địa chỉ: " + address + "\n"
                    + "- Số điện thoại: " + phone + "\n"
                    + "- Ngày hẹn: " + appointmentDate + "\n"
                    + "- Giờ hẹn: " + appointmentTime + "\n\n"
                    + "\nChúng tôi sẽ liên hệ sớm với bạn để xác nhận lịch hẹn.\n\n"
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

    // Phương thức xóa tất cả sản phẩm trong giỏ hàng
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
