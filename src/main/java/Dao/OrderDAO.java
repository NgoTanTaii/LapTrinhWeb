package Dao;

import DBcontext.Database;
import Entity.Order;
import Entity.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection connection;

    public OrderDAO() throws SQLException {
        connection = Database.getConnection();
    }

    // Tạo đơn hàng mới
    public int createOrder(Order order) {
        String query = "INSERT INTO orders (user_id, status) VALUES (?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, order.getUserId());

            stmt.setString(3, order.getStatus());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về ID của đơn hàng vừa tạo
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Lấy danh sách tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // Lấy danh sách sản phẩm trong đơn hàng
                List<OrderItem> items = getOrderItemsByCartId(orderId);

                orders.add(new Order(
                        orderId,
                        rs.getInt("user_id"),
                        rs.getString("status"),
                        rs.getString("created_at"),
                        items
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE orders SET status = ? WHERE order_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách sản phẩm từ cartitems thông qua cart_id
    public List<OrderItem> getOrderItemsByCartId(int cartId) {
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT * FROM cartitems WHERE cart_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(new OrderItem(
                        rs.getInt("id"),
                        cartId,
                        rs.getInt("property_id"),
                        rs.getString("title"),
                        rs.getDouble("price"),
                        rs.getFloat("area"),
                        rs.getString("image_url"),
                        rs.getInt("quantity"),
                        rs.getString("address")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
}
