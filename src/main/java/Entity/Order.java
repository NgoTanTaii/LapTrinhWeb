package Entity;

import DBcontext.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;

    // Constructor
    public Order(int orderId, int userId) {
        this.orderId = orderId;
        this.userId = userId;
    }

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Method to get orders from database
    public static List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT order_id, user_id FROM Orders";  // Only select order_id and user_id
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                orders.add(new Order(orderId, userId));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
