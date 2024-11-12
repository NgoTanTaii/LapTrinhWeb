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

@WebServlet("/saveCart")
public class SaveCartServlet extends HttpServlet {

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

        // Database connection setup
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {

            // Start a transaction
            conn.setAutoCommit(false);

            // Prepare SQL to insert/update items in the cartitems table
            String insertItemQuery = "INSERT INTO cartitems (cart_id, user_id, property_id, title, price, area, image_url, quantity) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE quantity = quantity + ?";

            try (PreparedStatement insertItemStmt = conn.prepareStatement(insertItemQuery)) {
                // Iterate over each cart item and add to the batch
                for (int i = 0; i < cartItems.length(); i++) {
                    JSONObject item = cartItems.getJSONObject(i);
                    int propertyId = item.getInt("id");
                    int quantity = item.getInt("quantity");

                    // Set the parameters for the statement
                    insertItemStmt.setInt(1, cartId);  // cart_id
                    insertItemStmt.setInt(2, userId);  // user_id
                    insertItemStmt.setInt(3, propertyId); // property_id
                    insertItemStmt.setString(4, item.getString("title")); // title
                    insertItemStmt.setDouble(5, item.getDouble("price")); // price
                    insertItemStmt.setDouble(6, item.getDouble("area")); // area
                    insertItemStmt.setString(7, item.getString("imageUrl")); // image_url
                    insertItemStmt.setInt(8, quantity);  // quantity
                    insertItemStmt.setInt(9, quantity);  // quantity for update (if the item already exists)

                    insertItemStmt.addBatch();  // Add the batch
                }

                // Execute the batch
                int[] rowsAffected = insertItemStmt.executeBatch();

                // Commit the transaction
                conn.commit();

                // Send the response back to the client
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Cart items saved successfully.");
                out.print(jsonResponse);
            } catch (SQLException e) {
                conn.rollback();  // Rollback if there is an error
                e.printStackTrace();
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error saving cart items.");
                out.print(jsonResponse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database connection error.");
            out.print(jsonResponse);
        }
    }
}



