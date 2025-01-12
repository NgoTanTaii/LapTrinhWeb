package Controller;

import Dao.CartItemDAO;
import Dao.DepositOrderDAO;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.stream.Collectors;

@WebServlet("/removeItemFromCart")
public class RemoveItemServlet extends HttpServlet {
    private CartItemDAO cartItemDAO;
    private DepositOrderDAO depositOrderDAO; // Assuming this DAO exists to interact with deposit_orders

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
        depositOrderDAO = new DepositOrderDAO(); // Initialize the deposit order DAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        int userId = (Integer) request.getSession().getAttribute("userId");

        try {
            // Check if there is a deposit order for this propertyId and userId
            boolean isDeposited = depositOrderDAO.isDeposited(userId, propertyId);

            if (isDeposited) {
                // If already deposited, send a message
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Item has already been deposited.");
                response.getWriter().write(jsonResponse.toString());
            } else {
                // Call DAO to remove the item from the cart
                cartItemDAO.removeCartItem(userId, propertyId);
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Item removed successfully");

                // After removing the item, redirect back to the cart page
                response.sendRedirect("cart.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error removing item: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
        }
    }
}



