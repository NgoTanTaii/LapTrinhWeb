package Controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestMain {
    public static void main(String[] args) {
        // Database connection information
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        // The user ID you want to test
        int testUserId = 6;  // Replace with a valid user ID

        try {
            // Establish database connection
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            System.out.println("Database connection established.");

            // Step 1: Retrieve the cart for the specified user ID
            String cartQuery = "SELECT cart_id FROM cart WHERE user_id = ?";
            PreparedStatement cartStmt = conn.prepareStatement(cartQuery);
            cartStmt.setInt(1, testUserId);
            ResultSet cartRs = cartStmt.executeQuery();

            int cartId;
            if (cartRs.next()) {
                cartId = cartRs.getInt("cart_id");
                System.out.println("Cart ID for user ID '" + testUserId + "': " + cartId);
            } else {
                // Create a new cart for the user if one does not exist
                String insertCartQuery = "INSERT INTO cart (user_id) VALUES (?)";
                PreparedStatement insertCartStmt = conn.prepareStatement(insertCartQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                insertCartStmt.setInt(1, testUserId);
                insertCartStmt.executeUpdate();

                ResultSet generatedKeys = insertCartStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    cartId = generatedKeys.getInt(1);
                    System.out.println("New cart created for user ID '" + testUserId + "' with Cart ID: " + cartId);
                } else {
                    throw new SQLException("Failed to create cart, no ID obtained.");
                }

                insertCartStmt.close();
            }

            // Step 2: Retrieve items in the cart with property details
            String cartItemsQuery = "SELECT ci.cart_item_id, ci.property_id, ci.quantity, p.title, p.image_url " +
                    "FROM cart_item ci " +
                    "JOIN properties p ON ci.property_id = p.property_id " +
                    "WHERE ci.cart_id = ?";
            PreparedStatement cartItemsStmt = conn.prepareStatement(cartItemsQuery);
            cartItemsStmt.setInt(1, cartId);
            ResultSet itemsRs = cartItemsStmt.executeQuery();

            System.out.println("Items in cart with ID " + cartId + ":");
            if (!itemsRs.isBeforeFirst()) { // Check if ResultSet is empty
                System.out.println("No items in the cart.");
            }

            while (itemsRs.next()) {
                int cartItemId = itemsRs.getInt("cart_item_id");
                int propertyId = itemsRs.getInt("property_id");
                int quantity = itemsRs.getInt("quantity");
                String propertyName = itemsRs.getString("title");
                String propertyImageUrl = itemsRs.getString("image_url");

                System.out.println("Cart Item ID: " + cartItemId +
                        ", Property ID: " + propertyId +
                        ", Quantity: " + quantity +
                        ", Property Name: " + propertyName +
                        ", Image URL: " + propertyImageUrl);
            }

            // Close resources
            cartRs.close();
            cartStmt.close();
            itemsRs.close();
            cartItemsStmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
