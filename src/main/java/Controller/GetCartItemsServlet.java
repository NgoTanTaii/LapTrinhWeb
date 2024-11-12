package Controller;

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

@WebServlet("/getCartItems")
public class GetCartItemsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Get userId or username from the request
        String username = request.getParameter("username");
        Integer userId = null;

        if (username == null) {
            HttpSession session = request.getSession();
            userId = (Integer) session.getAttribute("userId");
        }

        // Validate user input
        if (userId == null && username == null) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Please provide either userId or username.");
            out.print(jsonResponse);
            return;
        }

        // Database connection
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {

            // Query to get cart items based on userId or username
            String query = "SELECT ci.id, ci.cart_id, ci.property_id, ci.title, ci.price, ci.area, ci.image_url, ci.quantity "
                    + "FROM cartitems ci "
                    + "JOIN cart c ON ci.cart_id = c.cart_id "
                    + "JOIN users u ON c.user_id = u.id "
                    + "WHERE u.id = ? OR u.username = ?";

            PreparedStatement stmt = conn.prepareStatement(query);

            if (userId != null) {
                stmt.setInt(1, userId); // Set userId parameter
                stmt.setString(2, null); // Set null for username
            } else if (username != null) {
                stmt.setInt(1, -1); // Set a dummy value for userId
                stmt.setString(2, username); // Set username parameter
            }

            ResultSet rs = stmt.executeQuery();

            // Fetch cart items
            JSONArray cartItemsArray = new JSONArray();
            while (rs.next()) {
                JSONObject item = new JSONObject();
                item.put("id", rs.getInt("id"));
                item.put("cart_id", rs.getInt("cart_id"));
                item.put("property_id", rs.getInt("property_id"));
                item.put("title", rs.getString("title"));
                item.put("price", rs.getDouble("price"));
                item.put("area", rs.getDouble("area"));
                item.put("image_url", rs.getString("image_url"));
                item.put("quantity", rs.getInt("quantity"));

                cartItemsArray.put(item);
            }

            // Send the cart items as a JSON response
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
