package Controller;

import Dao.CartService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // Helper method to get database connection
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";
        return DriverManager.getConnection(url, dbUser, dbPassword);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Read the incoming JSON data from the request
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }

        // Parse the JSON data into a JSONObject
        JSONObject jsonRequest = new JSONObject(sb.toString());
        int userId = jsonRequest.getInt("userId");
        int cartId = jsonRequest.getInt("cartId");
        JSONArray cartItems = jsonRequest.getJSONArray("cartItems");

        // Call CartService to save the cart items to the database
        CartService cartService = new CartService();
        boolean success = cartService.saveCartToDatabase(userId, cartId, cartItems);

        // Send the response to the client
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", success);
        if (success) {
            jsonResponse.put("message", "Giỏ hàng đã được lưu vào cơ sở dữ liệu.");
        } else {
            jsonResponse.put("message", "Lỗi khi lưu giỏ hàng.");
        }

        out.print(jsonResponse);
    }

    // Handle retrieving the cart items
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "User not logged in.");
            out.print(jsonResponse);
            return;
        }

        try (Connection conn = getConnection()) {
            // Retrieve the user's cart
            String cartQuery = "SELECT cart_id FROM cart WHERE user_id = ?";
            PreparedStatement cartStmt = conn.prepareStatement(cartQuery);
            cartStmt.setInt(1, userId);
            ResultSet rs = cartStmt.executeQuery();

            int cartId = -1;
            if (rs.next()) {
                cartId = rs.getInt("cart_id");
            }

            if (cartId == -1) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No cart found for the user.");
                out.print(jsonResponse);
                return;
            }

            // Retrieve cart items for the user
            String cartItemsQuery = "SELECT ci.property_id, ci.quantity, p.title, p.price, p.image_url " +
                    "FROM cartitems ci " +
                    "JOIN properties p ON ci.property_id = p.property_id " +
                    "WHERE ci.cart_id = ?";
            PreparedStatement cartItemsStmt = conn.prepareStatement(cartItemsQuery);
            cartItemsStmt.setInt(1, cartId);
            ResultSet cartItemsRs = cartItemsStmt.executeQuery();

            JSONArray cartItemsArray = new JSONArray();
            while (cartItemsRs.next()) {
                JSONObject item = new JSONObject();
                item.put("property_id", cartItemsRs.getInt("property_id"));
                item.put("quantity", cartItemsRs.getInt("quantity"));
                item.put("title", cartItemsRs.getString("title"));
                item.put("price", cartItemsRs.getDouble("price"));
                item.put("image_url", cartItemsRs.getString("image_url"));

                cartItemsArray.put(item);
            }

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("cartItems", cartItemsArray);
            out.print(jsonResponse);

        } catch (SQLException e) {
            e.printStackTrace();
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error.");
            out.print(jsonResponse);
        }
    }
}
