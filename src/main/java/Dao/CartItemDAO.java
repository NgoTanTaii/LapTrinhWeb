package Dao;

import DBcontext.Database;

import java.sql.*;

public class CartItemDAO {
    public void addCartItem(int cartId, int propertyId, int quantity) throws SQLException {
        String query = "INSERT INTO cart_item (cart_id, property_id, quantity) VALUES (?, ?, ?)";

        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, propertyId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();
        }
    }

    public void removeCartItem(int cartItemId) throws SQLException {
        String query = "DELETE FROM cart_item WHERE cart_item_id = ?";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cartItemId);
            stmt.executeUpdate();
        }
    }
}



