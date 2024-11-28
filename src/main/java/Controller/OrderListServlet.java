package Controller;

import DBcontext.Database;
import Entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrderListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // List to store orders
        List<Order> orders = new ArrayList<>();

        // Get database connection
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT order_id, user_id, property_id, title, price, area, address, order_date FROM orders";
            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                // Fetch orders from result set
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    int userId = rs.getInt("user_id");
                    int propertyId = rs.getInt("property_id");
                    String title = rs.getString("title");
                    double price = rs.getDouble("price");
                    double area = rs.getDouble("area");
                    String address = rs.getString("address");
                    Date orderDate = rs.getDate("order_date");
                    orders.add(new Order(orderId, userId, propertyId, title, price, area, address, orderDate));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Set the list of orders in the request
        request.setAttribute("orders", orders);

        // Forward to JSP page
        request.getRequestDispatcher("orders.jsp").forward(request, response);
    }
}
