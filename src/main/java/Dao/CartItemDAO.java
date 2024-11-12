package Dao;

import DBcontext.Database;
import Entity.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO {

    // Add a new item to the CartItems table
    public void addCartItem(int userId, CartItem item) throws SQLException {
        String query = "INSERT INTO CartItems (user_id, property_id, title, price, area, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, item.getPropertyId());
            stmt.setString(3, item.getTitle());
            stmt.setDouble(4, item.getPrice());
            stmt.setDouble(5, item.getArea());
            stmt.setString(6, item.getImageUrl());
            stmt.setInt(7, item.getQuantity());
            stmt.executeUpdate();
        }
    }

    public int createCartIfNotExists(int userId) throws SQLException {
        int cartId = getCartIdByUserId(userId);

        // If cart doesn't exist, create a new one
        if (cartId == -1) {
            String insertCartQuery = "INSERT INTO Cart (user_id) VALUES (?)";
            try (Connection con = Database.getConnection();
                 PreparedStatement stmt = con.prepareStatement(insertCartQuery, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();

                // Retrieve the generated cart_id
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    cartId = generatedKeys.getInt(1); // Retrieve the generated cart_id
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

    // Update quantity of an existing cart item
    public void updateCartItemQuantity(int userId, int propertyId, int newQuantity) throws SQLException {
        String query = "UPDATE CartItems SET quantity = ? WHERE user_id = ? AND property_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, userId);
            stmt.setInt(3, propertyId);
            stmt.executeUpdate();
        }
    }

    // Retrieve all cart items for a specific user
    public List<CartItem> getCartItemsByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM CartItems WHERE user_id = ?";
        List<CartItem> cartItems = new ArrayList<>();

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("id"));
                item.setPropertyId(rs.getInt("property_id"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getDouble("price"));
                item.setArea(rs.getDouble("area"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(rs.getInt("quantity"));
                cartItems.add(item);
            }
        }
        return cartItems;
    }

    // Remove a cart item by user_id and property_id
    public void removeCartItem(int userId, int propertyId) throws SQLException {
        String query = "DELETE FROM CartItems WHERE user_id = ? AND property_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, propertyId);
            stmt.executeUpdate();
        }
    }

    // Clear all items for a specific user (e.g., upon checkout)
    public void clearCartForUser(int userId) throws SQLException {
        String query = "DELETE FROM CartItems WHERE user_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }
}
