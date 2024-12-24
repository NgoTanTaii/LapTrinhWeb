package Dao;

import DBcontext.Database;
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

        return Database.getConnection();
    }


    public List<Property1> getPropertiesByStatus(String status) {
        List<Property1> properties = new ArrayList<>();
        String sql = "SELECT * FROM properties WHERE status like ?";  // Truy vấn SQL

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, status);  // Thiết lập giá trị cho tham số status
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
                property.setAvailable(resultSet.getInt("available"));

                properties.add(property);  // Thêm bất động sản vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return properties;  // Trả về danh sách bất động sản
    }

    public int countPropertiesByStatus(String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM properties WHERE status like ?";  // Truy vấn SQL để đếm số lượng bất động sản

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, status);  // Thiết lập giá trị cho tham số status
            ResultSet resultSet = preparedStatement.executeQuery();  // Thực thi truy vấn

            if (resultSet.next()) {
                count = resultSet.getInt(1);  // Lấy số lượng bất động sản từ kết quả truy vấn
            }
        } catch (SQLException e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return count;  // Trả về số lượng bất động sản
    }

}
