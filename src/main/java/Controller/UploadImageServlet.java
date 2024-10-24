//package Controller;
//
//import java.io.IOException;
//import java.io.InputStream;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.MultipartConfig;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.Part;
//
//@WebServlet("/UploadImageServlet")
//@MultipartConfig
//public class UploadImageServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String propertyId = request.getParameter("property_id");
//        Part filePart = request.getPart("image"); // Nhận file ảnh
//        InputStream inputStream = filePart.getInputStream(); // Lấy stream từ file
//
//        String jdbcURL = "jdbc:mysql://localhost:3306/mysql";
//        String dbUser = "root";
//        String dbPass = ""; // Cập nhật mật khẩu nếu cần
//
//        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPass)) {
//            String sql = "INSERT INTO property_images (property_id, image_url) VALUES (?, ?)";
//            PreparedStatement statement = connection.prepareStatement(sql);
//            statement.setInt(1, Integer.parseInt(propertyId));
//            statement.setBlob(2, inputStream); // Lưu ảnh vào BLOB
//
//            int row = statement.executeUpdate();
//            if (row > 0) {
//                response.sendRedirect("propertyDetails.jsp?id=" + propertyId); // Redirect về trang chi tiết bất động sản
//            } else {
//                response.getWriter().print("Tải lên thất bại!");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().print("Lỗi: " + e.getMessage());
//        }
//    }
//}
