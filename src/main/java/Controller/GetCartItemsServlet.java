package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.cloudinary.json.JSONArray;
import org.cloudinary.json.JSONObject;

import java.io.IOException;
import java.sql.*;

@WebServlet("/getCartItems")
public class GetCartItemsServlet extends HttpServlet {

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

            // Lấy userId từ username trong bảng users
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

                    // Lấy cart_id từ bảng cart của người dùng
                    String getCartIdQuery = "SELECT cart_id FROM cart WHERE user_id = ?";
                    try (PreparedStatement cartStmt = conn.prepareStatement(getCartIdQuery)) {
                        cartStmt.setInt(1, userId);
                        try (ResultSet cartResult = cartStmt.executeQuery()) {
                            if (!cartResult.next()) {
                                jsonResponse.put("success", false);
                                jsonResponse.put("message", "Cart not found.");
                                response.getWriter().print(jsonResponse);
                                return;
                            }

                            int cartId = cartResult.getInt("cart_id");

                            // Lấy các mục trong giỏ hàng từ bảng cartitems
                            String getCartItemsQuery =
                                    "SELECT * FROM cartitems WHERE cart_id = ?";
                            try (PreparedStatement itemsStmt = conn.prepareStatement(getCartItemsQuery)) {
                                itemsStmt.setInt(1, cartId);
                                try (ResultSet itemsResult = itemsStmt.executeQuery()) {
                                    JSONArray cartItems = new JSONArray();

                                    while (itemsResult.next()) {
                                        JSONObject item = new JSONObject();
                                        item.put("property_id", itemsResult.getInt("property_id"));
                                        item.put("title", itemsResult.getString("title"));
                                        item.put("price", itemsResult.getDouble("price"));
                                        item.put("quantity", itemsResult.getInt("quantity"));
                                        item.put("area", itemsResult.getDouble("area"));
                                        item.put("image_url", itemsResult.getString("image_url"));
                                        item.put("address", itemsResult.getString("address"));
                                        cartItems.put(item);
                                    }

                                    // Trả về giỏ hàng dưới dạng JSON
                                    jsonResponse.put("success", true);
                                    jsonResponse.put("userId", userId);
                                    jsonResponse.put("cartItems", cartItems);
                                    response.getWriter().print(jsonResponse);
                                }
                            }
                        }
                    }
                }
            }

        } catch (SQLException e) {
            // In log error cho các nhà phát triển nhưng gửi thông báo lỗi chung cho client
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error.");
            response.getWriter().print(jsonResponse);
        }
    }
}
