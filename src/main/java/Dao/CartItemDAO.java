package Dao;

import DBcontext.Database;
import Entity.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO {

    public void addCartItem(int cartId, CartItem item) throws SQLException {
        String query = "INSERT INTO CartItems (cart_id, user_id, property_id, title, price, area, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, item.getUserId()); // Ensure user_id is correct and matches cart
            stmt.setInt(3, item.getPropertyId());
            stmt.setString(4, item.getTitle());
            stmt.setDouble(5, item.getPrice());
            stmt.setDouble(6, item.getArea());
            stmt.setString(7, item.getImageUrl());
            stmt.executeUpdate();
        }
    }

    public void addCartItem(CartItem cartItem) throws SQLException {
        // SQL query to insert the cart item into the cartitems table
        String sql = "INSERT INTO cartitems (cart_id, user_id, property_id, title, price, area, image_url, quantity) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        // Get the database connection
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the values for the query parameters
            stmt.setInt(1, cartItem.getCartId());
            stmt.setInt(2, cartItem.getUserId());
            stmt.setInt(3, cartItem.getPropertyId());
            stmt.setString(4, cartItem.getTitle());
            stmt.setDouble(5, cartItem.getPrice());
            stmt.setDouble(6, cartItem.getArea());
            stmt.setString(7, cartItem.getImageUrl());
            stmt.setInt(8, cartItem.getQuantity());

            // Execute the insert query
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any SQL exceptions
            throw new SQLException("Error while inserting cart item", e);
        }
    }

    // Ensure a cart exists for a given user and return cart_id
    public int createCartIfNotExists(int userId) throws SQLException {
        int cartId = getCartIdByUserId(userId);

        if (cartId == -1) {
            String insertCartQuery = "INSERT INTO Cart (user_id) VALUES (?)";
            try (Connection con = Database.getConnection();
                 PreparedStatement stmt = con.prepareStatement(insertCartQuery, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();

                // Retrieve the generated cart_id
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    cartId = generatedKeys.getInt(1);
                }
            }
        }
        return cartId;
    }

    public int getCartIdByUserId(int userId) throws SQLException {
        String query = "SELECT cart_id FROM Cart WHERE user_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }
        }
        return -1; // Return -1 if cart not found
    }

    // Retrieve all cart items for a specific cart
    public List<CartItem> getCartItemsByCartId(int cartId) throws SQLException {
        String query = "SELECT * FROM CartItems WHERE cart_id = ?";
        List<CartItem> cartItems = new ArrayList<>();

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();

                item.setCartId(cartId);
                item.setPropertyId(rs.getInt("property_id"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getDouble("price"));
                item.setArea(rs.getDouble("area"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(1);
                cartItems.add(item);
            }
        }
        return cartItems;
    }

    // Remove a cart item by cart_id and property_id
    public void removeCartItem(int cartId, int propertyId) throws SQLException {
        String query = "DELETE FROM CartItems WHERE cart_id = ? AND property_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, propertyId);
            stmt.executeUpdate();
        }
    }

    // Clear all items for a specific cart (e.g., upon checkout)
    public void clearCartForUser(int cartId) throws SQLException {
        String query = "DELETE FROM CartItems WHERE cart_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        }
    }

    public void updateCartItemQuantity(int cartId, int propertyId, int newQuantity) throws SQLException {
        String query = "UPDATE cartitems SET quantity = ? WHERE cart_id = ? AND property_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, newQuantity); // Set the new quantity
            stmt.setInt(2, cartId);      // Specify the cart ID
            stmt.setInt(3, propertyId);  // Specify the property ID (item in the cart)

            stmt.executeUpdate(); // Execute the update
        }
    }

    // Method to check if an item exists in the cart
    public boolean checkIfItemExists(Integer cartId, int propertyId) throws SQLException {
        String query = "SELECT COUNT(*) FROM cartitems WHERE cart_id = ? AND property_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);      // Set the cart ID
            stmt.setInt(2, propertyId);  // Set the property ID (the item)

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if count is greater than 0, indicating item exists
            }
        }
        return false; // Return false if no such item is found
    }
}

