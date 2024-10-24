package Dao;

import DBcontext.DbConnection1;
import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {
    public void updateProperty(Property1 property) {
        String sql = "UPDATE properties SET title = ?, price = ?, area = ?, address = ?, type = ?, status = ?, imageUrl = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, property.getTitle());
            stmt.setDouble(2, property.getPrice());
            stmt.setDouble(3, property.getArea());
            stmt.setString(4, property.getAddress());
            stmt.setString(5, property.getType());
            stmt.setString(6, property.getStatus());
            stmt.setString(7, property.getImageUrl());
            stmt.setInt(8, property.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức xóa bất động sản
    public void deleteProperty(int propertyId) {
        String sql = "DELETE FROM properties WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public List<Property1> getPropertiesByPage(int start, int total) {
        List<Property1> list = new ArrayList<>();
        try {
            Connection conn = DbConnection1.initializeDatabase();
            String query = "SELECT * FROM properties LIMIT ?, ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, start);
            stmt.setInt(2, total);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setStatus(rs.getString("status"));
                list.add(property);
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalRecords() {
        int total = 0;
        try {
            Connection conn = DbConnection1.initializeDatabase();
            String query = "SELECT COUNT(*) FROM properties";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }


    private Connection getConnection() throws SQLException {
        // Kết nối tới CSDL (cấu hình tùy thuộc vào hệ thống của bạn)
        // Ví dụ sử dụng JDBC với MySQL
        String url = "jdbc:mysql://localhost:3306/mysql";  // Chỉnh sửa tên database nếu cần
        String user = "root";
        String password = "";  // Cập nhật mật khẩu nếu cần
        return DriverManager.getConnection(url, user, password);
    }


    // Phương thức lấy tất cả các bất động sản từ cơ sở dữ liệu
    public List<Property1> getAllProperties() throws Exception {
        List<Property1> properties = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Kết nối đến cơ sở dữ liệu
            conn = DbConnection1.initializeDatabase();

            // Truy vấn tất cả các bất động sản từ bảng 'properties'
            String query = "SELECT property_id, title, price, area, address, type, status, image_url FROM properties";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Duyệt qua kết quả trả về và thêm vào danh sách 'properties'
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setStatus(rs.getString("status"));
                property.setImageUrl(rs.getString("image_url"));

                properties.add(property);
            }

        } finally {
            // Đảm bảo giải phóng các tài nguyên
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (conn != null) try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return properties;
    }

    public Property1 getPropertyById(String propertyId) {
        Property1 property = null;
        String query = "SELECT * FROM properties WHERE property_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(propertyId));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setStatus(rs.getString("status"));
                property.setImageUrl(rs.getString("image_url"));
                property.setDescription(rs.getString("description"));

                // Retrieve image URLs
                property.setImageUrls(getImageUrlsByPropertyId(Integer.parseInt(propertyId)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return property;
    }

    public List<String> getImageUrlsByPropertyId(int propertyId) {
        List<String> imageUrls = new ArrayList<>();
        String query = "SELECT image_url FROM property_images WHERE property_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                imageUrls.add(rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imageUrls;
    }

    public List<String> getThumbnailUrls(String propertyId) {
        List<String> thumbnails = new ArrayList<>();
        // Implement database query to fetch thumbnail URLs based on propertyId
        String sql = "SELECT image_url FROM property_images WHERE property_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                thumbnails.add(rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return thumbnails;
    }
    public void deleteProperty(String id) {
        String sql = "DELETE FROM properties WHERE property_id = ?\n"; // Thay "properties" bằng tên bảng thực tế

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


