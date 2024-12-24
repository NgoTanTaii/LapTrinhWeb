package Controller;

import DBcontext.Database;
import Dao.ReviewDAO;
import Entity.Review;
import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.Arrays;
import java.util.List;

@WebServlet("/ReviewServlet")
@MultipartConfig(
        maxFileSize = 10485760,     // 10MB
        maxRequestSize = 20971520,  // 20MB
        fileSizeThreshold = 0       // Lưu tạm trong bộ nhớ
)
public class ReviewServlet extends HttpServlet {

    private CloudinaryService cloudinaryService;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo CloudinaryService và ReviewDAO
        cloudinaryService = new CloudinaryService();
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("review");

        // Tạo đối tượng Review
        Review review = new Review(propertyId, rating, reviewText);

        try (Connection connection = Database.getConnection()) {
            // Thêm Review vào bảng reviews
            String insertReviewSQL = "INSERT INTO reviews (property_id, rating, review) VALUES (?, ?, ?)";
            PreparedStatement reviewStmt = connection.prepareStatement(insertReviewSQL, Statement.RETURN_GENERATED_KEYS);
            reviewStmt.setInt(1, review.getPropertyId());
            reviewStmt.setInt(2, review.getRating());
            reviewStmt.setString(3, review.getReview());

            int rowsInserted = reviewStmt.executeUpdate();
            if (rowsInserted > 0) {
                ResultSet rs = reviewStmt.getGeneratedKeys();
                int reviewId = 0;
                if (rs.next()) {
                    reviewId = rs.getInt(1);
                }

                // Xử lý ảnh upload
                List<Part> imageParts = request.getParts().stream()
                        .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                        .toList();

                for (Part imagePart : imageParts) {
                    // Tạo tệp tạm thời để lưu ảnh
                    String fileName = imagePart.getSubmittedFileName();
                    String tempFilePath = getServletContext().getRealPath("/uploads") + File.separator + fileName;
                    File tempFile = new File(tempFilePath);

                    try (InputStream inputStream = imagePart.getInputStream()) {
                        Files.copy(inputStream, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }

                    // Upload ảnh lên Cloudinary và lấy URL
                    String imageUrl = cloudinaryService.uploadImage(tempFile); // Upload ảnh lên Cloudinary

                    // Lưu URL ảnh vào bảng review_imgs
                    String insertImageSQL = "INSERT INTO review_imgs (review_id, image_url) VALUES (?, ?)";
                    PreparedStatement imageStmt = connection.prepareStatement(insertImageSQL);
                    imageStmt.setInt(1, reviewId);
                    imageStmt.setString(2, imageUrl);
                    imageStmt.executeUpdate();
                }

                // Chuyển hướng đến trang thành công
                response.sendRedirect("property-detail.jsp?id=" + propertyId);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể lưu đánh giá");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống");
        }
    }
}




