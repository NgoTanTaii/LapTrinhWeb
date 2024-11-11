package Controller;


import Entity.CartItem;
import Entity.CartRequest;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/saveCart")
public class SaveCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Đọc dữ liệu từ body của request
        String jsonRequest = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);

        // Sử dụng Gson để parse chuỗi JSON thành đối tượng CartRequest
        Gson gson = new Gson();
        CartRequest cartRequest = gson.fromJson(jsonRequest, CartRequest.class);

        int userId = cartRequest.getUserId();
        List<CartItem> cartItems = cartRequest.getCartItems();

        // Lưu giỏ hàng vào cơ sở dữ liệu
        try {
            // Kiểm tra xem người dùng đã có giỏ hàng chưa
            int cartId = getCartIdByUser(userId);

            if (cartId == -1) {
                cartId = createCart(userId);
            }

            // Thêm từng item vào bảng cart_item
            for (CartItem item : cartItems) {
                addCartItem(cartId, item);
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false}");
        }
    }

    // Kiểm tra xem người dùng có giỏ hàng chưa
    private int getCartIdByUser(int userId) throws SQLException {
        String query = "SELECT cart_id FROM cart WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }
            return -1;
        }
    }

    // Tạo một giỏ hàng mới cho người dùng nếu chưa có
    private int createCart(int userId) throws SQLException {
        String query = "INSERT INTO cart (user_id) VALUES (?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        }
    }

    // Thêm sản phẩm vào bảng cart_item
    private void addCartItem(int cartId, CartItem item) throws SQLException {
        String query = "INSERT INTO cart_item (cart_id, property_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, item.getPropertyId());
            stmt.setInt(3, item.getQuantity());
            stmt.executeUpdate();
        }
    }

    // Kết nối cơ sở dữ liệu
    private Connection getConnection() throws SQLException {
        String dbURL = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";
        return DriverManager.getConnection(dbURL, dbUser, dbPassword);
    }
}
