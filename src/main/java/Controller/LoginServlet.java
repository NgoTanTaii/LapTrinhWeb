package Controller;

import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check the login status of the user
        String loginStatus = checkLogin(username, password);

        HttpSession session = request.getSession();

        if ("admin".equals(loginStatus) || "active".equals(loginStatus)) {
            // Get userId based on the username and save it in the session
            int userId = getUserIdByUsername(username);
            if (userId != -1) {
                session.setAttribute("userId", userId); // Store userId in the session
                session.setAttribute("username", username);
                session.setAttribute("role", loginStatus.equals("admin") ? "admin" : "user");

                // Check for cart in session
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart != null && !cart.isEmpty()) {
                    // Transfer cart items to the database
                    saveCartToDatabase(userId, cart);
                    // Clear cart from session
                    session.removeAttribute("cart");
                }

                response.sendRedirect("welcome");
            } else {
                response.getWriter().println("Error: User ID not found.");
            }
        } else if ("inactive".equals(loginStatus)) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Your account is not yet activated. Please check your email to activate your account.</h3>");
            request.getRequestDispatcher("login.jsp").include(request, response);
        } else {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Login Failed. Invalid Username or Password.</h3>");
            request.getRequestDispatcher("login.jsp").include(request, response);
        }
    }

    // Save the cart items to the database for a specific user
    private void saveCartToDatabase(int userId, List<CartItem> cart) {
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        String insertCartItemSql = "INSERT INTO CartItems (user_id, cart_item_id, property_id, title, price, area, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(insertCartItemSql)) {

            for (CartItem item : cart) {
                statement.setInt(1, userId);
                statement.setInt(2, item.getCartItemId());
                statement.setInt(3, item.getPropertyId());
                statement.setString(4, item.getTitle());
                statement.setDouble(5, item.getPrice());
                statement.setDouble(6, item.getArea());
                statement.setString(7, item.getImageUrl());
                statement.setInt(8, item.getQuantity());
                statement.addBatch();
            }

            statement.executeBatch(); // Execute all insertions as a batch
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exception
        }
    }

    // Get userId by username
    private int getUserIdByUsername(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Existing checkLogin method
    private String checkLogin(String username, String password) {
        String status = null;
        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "123456";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String sql = "SELECT role, status FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String role = rs.getString("role");
                String accountStatus = rs.getString("status");
                if ("admin".equals(role)) {
                    status = "admin";
                } else if ("active".equals(accountStatus)) {
                    status = "active";
                } else if ("inactive".equals(accountStatus)) {
                    status = "inactive";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
