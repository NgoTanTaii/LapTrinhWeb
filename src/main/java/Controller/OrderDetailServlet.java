package Controller;

import DBcontext.Database;
import Dao.OrderItemDao;
import Entity.Order;
import Entity.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy orderId từ tham số request
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            request.setAttribute("error", "Order ID is missing.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        int orderId;

        try {
            orderId = Integer.parseInt(orderIdParam);  // Chuyển orderId thành kiểu int
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid order ID.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin đơn hàng từ database
        Order order = getOrderById(orderId);
        OrderItemDao orderItemDao = new OrderItemDao();  // Sử dụng OrderItemDao
        List<OrderItem> orderItems = orderItemDao.getOrderItemsByOrderId(orderId);  // Lấy các mục trong đơn hàng

        if (order == null) {
            request.setAttribute("error", "Order not found.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Set dữ liệu vào request để truyền cho JSP
        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);
        System.out.println(orderItems);

        // Forward tới order-detail.jsp
        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
    }

    // Lấy thông tin đơn hàng theo orderId
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
