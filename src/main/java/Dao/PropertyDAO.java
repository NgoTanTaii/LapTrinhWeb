package Dao;

import DBcontext.DbConnection1;
import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {

    // Phương thức cập nhật thông tin bất động sản
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

    // Phương thức thêm bất động sản mới
    public void insertProperty(Property1 property) {
        String sql = "INSERT INTO properties (title, price, area, address, type, status, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, property.getTitle());
            stmt.setDouble(2, property.getPrice());
            stmt.setDouble(3, property.getArea());
            stmt.setString(4, property.getAddress());
            stmt.setString(5, property.getType());
            stmt.setString(6, property.getStatus());
            stmt.setString(7, property.getImageUrl());
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

    // Kết nối tới CSDL
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
}


