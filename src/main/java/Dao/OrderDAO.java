package Dao;

import DBcontext.Database;
import Entity.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {


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

}

