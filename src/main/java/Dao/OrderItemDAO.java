package Dao;

import DBcontext.Database;
import Entity.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {
    private Connection connection;

    public OrderItemDAO() throws SQLException {
        connection = Database.getConnection();
    }

    public void addOrderItems(List<OrderItem> items, int orderId) {
        String query = "INSERT INTO order_items (order_id, property_id, title, price, area, image_url, quantity, address) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            for (OrderItem item : items) {
                PreparedStatement stmt = connection.prepareStatement(query);
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getPropertyId());
                stmt.setString(3, item.getTitle());
                stmt.setDouble(4, item.getPrice());
                stmt.setFloat(5, item.getArea());
                stmt.setString(6, item.getImageUrl());
                stmt.setInt(7, item.getQuantity());
                stmt.setString(8, item.getAddress());
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE order_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(new OrderItem(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
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
