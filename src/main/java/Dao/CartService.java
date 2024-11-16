package Dao;

import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

public class CartService {

    // Method to save cart to the database
    public boolean saveCartToDatabase(int userId, int cartId, JSONArray cartItems) {
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            // Start a transaction
            conn.setAutoCommit(false);

            // Prepare SQL to insert items into the cartitems table
            String insertItemQuery = "INSERT INTO cartitems (cart_id, user_id, property_id, title, price, area, image_url, quantity) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE quantity = quantity + ?";

            try (PreparedStatement insertItemStmt = conn.prepareStatement(insertItemQuery)) {
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
                    insertItemStmt.setInt(9, quantity);  // quantity for update

                    insertItemStmt.addBatch();  // Add the batch
                }

                // Execute the batch
                int[] rowsAffected = insertItemStmt.executeBatch();

                // Commit the transaction
                conn.commit();

                return true;
            } catch (SQLException e) {
                conn.rollback();  // Rollback if there is an error
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
