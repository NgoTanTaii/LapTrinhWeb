package Controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestMain {
    public static void main(String[] args) {
        // Thông tin kết nối cơ sở dữ liệu
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        // ID đơn hàng cần kiểm tra
        int testOrderId = 23;  // Thay thế bằng một ID đơn hàng hợp lệ

        try {
            // Kết nối tới cơ sở dữ liệu
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            System.out.println("Database connection established.");

            // Bước 1: Lấy thông tin đơn hàng theo orderId
            String orderQuery = "SELECT order_id, user_id, order_date FROM orders WHERE order_id = ?";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery);
            orderStmt.setInt(1, testOrderId);
            ResultSet orderRs = orderStmt.executeQuery();

            if (orderRs.next()) {
                int orderId = orderRs.getInt("order_id");
                int userId = orderRs.getInt("user_id");
                java.sql.Date orderDate = orderRs.getDate("order_date");

                System.out.println("Order ID: " + orderId);
                System.out.println("User ID: " + userId);
                System.out.println("Order Date: " + orderDate);
            } else {
                System.out.println("No order found with Order ID: " + testOrderId);
                return; // Không có đơn hàng thì dừng lại
            }

            // Bước 2: Lấy các mục trong đơn hàng theo orderId
            String orderItemsQuery = "SELECT order_item_id, property_id, quantity, price, title FROM orderitems WHERE order_id = ?";
            PreparedStatement orderItemsStmt = conn.prepareStatement(orderItemsQuery);
            orderItemsStmt.setInt(1, testOrderId);
            ResultSet itemsRs = orderItemsStmt.executeQuery();

            System.out.println("Items in Order ID " + testOrderId + ":");
            if (!itemsRs.isBeforeFirst()) { // Kiểm tra nếu ResultSet rỗng
                System.out.println("No items in this order.");
            }

            while (itemsRs.next()) {
                int orderItemId = itemsRs.getInt("order_item_id");
                int propertyId = itemsRs.getInt("property_id");
                int quantity = itemsRs.getInt("quantity");
                double price = itemsRs.getDouble("price");
                String title = itemsRs.getString("title");

                System.out.println("Order Item ID: " + orderItemId +
                        ", Property ID: " + propertyId +
                        ", Quantity: " + quantity +
                        ", Price: " + price +
                        ", Title: " + title);
            }

            // Đóng các tài nguyên
            orderRs.close();
            orderStmt.close();
            itemsRs.close();
            orderItemsStmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
