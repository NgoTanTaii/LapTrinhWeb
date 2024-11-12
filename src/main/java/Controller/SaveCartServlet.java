package Controller;

import Dao.CartItemDAO;
import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/saveCart")
public class SaveCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Parse the request body as JSON
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        JSONObject jsonRequest = new JSONObject(sb.toString());

        // Get the user and cart information from the request body
        int userId = jsonRequest.getInt("userId");
        int cartId = jsonRequest.getInt("cartId");
        JSONArray cartItemsArray = jsonRequest.getJSONArray("cartItems");

        // Add the cart items to the database (using your DAO)
        CartItemDAO cartItemDAO = new CartItemDAO();
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
                cartItemDAO.addCartItem(cartItem);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        // Send a response back to the frontend
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": true}");
        out.flush();
    }
}

