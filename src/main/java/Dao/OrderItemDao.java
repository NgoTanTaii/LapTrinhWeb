package Dao;

import DBcontext.Database;
import Entity.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDao {

    // Lấy các mục trong đơn hàng theo orderId
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM orderitems WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderId(orderId);
                    orderItem.setPropertyId(rs.getInt("property_id"));
                    orderItem.setQuantity(rs.getInt("quantity"));
                    orderItem.setPrice(rs.getInt("price"));
                    orderItem.setTitle(rs.getString("title"));
                    orderItem.setStatus(rs.getString("status"));

                    orderItems.add(orderItem);




                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }



}
