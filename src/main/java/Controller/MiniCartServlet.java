package Controller;

import Dao.CartDAO;
import Dao.CartItemDAO;
import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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

            // Set the cart items and item count as request attributes
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("itemCount", itemCount);

            // Forward the request to welcome.jsp, which will display the mini cart
            request.getRequestDispatcher("/welcome").forward(request, response); // Forward to the page displaying the floating cart

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching cart items.");
        }
    }
}
