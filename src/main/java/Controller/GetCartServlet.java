package Controller;


import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getCart")
public class GetCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp"); // Nếu người dùng chưa đăng nhập, chuyển đến trang đăng nhập
            return;
        }

        // Lấy giỏ hàng của người dùng
        List<CartItem> cartItems = getCartItemsByUserId(userId);

        // Chuyển danh sách cartItems vào request để hiển thị
        request.setAttribute("cartItems", cartItems);

        // Chuyển tiếp đến trang giỏ hàng (cart.jsp)
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    // Lấy các sản phẩm trong giỏ hàng của người dùng từ cơ sở dữ liệu
    private List<CartItem> getCartItemsByUserId(int userId) throws ServletException {
        List<CartItem> cartItems = new ArrayList<>();
        String url = "jdbc:mysql://localhost:3306/webbds";  // Thay đổi URL theo cơ sở dữ liệu của bạn
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            // Truy vấn lấy cart_id từ bảng cart theo userId
            String queryCartId = "SELECT cart_id FROM cart WHERE id = ?";
            PreparedStatement stmtCart = conn.prepareStatement(queryCartId);
            stmtCart.setInt(1, userId);
            ResultSet rsCart = stmtCart.executeQuery();

            if (rsCart.next()) {
                int cartId = rsCart.getInt("cart_id");

                // Truy vấn lấy các sản phẩm trong giỏ hàng (cart_item) dựa vào cart_id
                String queryCartItems = "SELECT ci.cart_item_id, ci.property_id, ci.quantity, " +
                        "c.title, c.price, c.area, c.image_url, c.address " +
                        "FROM cart_item ci " +
                        "JOIN cart c ON ci.cart_id = c.cart_id " +
                        "WHERE ci.cart_id = ?";
                PreparedStatement stmtItems = conn.prepareStatement(queryCartItems);
                stmtItems.setInt(1, cartId);
                ResultSet rsItems = stmtItems.executeQuery();

                while (rsItems.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rsItems.getInt("cart_item_id"));
                    item.setPropertyId(rsItems.getInt("property_id"));
                    item.setQuantity(rsItems.getInt("quantity"));
                    item.setTitle(rsItems.getString("title"));
                    item.setPrice(rsItems.getDouble("price"));
                    item.setArea(rsItems.getDouble("area"));
                    item.setImageUrl(rsItems.getString("image_url"));
                    item.setAddress(rsItems.getString("address"));

                    cartItems.add(item);
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Error retrieving cart items", e);
        }

        return cartItems;
    }
}
