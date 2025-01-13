package Dao;

import DBcontext.Database;
import Entity.Order;
import Entity.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT oi.order_item_id, oi.property_id, oi.quantity, oi.price, oi.title, oi.status " +
                "FROM orderitems oi " +
                "WHERE oi.order_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, orderId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderItemId = rs.getInt("order_item_id");
                    int propertyId = rs.getInt("property_id");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    String title = rs.getString("title");
                    String status = rs.getString("status");

                    // Assuming OrderItem has a constructor to set values
                    OrderItem orderItem = new OrderItem(orderItemId, orderId, propertyId, quantity, price, title, status);
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }


    // Lấy tất cả đơn hàng có trạng thái 'processed'
    public List<Order> getProcessedOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.user_id, o.username, o.order_date, oi.status " +
                "FROM orders o " +
                "JOIN orderitems oi ON o.order_id = oi.order_id " +
                "WHERE oi.status = 'processed'";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                String userName = rs.getString("username");
                Date orderDate = rs.getDate("order_date");
                String status = rs.getString("status");

                Order order = new Order(orderId, userId, userName, orderDate, status);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Thêm một đơn hàng mới
    public boolean addOrder(Order order) {
        String query = "INSERT INTO orders (order_id, user_id, username, order_date, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, order.getOrderId());
            stmt.setInt(2, order.getUserId());
            stmt.setString(3, order.getUserName());
            stmt.setDate(4, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setString(5, order.getStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE orders SET status = ? WHERE order_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa một đơn hàng
    public boolean deleteOrder(int orderId) {
        String query = "DELETE FROM orders WHERE order_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, orderId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean confirmOrder(int orderId) {
        // Câu lệnh SQL để cập nhật trạng thái đơn hàng trong bảng orderitems
        String sql = "UPDATE orderitems SET status = 'processed' WHERE order_id = ? AND status = 'pending'";

        // Thực thi câu lệnh SQL
        try (Connection conn = Database.getConnection();  // Kết nối đến cơ sở dữ liệu
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Thiết lập tham số cho câu lệnh SQL (orderId)
            stmt.setInt(1, orderId);

            // Thực thi câu lệnh và lấy số dòng bị ảnh hưởng
            int rowsAffected = stmt.executeUpdate();

            // Kiểm tra xem có dòng nào bị ảnh hưởng không (nếu có, nghĩa là cập nhật thành công)
            return rowsAffected > 0;
        } catch (SQLException e) {
            // In lỗi nếu có lỗi xảy ra trong quá trình kết nối hoặc thực thi SQL
            System.err.println("Error while confirming order: " + e.getMessage());
            e.printStackTrace();
            return false;
        }


    }

    public boolean deleteOrderItemsByOrderId(String orderId) {
        String sql = "DELETE FROM orderitems WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, orderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    private Order getOrderById(int orderId) {
        Order order = null;
        String query = "SELECT order_id, user_id, order_date, username FROM orders WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    Date orderDate = rs.getDate("order_date");
                    String username = rs.getString("username");
                    order = new Order(orderId, orderDate, username, userId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }


}
