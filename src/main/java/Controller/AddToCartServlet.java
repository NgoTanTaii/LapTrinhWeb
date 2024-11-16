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
import com.google.gson.JsonObject;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
        cartItemDAO = new CartItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            // User not logged in, redirect to login page with a message
            session.setAttribute("message", "Vui lòng đăng nhập để thêm vào giỏ hàng.");
            response.sendRedirect("login.jsp");
            return;
        }

        String propertyIdStr = request.getParameter("propertyId");
        String title = request.getParameter("title");
        String priceStr = request.getParameter("price");
        String areaStr = request.getParameter("area");
        String imageUrl = request.getParameter("imageUrl");
        String address = request.getParameter("address");

        try {
            int cartId = cartDAO.createCartIfNotExists(userId);
            int propertyId = Integer.parseInt(propertyIdStr);
            double price = Double.parseDouble(priceStr);
            double area = Double.parseDouble(areaStr);

            // Check if property exists
            if (!cartItemDAO.checkPropertyExists(propertyId)) {
                session.setAttribute("message", "Sản phẩm không tồn tại.");
                response.sendRedirect(getRefererPage(request));  // Redirect to the referring page
                return;
            }

            // Check if the item already exists in the cart
            boolean itemExists = cartItemDAO.checkIfItemExists(cartId, propertyId);

            if (itemExists) {
                int currentQuantity = cartItemDAO.getItemQuantity(cartId, propertyId);
                cartItemDAO.updateCartItemQuantity(cartId, propertyId, currentQuantity + 1);
                session.setAttribute("message", "Sản phẩm đã có trong giỏ hàng.");
            } else {
                // Add new item to the cart
                CartItem cartItem = new CartItem(propertyId, title, price, area, imageUrl, cartId, 1, address);
                cartItemDAO.addCartItem(cartId, cartItem);
                session.setAttribute("message", "Sản phẩm đã được thêm vào giỏ hàng!");
            }

            // Redirect to the referring page (same page as before)
            response.sendRedirect(getRefererPage(request));

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("message", "Lỗi khi thêm sản phẩm vào giỏ hàng: " + e.getMessage());
            response.sendRedirect(getRefererPage(request));  // Redirect to the referring page
        }
    }

    // Method to get the referring page (URL of the page where the request came from)
    private String getRefererPage(HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        return referer != null ? referer : "welcome"; // Default to welcome page if Referer header is not found
    }
}
