package Dao;

import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertySearchDAO {

    public List<Property1> searchProducts(String searchText, String city) {
        List<Property1> properties = new ArrayList<>();

        // Tạo câu truy vấn SQL để tìm kiếm sản phẩm theo tên và địa chỉ
        // Điều kiện sẽ là tìm kiếm bất kỳ phần nào trong địa chỉ (không chỉ thành phố)
        String sql = "SELECT * FROM properties WHERE title LIKE ? AND address LIKE ?";

        // Kết nối đến cơ sở dữ liệu
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/webbds", "root", "123456");
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Set giá trị cho tham số trong câu truy vấn (tìm kiếm theo tên sản phẩm)
            stmt.setString(1, "%" + searchText + "%");

            // Nếu người dùng nhập thành phố, tìm kiếm theo thành phố đó trong toàn bộ địa chỉ
            if (city != null && !city.trim().isEmpty()) {
                // Tìm kiếm từ khóa trong toàn bộ địa chỉ (bao gồm cả thành phố)
                stmt.setString(2, "%" + city + "%");
            } else {
                // Nếu không có thành phố, tìm kiếm trong toàn bộ địa chỉ
                stmt.setString(2, "%");
            }

            // Thực thi câu truy vấn và lấy kết quả
            ResultSet rs = stmt.executeQuery();

            // Duyệt qua kết quả và thêm vào danh sách properties
            while (rs.next()) {
                Property1 property = new Property1();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setImageUrl(rs.getString("image_url"));
                property.setAddress(rs.getString("address"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return properties;
    }
}
