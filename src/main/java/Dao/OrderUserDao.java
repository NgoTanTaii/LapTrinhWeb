package Dao;


import DBcontext.Database;
import Entity.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderUserDao {

    // Lấy kết nối đến cơ sở dữ liệu
    public Connection getConnection() throws SQLException {
        return Database.getConnection();
    }

    // Phương thức lấy các đơn hàng của người dùng theo user_id
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT order_id, user_id, order_date, username FROM orders WHERE user_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set giá trị cho tham số trong câu truy vấn
            statement.setInt(1, userId);

            // Thực thi câu truy vấn
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả trả về
            while (resultSet.next()) {
                int orderId = resultSet.getInt("order_id");
                Date orderDate = resultSet.getDate("order_date");
                String username = resultSet.getString("username");
                int userid = resultSet.getInt("user_id");

                orders.add(new Order(orderId, orderDate, username, userid));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }
}
