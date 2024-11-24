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

@WebServlet("/getCartItems")
public class GetCartItemsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Lấy username từ session
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "User is not logged in.");
            out.print(jsonResponse);
            return;
        }

        // Kết nối đến cơ sở dữ liệu
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";
        Connection conn = null;

        try {
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Lấy userId dựa trên username
            String getUserQuery = "SELECT id FROM users WHERE username = ?";
            PreparedStatement userStmt = conn.prepareStatement(getUserQuery);
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

            // Lấy giỏ hàng của người dùng từ bảng cartitems
            String getCartItemsQuery = "SELECT * FROM cartitems WHERE user_id = ?";
            PreparedStatement cartStmt = conn.prepareStatement(getCartItemsQuery);
            cartStmt.setInt(1, userId);
            ResultSet cartResult = cartStmt.executeQuery();

            JSONArray cartItems = new JSONArray();

            // Lưu trữ các mục giỏ hàng vào JSONArray
            while (cartResult.next()) {
                JSONObject item = new JSONObject();
                item.put("property_id", cartResult.getInt("property_id"));
                item.put("title", cartResult.getString("title"));
                item.put("price", cartResult.getDouble("price"));
                item.put("area", cartResult.getDouble("area"));
                item.put("image_url", cartResult.getString("image_url"));
                item.put("quantity", cartResult.getInt("quantity"));
                item.put("address", cartResult.getString("address"));  // Nếu có trường address
                cartItems.put(item);
            }

            // Trả về dữ liệu giỏ hàng dưới dạng JSON
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("userId", userId);
            jsonResponse.put("cartItems", cartItems);

            out.print(jsonResponse);

        } catch (SQLException e) {
            e.printStackTrace();
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error.");
            out.print(jsonResponse);
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
