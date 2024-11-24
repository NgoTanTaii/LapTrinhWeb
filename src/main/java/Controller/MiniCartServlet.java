package Controller;

import Dao.CartItemDAO;
import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/getMiniCart")
public class MiniCartServlet extends HttpServlet {
    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Fetch cart items based on userId
            List<CartItem> cartItems = cartItemDAO.getCartItemsByUserId(userId);
            int itemCount = cartItems.size(); // Count of items in the cart

            // Tạo một đối tượng để chứa dữ liệu trả về
            CartResponse cartResponse = new CartResponse(true, itemCount, cartItems);



            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(cartResponse));
            out.flush();

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Error fetching cart items.\"}");
        }
    }

    // Class nội bộ để tổ chức phản hồi JSON
    private static class CartResponse {
        private boolean success;
        private int itemCount;
        private List<CartItem> cartItems;

        public CartResponse(boolean success, int itemCount, List<CartItem> cartItems) {
            this.success = success;
            this.itemCount = itemCount;
            this.cartItems = cartItems;
        }
    }
}
