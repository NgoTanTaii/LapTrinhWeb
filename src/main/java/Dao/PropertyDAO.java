package Dao;

import DBcontext.ConnectDB;
import DBcontext.Database;
import DBcontext.DbConnection1;
import Entity.Comment;
import Entity.Property;
import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {
    public void updateProperty(Property1 property) {
        String sql = "UPDATE properties SET title = ?, price = ?, address = ?, area = ?, image_url = ?, description = ?, type = ?, status = ? WHERE property_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, property.getTitle());
            stmt.setDouble(2, property.getPrice());
            stmt.setString(3, property.getAddress());
            stmt.setDouble(4, property.getArea());
            stmt.setString(5, property.getImageUrl());
            stmt.setString(6, property.getDescription());
            stmt.setString(7, property.getType());
            stmt.setString(8, property.getStatus());
            stmt.setInt(9, property.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    public Property1 getPropertyById(int id) {
        Property1 property = null;
        String query = "SELECT property_id, title, price, address, area, image_url, description, type, status, poster_id FROM properties WHERE property_id = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setAddress(rs.getString("address"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setDescription(rs.getString("description"));
                property.setType(rs.getString("type"));
                property.setStatus(rs.getString("status"));
                property.setPosterId(rs.getInt("poster_id")); // Lưu poster_id vào property
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return property;
    }

    // Phương thức xóa bất động sản
    public void deleteProperty(int propertyId) {
        String sql = "DELETE FROM properties WHERE property_id = ?";
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

        String url = "jdbc:mysql://localhost:3306/webbds";  // Chỉnh sửa tên database nếu cần
        String user = "root";
        String password = "123456";  // Cập nhật mật khẩu nếu cần
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

    public void createProperty(Property1 property) {
        String sql = "INSERT INTO properties (title, price, address, area, image_url, description, type, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, property.getTitle());
            stmt.setDouble(2, property.getPrice());
            stmt.setString(3, property.getAddress());
            stmt.setDouble(4, property.getArea());
            stmt.setString(5, property.getImageUrl());
            stmt.setString(6, property.getDescription());
            stmt.setString(7, property.getType());
            stmt.setString(8, property.getStatus());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
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

        try (Connection conn = DbConnection1.initializeDatabase();
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
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return properties;
    }

    public List<Property1> getPropertiesByCity(String city) {
        List<Property1> properties = new ArrayList<>();
        String query = "SELECT property_id,title, description, address, area, image_url, price FROM properties WHERE address LIKE ?";

        try (Connection conn = DbConnection1.initializeDatabase();
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
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return properties;
    }

    public List<Property1> getLargestAreaProperties(String city, int limit) {
        List<Property1> properties = new ArrayList<>();
        String query = "SELECT property_id,title, description, address, area, image_url, price FROM properties " +
                "WHERE address LIKE ? ORDER BY area DESC LIMIT ?"; // Lấy sản phẩm có diện tích lớn nhất

        try (Connection conn = DbConnection1.initializeDatabase();
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
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return properties;
    }

    public List<Property1> getHighestPriceProperties(String city, int limit) {
        List<Property1> properties = new ArrayList<>();
        String query = "SELECT property_id,title, description, address, area, image_url, price FROM properties " +
                "WHERE address LIKE ? ORDER BY price DESC LIMIT ?"; // Lấy sản phẩm có giá cao nhất

        try (Connection conn = DbConnection1.initializeDatabase();
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
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
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

    public void addThumbnail(int propertyId, String imageUrl) {
        String sql = "INSERT INTO property_images (property_id, image_url) VALUES (?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            stmt.setString(2, imageUrl);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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

    public List<Property> getListPropertiesType(String nameType)   throws Exception {

        List<Property> propertyList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Kết nối đến cơ sở dữ liệu
            conn = DbConnection1.initializeDatabase();
            // Truy vấn tất cả các bất động sản từ bảng 'properties'
            String query ="SELECT * FROM properties WHERE type=?";
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














