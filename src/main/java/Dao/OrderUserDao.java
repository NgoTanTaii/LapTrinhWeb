package Dao;

import DBcontext.Database;
import Entity.Order;
import Entity.OrderItem;

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

    // Lấy đơn hàng theo order_id
    public Order getOrderById(int orderId) {
        Order order = null;
        String query = "SELECT order_id, user_id, order_date, username FROM orders WHERE order_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set giá trị cho tham số trong câu truy vấn
            statement.setInt(1, orderId);

            // Thực thi câu truy vấn
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả trả về
            if (resultSet.next()) {
                int userId = resultSet.getInt("user_id");
                Date orderDate = resultSet.getDate("order_date");
                String username = resultSet.getString("username");

                order = new Order(orderId, orderDate, username, userId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    // Lấy các mục trong đơn hàng theo order_id
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT oi.property_id, oi.title, oi.price, oi.quantity " +
                "FROM orderitems oi " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE oi.order_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set giá trị cho tham số trong câu truy vấn
            statement.setInt(1, orderId);

            // Thực thi câu truy vấn
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả trả về
            while (resultSet.next()) {
                int propertyId = resultSet.getInt("property_id");
                String title = resultSet.getString("title");
                double price = resultSet.getDouble("price");
                int quantity = resultSet.getInt("quantity");

                orderItems.add(new OrderItem(propertyId, title, price, quantity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }
}
