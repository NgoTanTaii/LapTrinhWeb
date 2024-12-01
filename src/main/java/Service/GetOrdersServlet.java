package Service;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.*;

@WebServlet("/getOrders")
public class GetOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        // Lấy username từ session
        String username = (String) request.getSession().getAttribute("username");
        JSONObject jsonResponse = new JSONObject();

        // Nếu người dùng chưa đăng nhập
        if (username == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "User is not logged in.");
            response.getWriter().print(jsonResponse);
            return;
        }

        // Sử dụng Database.getConnection() để kết nối CSDL
        try (Connection conn = Database.getConnection()) {

            // Lấy userId từ username
            String getUserQuery = "SELECT id FROM users WHERE username = ?";
            try (PreparedStatement userStmt = conn.prepareStatement(getUserQuery)) {
                userStmt.setString(1, username);
                try (ResultSet userResult = userStmt.executeQuery()) {
                    if (!userResult.next()) {
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "User not found.");
                        response.getWriter().print(jsonResponse);
                        return;
                    }

                    int userId = userResult.getInt("id");

                    // Lấy các đơn hàng của người dùng
                    String getOrdersQuery = "SELECT order_id, order_date, username FROM orders WHERE user_id = ?";
                    try (PreparedStatement ordersStmt = conn.prepareStatement(getOrdersQuery)) {
                        ordersStmt.setInt(1, userId);
                        try (ResultSet ordersResult = ordersStmt.executeQuery()) {
                            JSONArray orders = new JSONArray();

                            while (ordersResult.next()) {
                                int orderId = ordersResult.getInt("order_id");
                                Date orderDate = ordersResult.getDate("order_date");
                                String orderUsername = ordersResult.getString("username");


                                // Tạo đối tượng JSON cho mỗi đơn hàng
                                JSONObject order = new JSONObject();
                                order.put("order_id", orderId);
                                order.put("order_date", orderDate.toString());
                                order.put("username", orderUsername);


                                // Lấy các mục trong đơn hàng từ bảng orderitems
                                String getOrderItemsQuery = "SELECT order_item_id, property_id, quantity, price, title FROM orderitems WHERE order_id = ?";
                                try (PreparedStatement orderItemsStmt = conn.prepareStatement(getOrderItemsQuery)) {
                                    orderItemsStmt.setInt(1, orderId);
                                    try (ResultSet orderItemsResult = orderItemsStmt.executeQuery()) {
                                        JSONArray orderItems = new JSONArray();
                                        while (orderItemsResult.next()) {
                                            JSONObject item = new JSONObject();
                                            item.put("order_item_id", orderItemsResult.getInt("order_item_id"));
                                            item.put("property_id", orderItemsResult.getInt("property_id"));
                                            item.put("quantity", orderItemsResult.getInt("quantity"));
                                            item.put("price", orderItemsResult.getDouble("price"));
                                            item.put("title", orderItemsResult.getString("title"));
                                            orderItems.put(item);
                                        }
                                        order.put("order_items", orderItems); // Thêm orderItems vào đơn hàng
                                    }
                                }

                                // Thêm đơn hàng vào danh sách
                                orders.put(order);
                            }

                            // Trả về kết quả JSON
                            jsonResponse.put("success", true);
                            jsonResponse.put("userId", userId);
                            jsonResponse.put("orders", orders);
                            response.getWriter().print(jsonResponse);
                        }
                    }
                }
            }

        } catch (SQLException e) {
            // In log error for developers but send a generic message to client
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error.");
            response.getWriter().print(jsonResponse);
        }
    }
}
