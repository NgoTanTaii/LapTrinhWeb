package Controller;

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

        StringBuilder productDetails = new StringBuilder();

        // Duyệt qua các sản phẩm từ request và thêm vào productDetails
        for (int i = 0; i < productCount; i++) {
            String productName = request.getParameter("productName" + i);
            double price = Double.parseDouble(request.getParameter("productPrice" + i));

            productDetails.append(productName).append(": ").append(price).append("₫\n");
        }

        // Lấy email người dùng từ cơ sở dữ liệu
        String userEmail = getUserEmailByUsername(username);
        if (userEmail == null) {
            request.setAttribute("message", "Không thể tìm thấy email của người dùng.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Gửi email xác nhận đặt lịch
        boolean emailSent = sendAppointmentConfirmationEmail(userEmail, username, address, phone, appointmentDate, appointmentTime, productDetails.toString());
        if (emailSent) {
            request.setAttribute("message", "Đặt lịch thành công! Thông tin xác nhận đã được gửi đến email của bạn.");
        } else {
            request.setAttribute("message", "Đã xảy ra lỗi khi gửi email xác nhận. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    // Phương thức lấy email người dùng dựa trên username
    private String getUserEmailByUsername(String username) {
        String email = null;
        String query = "SELECT email FROM users WHERE username = ?";

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webbds", "root", "");
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

    // Phương thức gửi email xác nhận đặt lịch
    private boolean sendAppointmentConfirmationEmail(String toEmail, String username, String address, String phone, String appointmentDate, String appointmentTime, String productDetails) {
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
}
