package Dao;

import Entity.Property1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class PropertyBystatusDAO {

    // Phương thức để lấy kết nối đến cơ sở dữ liệu
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/webbds";  // Chỉnh sửa tên database nếu cần
        String user = "root";
        String password = "123456";  // Cập nhật mật khẩu nếu cần
        return DriverManager.getConnection(url, user, password);
    }


    public List<Property1> getPropertiesByStatus(int status) {
        List<Property1> properties = new ArrayList<>();
        String sql = "SELECT * FROM properties WHERE status = ?";  // Truy vấn SQL

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, status);  // Thiết lập giá trị cho tham số status
            ResultSet resultSet = preparedStatement.executeQuery();  // Thực thi truy vấn

            // Duyệt qua kết quả và thêm vào danh sách properties
            while (resultSet.next()) {
                Property1 property = new Property1();
                property.setStatus(resultSet.getString("status"));
                property.setId(resultSet.getInt("property_id"));
                property.setArea(resultSet.getDouble("area"));
                property.setPrice(resultSet.getDouble("price"));
                property.setTitle(resultSet.getString("title"));
                property.setDescription(resultSet.getString("description"));
                property.setImageUrl(resultSet.getString("image_url"));
                property.setAddress(resultSet.getString("address"));
                property.setType(resultSet.getString("type"));

                properties.add(property);  // Thêm bất động sản vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return properties;  // Trả về danh sách bất động sản
    }
}
