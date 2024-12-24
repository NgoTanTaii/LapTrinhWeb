package Dao;

import DBcontext.Database;
import Entity.PropertyHot;
import Entity.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyHotDao {

    // Lấy tất cả các sản phẩm bất động sản có ít nhất 1 đánh giá và sắp xếp theo số lượng đánh giá
    public List<PropertyHot> getHotProperties() {
        List<PropertyHot> hotProperties = new ArrayList<>();

        // Cập nhật câu SQL để chỉ lấy sản phẩm có ít nhất 1 đánh giá
        String sql = "SELECT p.property_id, p.title, p.description, p.price, p.address, p.type, p.status, " +
                "p.created_at, p.updated_at, p.image_url, p.area, p.poster_id, " +
                "(SELECT COUNT(*) FROM reviews r WHERE r.property_id = p.property_id) AS review_count " +
                "FROM properties p " +
                "HAVING review_count >= 1 " +  // Điều kiện để lấy sản phẩm có ít nhất 1 đánh giá
                "ORDER BY review_count DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int propertyId = rs.getInt("property_id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String address = rs.getString("address");
                String type = rs.getString("type");
                int status = rs.getInt("status");
                Date createdAt = rs.getDate("created_at");
                Date updatedAt = rs.getDate("updated_at");
                String imageUrl = rs.getString("image_url");
                double area = rs.getDouble("area");
                int posterId = rs.getInt("poster_id");
                int reviewCount = rs.getInt("review_count");

                PropertyHot property = new PropertyHot(propertyId, title, description, price, address, type, status,
                        createdAt, updatedAt, imageUrl, area, posterId, reviewCount);

                hotProperties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return hotProperties;
    }

    // Lấy danh sách đánh giá cho sản phẩm
    public List<Review> getReviewsForProperty(int propertyId) {
        List<Review> reviews = new ArrayList<>();

        String sql = "SELECT r.id, r.property_id, r.rating, r.review, r.created_at " +
                "FROM reviews r WHERE r.property_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int reviewId = rs.getInt("id");
                    int rating = rs.getInt("rating");
                    String reviewText = rs.getString("review");
                    Date createdAt = rs.getDate("created_at");

                    reviews.add(new Review(reviewId, propertyId, rating, reviewText, createdAt));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}

