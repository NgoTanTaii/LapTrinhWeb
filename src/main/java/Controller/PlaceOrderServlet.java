package Controller;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private static final String FROM_EMAIL = "khoangoquan@gmail.com";
    private static final String EMAIL_PASSWORD = "mzrs xvca qstr zegw";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int productCount = Integer.parseInt(request.getParameter("productCount"));

        if (address == null || address.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng nhập đầy đủ địa chỉ và số điện thoại.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        StringBuilder productDetails = new StringBuilder();
        double totalAmount = 0;

        // Duyệt qua các sản phẩm từ request
        for (int i = 0; i < productCount; i++) {
            String productName = request.getParameter("productName" + i);
            int quantity = Integer.parseInt(request.getParameter("productQuantity" + i));
            double price = Double.parseDouble(request.getParameter("productPrice" + i));

            productDetails.append(productName).append(" (x").append(quantity).append("): ")
                    .append(price * quantity).append("₫\n");
            totalAmount += price * quantity;
        }

        String userEmail = getUserEmailByUsername(username);
        if (userEmail == null) {
            request.setAttribute("message", "Không thể tìm thấy email của người dùng.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        boolean emailSent = sendOrderConfirmationEmail(userEmail, username, address, phone, productDetails.toString(), totalAmount);
        if (emailSent) {
            request.setAttribute("message", "Đặt hàng thành công! Thông tin xác nhận đã được gửi đến email của bạn.");
        } else {
            request.setAttribute("message", "Đã xảy ra lỗi khi gửi email xác nhận. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    private String getUserEmailByUsername(String username) {
        String email = null;
        String query = "SELECT email FROM users WHERE username = ?";

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
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

    private boolean sendOrderConfirmationEmail(String toEmail, String username, String address, String phone, String productDetails, double totalAmount) {
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
            message.setSubject("Xác nhận đơn hàng từ Vinabook");

            String emailContent = "Xin chào " + username + ",\n\n"
                    + "Cảm ơn bạn đã đặt hàng tại Vinabook.\n"
                    + "Thông tin đặt hàng của bạn:\n"
                    + "- Địa chỉ: " + address + "\n"
                    + "- Số điện thoại: " + phone + "\n\n"
                    + "Chi tiết sản phẩm:\n" + productDetails
                    + "\nTổng cộng: " + totalAmount + "₫\n\n"
                    + "Chúng tôi sẽ liên hệ sớm với bạn để giao hàng.\n\n"
                    + "Trân trọng,\n"
                    + "Đội ngũ Vinabook.";

            message.setText(emailContent);

            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
