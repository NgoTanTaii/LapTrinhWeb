package Dao;

import DBcontext.Database;
import Entity.Property;
import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PropertyDAO {
    private Connection connection;

    public PropertyDAO() {
        try {
            // Thay đổi các tham số kết nối cho phù hợp với môi trường của bạn
            this.connection = Database.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateProperty(Property1 property) {
        String sql = "UPDATE properties SET title = ?, description = ?, price = ?, address = ?, type = ?, status = ?, area = ?, image_url = ? WHERE property_id = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, property.getTitle());
            statement.setString(2, property.getDescription());
            statement.setDouble(3, property.getPrice());
            statement.setString(4, property.getAddress());
            statement.setString(5, property.getType());
            statement.setString(6, property.getStatus());
            statement.setDouble(7, property.getArea());
            statement.setString(8, property.getImageUrl());
            statement.setInt(9, property.getId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy thông tin bất động sản theo ID
    public Property1 getPropertyById(int id) {
        String sql = "SELECT * FROM properties WHERE property_id = ?";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return new Property1(
                        resultSet.getInt("property_id"),
                        resultSet.getString("title"),
                        resultSet.getString("description"),
                        resultSet.getDouble("price"),
                        resultSet.getString("address"),
                        resultSet.getString("type"),
                        resultSet.getString("status"),
                        resultSet.getDouble("area"),
                        resultSet.getString("image_url")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // Trong PropertyDAO.java

    public void deleteProperty(int id) {
        String deleteOrderItemsSql = "DELETE FROM orderitems WHERE property_id = ?";
        String deletePropertySql = "DELETE FROM properties WHERE property_id = ?";

        try (Connection conn = Database.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu giao dịch

            try (PreparedStatement psOrderItems = conn.prepareStatement(deleteOrderItemsSql)) {
                psOrderItems.setInt(1, id);
                psOrderItems.executeUpdate();
            }

            try (PreparedStatement psProperty = conn.prepareStatement(deletePropertySql)) {
                psProperty.setInt(1, id);
                psProperty.executeUpdate();
            }

            conn.commit(); // Cam kết giao dịch
        } catch (SQLException e) {
            e.printStackTrace();
            // Bạn nên rollback giao dịch nếu có lỗi xảy ra
            try (Connection conn = Database.getConnection()) {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public List<Property1> getPropertiesByPage(int start, int total) {
        List<Property1> list = new ArrayList<>();
        try {
            Connection conn = Database.getConnection();
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
            Connection conn = Database.getConnection();
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


        return Database.getConnection();
    }


    // Phương thức lấy tất cả các bất động sản từ cơ sở dữ liệu
    public List<Property1> getAllProperties() throws Exception {
        List<Property1> properties = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Kết nối đến cơ sở dữ liệu
            conn = Database.getConnection();

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


    public boolean createProperty(Property1 property) {
        String sql = "INSERT INTO properties (title, price, address, area, image_url, description, type, status, poster_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = Database.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, property.getTitle());
            stmt.setDouble(2, property.getPrice());
            stmt.setString(3, property.getAddress());
            stmt.setDouble(4, property.getArea());
            stmt.setString(5, property.getImageUrl()); // URL hình ảnh
            stmt.setString(6, property.getDescription());
            stmt.setString(7, property.getType());
            stmt.setString(8, property.getStatus());
            stmt.setInt(9, property.getPosterId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Nếu có dòng bị ảnh hưởng, trả về true
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi SQL nếu có
            return false;
        }
    }

    public List<Property1> getPropertiesByCities(List<String> cities) {
        List<Property1> properties = new ArrayList<>();

        // Xây dựng câu truy vấn SQL động với các điều kiện LIKE cho từng thành phố
        StringBuilder queryBuilder = new StringBuilder("SELECT property_id,title, description, address, area, image_url FROM properties WHERE ");
        for (int i = 0; i < cities.size(); i++) {
            queryBuilder.append("address LIKE ?");
            if (i < cities.size() - 1) {
                queryBuilder.append(" OR ");
            }
        }
        String query = queryBuilder.toString();

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Thiết lập giá trị cho từng dấu ? trong câu truy vấn
            for (int i = 0; i < cities.size(); i++) {
                stmt.setString(i + 1, "%" + cities.get(i) + "%"); // Tìm kiếm chuỗi có chứa tên thành phố
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setDescription(rs.getString("description"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));

                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    public List<Property1> getPropertiesByCity(String city) {
        List<Property1> properties = new ArrayList<>();
        String query = "SELECT property_id,title, description, address, area, image_url, price FROM properties WHERE address LIKE ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + city + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setDescription(rs.getString("description"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setPrice(rs.getDouble("price"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    public List<Property1> getLargestAreaProperties(String city, int limit) {
        List<Property1> properties = new ArrayList<>();
        String query = "SELECT property_id,title, description, address, area, image_url, price FROM properties " +
                "WHERE address LIKE ? ORDER BY area DESC LIMIT ?"; // Lấy sản phẩm có diện tích lớn nhất

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + city + "%");
            stmt.setInt(2, limit); // Số lượng sản phẩm muốn lấy
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setDescription(rs.getString("description"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setPrice(rs.getDouble("price"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    public List<Property1> getHighestPriceProperties(String city, int limit) {
        List<Property1> properties = new ArrayList<>();
        String query = "SELECT property_id,title, description, address, area, image_url, price FROM properties " +
                "WHERE address LIKE ? ORDER BY price DESC LIMIT ?"; // Lấy sản phẩm có giá cao nhất

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + city + "%");
            stmt.setInt(2, limit); // Số lượng sản phẩm muốn lấy
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setDescription(rs.getString("description"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setPrice(rs.getDouble("price"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    public List<String> getThumbnailUrls(int propertyId) {
        List<String> thumbnailUrls = new ArrayList<>();
        String sql = "SELECT image_url FROM property_images WHERE property_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                thumbnailUrls.add(rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return thumbnailUrls;
    }

    public boolean addThumbnail(int propertyId, String thumbnailUrl) {

        String sql = "INSERT INTO property_images (property_id, image_url) VALUES (?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            stmt.setString(2, thumbnailUrl);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deleteThumbnail(int propertyId, String imageUrl) {
        String sql = "DELETE FROM property_images WHERE property_id = ? AND image_url = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, propertyId);
            ps.setString(2, imageUrl);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalProducts() {
        int totalProducts = 0;
        String sql = "SELECT COUNT(*) AS total FROM properties";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalProducts = rs.getInt("total");
            }

        } catch (SQLException e) {
            System.err.println("Error fetching total products: " + e.getMessage());
            e.printStackTrace();
        }
        return totalProducts;
    }

//    public boolean checkPosterExists(int posterId) {
//        String sql = "SELECT 1 FROM posters WHERE poster_id = ?";
//        try (Connection conn = Database.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, posterId);
//            ResultSet rs = stmt.executeQuery();
//            return rs.next();  // Nếu có kết quả, poster_id tồn tại
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }

    public int insertProperty(Property1 property) {
        String sql = "INSERT INTO properties (title, description, price, address, type, status, image_url, area, poster_id, created_at, updated_at,available) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(),?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, property.getTitle());
            stmt.setString(2, property.getDescription());
            stmt.setDouble(3, property.getPrice());
            stmt.setString(4, property.getAddress());
            stmt.setString(5, property.getType());
            stmt.setString(6, property.getStatus());
            stmt.setString(7, property.getImageUrl()); // Ảnh chính
            stmt.setDouble(8, property.getArea());
            stmt.setInt(9, property.getPosterId());
            stmt.setInt(10, property.getAvailable());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Trả về property_id vừa được tạo
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error while inserting property: " + e.getMessage());
        }
        return -1; // Trả về -1 nếu không thành công
    }

    public List<Property1> getPropertiesByUserId(int userId) throws Exception {
        List<Property1> properties = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Kết nối cơ sở dữ liệu
            conn = Database.getConnection();

            String query = "SELECT p.property_id, p.title, p.price, p.area, p.address, p.status, p.image_url "
                    + "FROM properties p "
                    + "JOIN posters ps ON p.poster_id = ps.poster_id "
                    + "WHERE ps.user_id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId); // Gán giá trị userId vào tham số ?

            rs = stmt.executeQuery();

            // Duyệt qua các kết quả và thêm vào danh sách properties
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setAddress(rs.getString("address"));
                property.setStatus(rs.getString("status"));
                property.setImageUrl(rs.getString("image_url"));

                properties.add(property); // Thêm bất động sản vào danh sách
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return properties;
    }

    public void insertPropertyImage(int propertyId, String imageUrl) {
        String sql = "INSERT INTO property_images (property_id, image_url) VALUES (?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, propertyId);  // Khóa ngoại
            stmt.setString(2, imageUrl); // URL ảnh bổ sung

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error while inserting property image: " + e.getMessage());
        }
    }

    public int getLastInsertedPropertyId() {
        String sql = "SELECT LAST_INSERT_ID()";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1); // Trả về property_id vừa chèn
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Nếu không lấy được ID
    }


    public List<Map<String, Object>> getTopPosterPosts() {
        List<Map<String, Object>> topPosters = new ArrayList<>();
        String sql = "SELECT p.poster_id,pr.email,pr.phone, pr.name AS poster_name, COUNT(*) AS post_count " +
                "FROM properties p " +
                "INNER JOIN posters pr ON p.poster_id = pr.poster_id " +
                "GROUP BY p.poster_id " +
                "ORDER BY post_count DESC " +
                "LIMIT 5";

        // Thực hiện kết nối cơ sở dữ liệu
        try (Connection connection = Database.getConnection(); // Database.getConnection() là phương thức kết nối tới cơ sở dữ liệu của bạn
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            // Duyệt qua kết quả và đưa vào danh sách
            while (resultSet.next()) {
                Map<String, Object> posterData = new HashMap<>();
                posterData.put("poster_id", resultSet.getInt("poster_id"));
                posterData.put("poster_name", resultSet.getString("poster_name"));
                posterData.put("post_count", resultSet.getInt("post_count"));
                posterData.put("poster_email", resultSet.getString("email"));
                posterData.put("poster_phone", resultSet.getString("phone"));

                topPosters.add(posterData);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return topPosters;
    }


    public List<Property1> getTop5NewestProperties() {
        List<Property1> topProperties = new ArrayList<>();

        String sql = "SELECT * FROM properties ORDER BY created_at DESC LIMIT 5";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setCreatedAt(rs.getTimestamp("created_at"));
                topProperties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topProperties;
    }

    public int getReviewCountByPropertyId(int propertyId) {
        int count = 0;
        try {
            // Truy vấn SQL để đếm số lượng đánh giá cho bất động sản theo propertyId
            String sql = "SELECT COUNT(*) FROM Reviews WHERE property_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, propertyId);  // Thiết lập giá trị propertyId vào câu truy vấn
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);  // Lấy số lượng đánh giá từ kết quả truy vấn
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }


    public int getCommentCountByPropertyId(int propertyId) {
        int count = 0;
        try {
            // Truy vấn SQL để đếm số lượng bình luận cho bất động sản theo propertyId
            String sql = "SELECT COUNT(*) FROM Comments WHERE property_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, propertyId);  // Thiết lập giá trị propertyId vào câu truy vấn
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);  // Lấy số lượng bình luận từ kết quả truy vấn
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Property1> getPropertyUnavailable() throws SQLException {
        List<Property1> property1s = new ArrayList<>();
        Connection connection = Database.getConnection();
        String sql = "SELECT * FROM properties WHERE available = 0";
        PreparedStatement ps = connection.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Property1 property = new Property1();
            property.setId(rs.getInt("property_id"));
            property.setTitle(rs.getString("title"));
            property.setPrice(rs.getDouble("price"));
            property.setArea(rs.getDouble("area"));
            property.setAddress(rs.getString("address"));
            property.setStatus(rs.getString("status"));
            property.setImageUrl(rs.getString("image_url"));
            property.setCreatedAt(rs.getTimestamp("created_at"));
            property1s.add(property);

        }
        return property1s;
    }

    public List<Property> getListPropertiesType(String nameType)   throws Exception {

        List<Property> propertyList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Kết nối đến cơ sở dữ liệu
            conn = Database.getConnection();
            // Truy vấn tất cả các bất động sản từ bảng 'properties'
            String query ="SELECT * FROM properties WHERE type= ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, nameType);
            rs = stmt.executeQuery();

            // Duyệt qua kết quả trả về và thêm vào danh sách 'properties'
            while (rs.next()) {
                Property property = new Property(
                        rs.getInt(
                                "property_id"),
                        rs.getString("title"),
                        rs.getString("address"),
                        rs.getDouble("price"),
                        rs.getDouble("area"),
                        rs.getString("image_url")
                );
                propertyList.add(property);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return propertyList;
    }
}





