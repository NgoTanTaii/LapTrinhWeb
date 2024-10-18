//package Controller;
//
//import javax.mail.*;
//import javax.mail.internet.*;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.Properties;
//
//// Phần còn lại của các import...
//
//@WebServlet("/update-address")
//public class UpdateAddressServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String address = request.getParameter("address"); // Địa chỉ
//        String phone = request.getParameter("phone"); // Số điện thoại
//        String username = (String) request.getSession().getAttribute("username"); // Lấy username từ session
//
//        String errorMessage = null;
//
//        // Kiểm tra các thông tin đầu vào
//        if (address == null || address.trim().isEmpty()) {
//            errorMessage = "Địa chỉ không được để trống.";
//        }
//        if (phone == null || phone.trim().isEmpty()) {
//            errorMessage = "Số điện thoại không được để trống.";
//        }
//
//        if (errorMessage != null) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, errorMessage);
//            return;
//        }
//
//        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
//             PreparedStatement userQuery = connection.prepareStatement("SELECT user_id, email FROM users WHERE username = ?")) {
//
//            userQuery.setString(1, username);
//            ResultSet resultSet = userQuery.executeQuery();
//
//            if (resultSet.next()) {
//                int userId = resultSet.getInt("user_id");
//                String email = resultSet.getString("email"); // Lấy email từ kết quả truy vấn
//
//                // Cập nhật địa chỉ trong cơ sở dữ liệu
//                try (PreparedStatement updateAddressQuery = connection.prepareStatement("UPDATE useraddress SET address = ?, phone = ? WHERE user_id = ?")) {
//                    updateAddressQuery.setString(1, address);
//                    updateAddressQuery.setString(2, phone);
//                    updateAddressQuery.setInt(3, userId);
//
//                    int rowsUpdated = updateAddressQuery.executeUpdate();
//                    if (rowsUpdated > 0) {
//                        response.setStatus(HttpServletResponse.SC_OK);
//                        sendEmail(email, address, phone); // Gọi hàm gửi email
//                    } else {
//                        errorMessage = "Không tìm thấy địa chỉ để cập nhật.";
//                    }
//                }
//            } else {
//                errorMessage = "Không tìm thấy người dùng.";
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            errorMessage = "Đã xảy ra lỗi trong quá trình cập nhật địa chỉ.";
//        }
//
//        if (errorMessage != null) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, errorMessage);
//        }
//    }
//
//    private void sendEmail(String to, String address, String phone) {
//        String from = "khoangoquan@gmail.com"; // Địa chỉ email của bạn
//        final String username = "khoangoquan@gmail.com"; // Địa chỉ email của bạn
//        final String password = "mzrs xvca qstr zegw"; // Mật khẩu email của bạn
//
//        // Thiết lập thuộc tính cho kết nối đến mail server
//        Properties props = new Properties();
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.port", "587");
//
//        // Tạo một phiên gửi mail
//        Session session = Session.getInstance(props,
//                new javax.mail.Authenticator() {
//                    protected PasswordAuthentication getPasswordAuthentication() {
//                        return new PasswordAuthentication(username, password);
//                    }
//                });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(from));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//            message.setSubject("Xác nhận đặt hàng");
//            message.setText("Bạn đã đặt hàng thành công với địa chỉ: " + address + " và số điện thoại: " + phone);
//
//            Transport.send(message); // Gửi email
//
//            System.out.println("Email đã được gửi thành công!");
//
//        } catch (MessagingException e) {
//            throw new RuntimeException(e);
//        }
//    }
//}
