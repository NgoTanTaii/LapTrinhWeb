package Controller;

import DBcontext.Database;
import Dao.CartItemDAO;
import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Parse JSON request
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        JSONObject jsonRequest = new JSONObject(sb.toString());
        int userId = jsonRequest.getInt("userId");
        int cartId = jsonRequest.getInt("cartId");
        JSONArray cartItemsArray = jsonRequest.getJSONArray("cartItems");

        // Create CartItemDAO instance
        CartItemDAO cartItemDAO = new CartItemDAO();

        // Loop through the cart items array and save each item
        for (int i = 0; i < cartItemsArray.length(); i++) {
            JSONObject item = cartItemsArray.getJSONObject(i);
            CartItem cartItem = new CartItem();
            cartItem.setCartId(cartId);
            cartItem.setUserId(userId);
            cartItem.setPropertyId(item.getInt("id"));
            cartItem.setTitle(item.getString("title"));
            cartItem.setPrice(item.getDouble("price"));
            cartItem.setArea(item.getDouble("area"));
            cartItem.setImageUrl(item.getString("imageUrl"));
            cartItem.setQuantity(item.getInt("quantity"));

            try {
                // Add cart item to the database
                cartItemDAO.addCartItem(cartItem);
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
        }

        // Return success response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": true}");
        out.flush();
    }
}


