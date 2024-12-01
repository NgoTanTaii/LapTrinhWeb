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

            return Database.getConnection();
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


}
