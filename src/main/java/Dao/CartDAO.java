package Dao;

import DBcontext.Database;
import java.sql.*;

public class CartDAO {

    // Lấy hoặc tạo giỏ hàng mới cho user nếu chưa tồn tại
    public int createCartIfNotExists(int userId) throws SQLException {
        int cartId = getCartIdByUserId(userId);

        if (cartId == -1) { // Giỏ hàng chưa tồn tại
            String insertCartQuery = "INSERT INTO cart (user_id) VALUES (?)";
            try (Connection con = Database.getConnection();
                 PreparedStatement stmt = con.prepareStatement(insertCartQuery, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    cartId = generatedKeys.getInt(1);
                }
            }
        }
        return cartId;
    }

    // Lấy cart_id của user
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
        return -1; // Không tìm thấy giỏ hàng
    }
}
