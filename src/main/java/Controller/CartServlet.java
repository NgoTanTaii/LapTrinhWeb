package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Arrays;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/saveCart")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }
        System.out.println("Received JSON data: " + sb.toString());

        JSONObject jsonRequest = new JSONObject(sb.toString());
        int userId = jsonRequest.getInt("userId");
        JSONArray cartItems = jsonRequest.getJSONArray("cartItems");

        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String cartQuery = "SELECT cart_id FROM cart WHERE user_id = ?";
            PreparedStatement cartStmt = conn.prepareStatement(cartQuery);
            cartStmt.setInt(1, userId);
            ResultSet rs = cartStmt.executeQuery();

            int cartId;
            if (rs.next()) {
                cartId = rs.getInt("cart_id");
            } else {
                String insertCartQuery = "INSERT INTO cart (user_id) VALUES (?)";
                PreparedStatement insertCartStmt = conn.prepareStatement(insertCartQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                insertCartStmt.setInt(1, userId);
                insertCartStmt.executeUpdate();

                ResultSet generatedKeys = insertCartStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    cartId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Failed to create cart, no ID obtained.");
                }
                insertCartStmt.close();
            }

            // Delete existing cart items for this cart_id
            String deleteItemsQuery = "DELETE FROM cart_item WHERE cart_id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteItemsQuery);
            deleteStmt.setInt(1, cartId);
            deleteStmt.executeUpdate();

            // Insert new cart items
            String insertItemQuery = "INSERT INTO cart_item (cart_id, property_id, quantity) VALUES (?, ?, 1)";
            PreparedStatement insertItemStmt = conn.prepareStatement(insertItemQuery);

            for (int i = 0; i < cartItems.length(); i++) {
                JSONObject item = cartItems.getJSONObject(i);
                int propertyId = item.getInt("id");

                insertItemStmt.setInt(1, cartId);
                insertItemStmt.setInt(2, propertyId);
                insertItemStmt.addBatch();
            }

            int[] rowsAffected = insertItemStmt.executeBatch();
            System.out.println("Rows inserted in cart_item: " + Arrays.toString(rowsAffected));

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            out.print(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            out.print(jsonResponse);
        }
    }
}

