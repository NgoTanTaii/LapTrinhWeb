package Dao;

import Entity.CartItem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private Connection connection;

    public CartDAO(Connection connection) {
        this.connection = connection;
    }

    // Add item to cart
    public void addItemToCart(int userId, int propertyId, String title, BigDecimal price, BigDecimal area, String imageUrl, String address) throws Exception {
        String sql = "INSERT INTO user_cart (id, property_id, title, price, area, image_url, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, propertyId);
            ps.setString(3, title);
            ps.setBigDecimal(4, price);
            ps.setBigDecimal(5, area);
            ps.setString(6, imageUrl);
            ps.setString(7, address);
            ps.executeUpdate();
        }
    }

    // Retrieve cart items
    public List<CartItem> getCartItems(int userId) throws Exception {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM user_cart WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem(
                            rs.getInt("property_id"),
                            rs.getString("title"),
                            rs.getBigDecimal("price"),
                            rs.getBigDecimal("area"),
                            rs.getString("image_url"),
                            rs.getString("address")
                    );
                    cartItems.add(item);
                }
            }
        }
        return cartItems;
    }

    // Optional: Clear cart items for a user (e.g., on logout)
    public void clearCart(int userId) throws Exception {
        String sql = "DELETE FROM user_cart WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }
}
