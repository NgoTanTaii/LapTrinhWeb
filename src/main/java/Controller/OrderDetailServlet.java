package Controller;

import DBcontext.Database;
import Entity.Order;
import Entity.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy orderId từ tham số trong URL
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        // Lấy thông tin đơn hàng
        Order order = getOrderById(orderId);

        // Lấy danh sách các món hàng trong đơn hàng
        List<OrderItem> orderItems = getOrderItemsByOrderId(orderId);

        // Set thông tin đơn hàng và các món hàng vào request
        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);

        // Forward đến trang JSP để hiển thị
        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
    }

    // Hàm lấy thông tin đơn hàng
    private Order getOrderById(int orderId) {
        Order order = null;
        String query = "SELECT order_id, user_id FROM orders WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    order = new Order(orderId, userId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    // Hàm lấy danh sách OrderItems của đơn hàng
    private List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT order_item_id, property_id, quantity, price, title FROM orderitems WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderItemId = rs.getInt("order_item_id");
                    int propertyId = rs.getInt("property_id");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    String title = rs.getString("title");
                    orderItems.add(new OrderItem(orderItemId, orderId, propertyId, quantity, price, title));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }
}
