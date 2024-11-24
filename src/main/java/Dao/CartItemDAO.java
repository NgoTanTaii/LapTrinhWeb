package Dao;

import DBcontext.Database;
import Entity.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO {
    public void addCartItem(int cartId, CartItem item) throws SQLException {
        // Debugging: Print the title value here
        System.out.println("Inserting cart item with title: " + item.getTitle());

        String query = "INSERT INTO cartitems (cart_id, property_id, title, price, area, image_url, quantity, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, item.getPropertyId());
            stmt.setString(3, item.getTitle());  // Ensure title is passed here
            stmt.setDouble(4, item.getPrice());
            stmt.setDouble(5, item.getArea());
            stmt.setString(6, item.getImageUrl());
            stmt.setInt(7, item.getQuantity());
            stmt.setString(8, item.getAddress()); // Set address in the query
            stmt.executeUpdate();
        }
    }

    public List<CartItem> getCartItemsByCartId(int cartId) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT * FROM cartitems WHERE cart_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cart_id"));
                item.setPropertyId(rs.getInt("property_id"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getDouble("price"));
                item.setArea(rs.getInt("area"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(rs.getInt("quantity"));
                item.setAddress(rs.getString("address"));

                cartItems.add(item);
            }
        }
        return cartItems;
    }

    public void updateCartItemQuantity(int cartId, int propertyId, int newQuantity) throws SQLException {
        String query = "UPDATE cartitems SET quantity = ? WHERE cart_id = ? AND property_id = ?";

        // If the new quantity is greater than 1, make sure we don't update it to avoid excess quantity
        if (newQuantity > 1) {
            newQuantity = 1;
        }

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, newQuantity); // Set the new quantity (always 1 when updating)
            stmt.setInt(2, cartId);      // Specify the cart ID
            stmt.setInt(3, propertyId);  // Specify the property ID (item in the cart)

            stmt.executeUpdate(); // Execute the update
        }
    }

    // Checks if a specific property is already in the cartitems table for a given cart_id and property_id.
    public boolean checkIfItemExists(int cartId, int propertyId) throws SQLException {
        String query = "SELECT COUNT(*) FROM cartitems WHERE cart_id = ? AND property_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, propertyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if count is greater than 0, indicating item exists in the cart
            }
        }
        return false; // Return false if no such item is found in the cart
    }


    public List<CartItem> getCartItemsByUserId(int userId) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT * FROM cartitems WHERE cart_id = (SELECT cart_id FROM cart WHERE user_id = ?)";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cart_id"));
                item.setPropertyId(rs.getInt("property_id"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getDouble("price"));
                item.setArea(rs.getInt("area"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(rs.getInt("quantity"));
                item.setAddress(rs.getString("address"));
                cartItems.add(item);
            }
        }
        return cartItems;
    }

    public int getItemQuantity(int cartId, int propertyId) throws SQLException {
        String query = "SELECT quantity FROM cartitems WHERE cart_id = ? AND property_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, propertyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        }
        return 0; // Default quantity if item is not found
    }

    public boolean checkPropertyExists(int propertyId) throws SQLException {
        String query = "SELECT 1 FROM properties WHERE property_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Returns true if property exists
        }
    }

    public void removeCartItem(int userId, int propertyId) throws SQLException {
        int cartId = getCartIdByUserId(userId);
        if (cartId != -1) {
            String query = "DELETE FROM cartitems WHERE cart_id = ? AND property_id = ?";
            try (Connection con = Database.getConnection();
                 PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setInt(1, cartId);
                stmt.setInt(2, propertyId);
                stmt.executeUpdate();
            }
        }
    }

    public int getCartIdByUserId(int userId) throws SQLException {
        String query = "SELECT cart_id FROM cart WHERE user_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("cart_id");
            }
        }
        return -1; // Return -1 if cart is not found
    }


}