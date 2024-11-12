package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/getUserCart")
public class GetUserCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Lấy `username` từ tham số request
        String username = request.getParameter("username");
        if (username == null || username.isEmpty()) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Username is required.");
            out.print(jsonResponse);
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webbds", "root", "123456")) {
            // Lấy `userId` dựa trên `username`
            String getUserQuery = "SELECT id FROM users WHERE username = ?";
            try (PreparedStatement userStmt = conn.prepareStatement(getUserQuery)) {
                userStmt.setString(1, username);
                ResultSet userResult = userStmt.executeQuery();

                if (!userResult.next()) {
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "User not found.");
                    out.print(jsonResponse);
                    return;
                }

                int userId = userResult.getInt("id");

                // Lấy giỏ hàng dựa trên `userId`
                String getCartItemsQuery = "SELECT * FROM cartitems WHERE user_id = ?";
                try (PreparedStatement cartStmt = conn.prepareStatement(getCartItemsQuery)) {
                    cartStmt.setInt(1, userId);
                    ResultSet cartResult = cartStmt.executeQuery();

                    JSONArray cartItems = new JSONArray();
                    while (cartResult.next()) {
                        JSONObject item = new JSONObject();
                        item.put("property_id", cartResult.getInt("property_id"));
                        item.put("title", cartResult.getString("title"));
                        item.put("price", cartResult.getDouble("price"));
                        item.put("area", cartResult.getDouble("area"));
                        item.put("image_url", cartResult.getString("image_url"));
                        item.put("quantity", cartResult.getInt("quantity"));
                        cartItems.put(item);
                    }

                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("success", true);
                    jsonResponse.put("userId", userId);
                    jsonResponse.put("cartItems", cartItems);
                    out.print(jsonResponse);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error.");
            out.print(jsonResponse);
        }
    }
}
