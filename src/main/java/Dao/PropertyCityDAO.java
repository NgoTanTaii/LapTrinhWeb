package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import DBcontext.Database;
import Entity.Property1;


public class PropertyCityDAO {

    // Kết nối cơ sở dữ liệu
    private Connection getConnection() throws SQLException {
        try {
            // Thay đổi thông tin kết nối cơ sở dữ liệu của bạn tại đây
            String url = "jdbc:mysql://localhost:3306/webbds";
            String user = "root";
            String password = "123456";
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            throw new SQLException("Kết nối cơ sở dữ liệu không thành công.", e);
        }
    }

    // Phương thức lọc bất động sản theo tên thành phố
    public List<Property1> getPropertiesByCity(String city) throws SQLException {
        List<Property1> properties = new ArrayList<>();
        String sql = "SELECT * FROM properties WHERE address LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Tìm kiếm thành phố ở cuối địa chỉ
            pstmt.setString(1, "%" + city);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Property1 property = new Property1();
                    property.setId(rs.getInt("property_id"));
                    property.setTitle(rs.getString("title"));
                    property.setPrice(rs.getDouble("price"));
                    property.setAddress(rs.getString("address"));
                    property.setDescription(rs.getString("description"));
                    property.setAddress(extractCityFromAddress(rs.getString("address")));

                    properties.add(property);
                }
            }
        }

        return properties;
    }

    // Phương thức trích xuất thành phố từ địa chỉ
    private String extractCityFromAddress(String address) {

        String[] addressParts = address.split(",");
        return addressParts[addressParts.length - 1].trim(); // Lấy thành phố ở cuối
    }


    public List<Property1> filterPropertiesByPrice(String priceRange) {
        List<Property1> properties = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM properties WHERE 1=1");

        // Lọc theo khoảng giá
        if (priceRange != null && !priceRange.isEmpty()) {
            if ("thoa-thuan".equals(priceRange)) {
                sql.append(" AND price IS NULL");
            } else {
                String[] priceBounds = priceRange.split("-");
                if (priceBounds.length == 2) {
                    double priceMin = Double.parseDouble(priceBounds[0]);
                    double priceMax = Double.parseDouble(priceBounds[1]);
                    sql.append(" AND price BETWEEN ? AND ?");
                }
            }
        }

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int index = 1;

            // Đặt giá trị cho khoảng giá
            if (priceRange != null && !priceRange.isEmpty() && !priceRange.equals("thoa-thuan")) {
                String[] priceBounds = priceRange.split("-");
                double priceMin = Double.parseDouble(priceBounds[0]);
                double priceMax = Double.parseDouble(priceBounds[1]);
                stmt.setDouble(index++, priceMin);
                stmt.setDouble(index++, priceMax);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setAddress(rs.getString("address"));
                property.setDescription(rs.getString("description"));
                properties.add(property);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return properties;
    }

    public List<Property1> filterPropertiesByArea(String areaRange) {
        List<Property1> properties = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM properties WHERE 1=1");

        // Lọc theo diện tích
        if (areaRange != null && !areaRange.isEmpty()) {
            String[] areaBounds = areaRange.split("-");
            if (areaBounds.length == 2) {
                double areaMin = Double.parseDouble(areaBounds[0]);
                double areaMax = Double.parseDouble(areaBounds[1]);
                sql.append(" AND area BETWEEN ? AND ?");
            }
        }

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int index = 1;

            // Đặt giá trị cho diện tích
            if (areaRange != null && !areaRange.isEmpty()) {
                String[] areaBounds = areaRange.split("-");
                double areaMin = Double.parseDouble(areaBounds[0]);
                double areaMax = Double.parseDouble(areaBounds[1]);
                stmt.setDouble(index++, areaMin);
                stmt.setDouble(index++, areaMax);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setAddress(rs.getString("address"));
                property.setDescription(rs.getString("description"));
                properties.add(property);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return properties;
    }


}
