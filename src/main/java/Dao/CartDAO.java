package Dao;

import DBcontext.Database;
import Entity.Cart;
import Entity.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    // Lấy giỏ hàng của người dùng dựa trên username
    public Cart getCartByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM cart WHERE user_id = (SELECT id FROM users WHERE username = ?)";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId); // Truyền username vào câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                return cart;
            }
        }
        return null;
    }

    // Lấy tất cả các mục trong giỏ hàng của người dùng dựa trên username
    public List<CartItem> getCartItemsByUsername(String username) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT ci.cart_item_id, ci.property_id, ci.quantity, p.title, p.price, p.area, p.image_url " +
                "FROM cart_item ci JOIN properties p ON ci.property_id = p.property_id WHERE ci.cart_id = " +
                "(SELECT cart_id FROM cart WHERE user_id = (SELECT id FROM users WHERE username = ?))";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username); // Truyền username vào câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setPropertyId(rs.getInt("property_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getDouble("price"));
                item.setArea(rs.getDouble("area"));
                item.setImageUrl(rs.getString("image_url"));
                cartItems.add(item);
            }
        }
        return cartItems;
    }

    // Tạo giỏ hàng mới cho người dùng nếu chưa có
    public Cart createCart(int userId) throws SQLException {
        String query = "INSERT INTO cart (user_id) VALUES (?)";
        try (Connection con = Database.getConnection();
             PreparedStatement stmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId); // Truyền username vào câu lệnh SQL
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt(1)); // Lấy cart_id mới tạo
                return cart;
            }
        }
        return null;
    }
}
