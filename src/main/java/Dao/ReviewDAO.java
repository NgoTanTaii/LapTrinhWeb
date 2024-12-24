package Dao;

import DBcontext.Database;
import Entity.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {


    public boolean addReview(Review review, List<String> imageUrls) {
        String reviewSql = "INSERT INTO reviews (property_id, rating, review_text) VALUES (?, ?, ?)";
        String imageSql = "INSERT INTO review_imgs (review_id, image_url) VALUES (?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement reviewStmt = conn.prepareStatement(reviewSql, Statement.RETURN_GENERATED_KEYS)) {

            // Thêm review vào bảng reviews
            reviewStmt.setInt(1, review.getPropertyId());
            reviewStmt.setInt(2, review.getRating());
            reviewStmt.setString(3, review.getReview());
            int rowsInserted = reviewStmt.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet generatedKeys = reviewStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int reviewId = generatedKeys.getInt(1);

                    // Thêm các ảnh vào bảng review_imgs
                    try (PreparedStatement imageStmt = conn.prepareStatement(imageSql)) {
                        for (String imageUrl : imageUrls) {
                            imageStmt.setInt(1, reviewId);
                            imageStmt.setString(2, imageUrl);
                            imageStmt.addBatch();
                        }
                        imageStmt.executeBatch();
                    }

                    return true;
                }
            }

            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách đánh giá cho bất động sản
    public List<Review> getReviewsByPropertyId(int propertyId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE property_id = ?";
        Connection conn = Database.getConnection();
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, propertyId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");

                int rating = resultSet.getInt("rating");
                String review = resultSet.getString("review");
                Date createdAt = resultSet.getDate("created_at");
                reviews.add(new Review(id, propertyId, rating, review, createdAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public boolean deleteReview(int reviewId, int propertyId) throws SQLException {
        // Sửa SQL để kiểm tra cả reviewId và propertyId
        String sql = "DELETE FROM reviews WHERE id = ? AND property_id = ?";
        Connection conn = Database.getConnection();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set cả hai tham số reviewId và propertyId
            stmt.setInt(1, reviewId);
            stmt.setInt(2, propertyId);

            // Thực thi câu lệnh DELETE
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }


    }

    public void deleteReviewsByPropertyId(int propertyId) throws SQLException {
        String query = "DELETE FROM reviews WHERE property_id = ?";
        try (Connection connection = Database.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, propertyId);
            ps.executeUpdate();
        }

    }

    public List<String> getImagesByReviewId(int reviewId) throws SQLException {
        List<String> imageUrls = new ArrayList<>();
        String sql = "SELECT image_url FROM review_imgs WHERE review_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                String imageUrl = resultSet.getString("image_url");
                imageUrls.add(imageUrl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Lỗi khi lấy hình ảnh.");
        }

        return imageUrls;
    }
}
