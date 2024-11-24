package Controller;

import Dao.CartItemDAO;
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

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        int userId = (Integer) request.getSession().getAttribute("userId");

        try {
            // Call DAO to remove the item from the cart
            cartItemDAO.removeCartItem(userId, propertyId);
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Item removed successfully");

            // After removing the item, redirect back to the cart page
            response.sendRedirect("cart.jsp"); // Or send a success message if you want to use AJAX

        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error removing item: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
        }
    }
}



