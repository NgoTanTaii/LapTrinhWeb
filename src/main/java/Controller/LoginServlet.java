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

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        String loginStatus = checkLogin(username, password);

        if ("admin".equals(loginStatus) || "active".equals(loginStatus)) {
            handleSuccessfulLogin(request, response, session, username, loginStatus);
        } else {
            handleFailedLogin(response, loginStatus);
        }
    }

    private void handleSuccessfulLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session,
                                       String username, String loginStatus) throws IOException {
        int userId = getUserIdByUsername(username);
        if (userId != -1) {
            session.setAttribute("userId", userId);
            session.setAttribute("username", username);
            session.setAttribute("role", "admin".equals(loginStatus) ? "admin" : "user");

            try {
                CartItemDAO cartItemDAO = new CartItemDAO();
                int cartId = cartItemDAO.createCartIfNotExists(userId); // Ensure cart exists and get cartId
                saveSessionCartToDatabase(session, userId, cartId); // Save session cart items to DB
            } catch (SQLException e) {
                e.printStackTrace();
            }

            response.sendRedirect("welcome");
        } else {
            response.getWriter().println("Error: User ID not found.");
        }
    }

    // Method to save session cart items to database, linking them to user's cart
    private void saveSessionCartToDatabase(HttpSession session, int userId, int cartId) {
        List<CartItem> sessionCartItems = (List<CartItem>) session.getAttribute("cart");
        if (sessionCartItems != null && !sessionCartItems.isEmpty()) {
            try {
                CartItemDAO cartItemDAO = new CartItemDAO();
                List<CartItem> existingCartItems = cartItemDAO.getCartItemsByCartId(userId);

                // Loop through session cart items and save or update in DB
                for (CartItem sessionItem : sessionCartItems) {
                    boolean existsInCart = existingCartItems.stream()
                            .anyMatch(dbItem -> dbItem.getPropertyId() == sessionItem.getPropertyId());

                    if (existsInCart) {
                        // If item exists in the user's cart, update quantity
                        cartItemDAO.updateCartItemQuantity(userId, sessionItem.getPropertyId(), sessionItem.getQuantity());
                    } else {
                        // Otherwise, add the item as a new entry in the cart
                        cartItemDAO.addCartItem(userId, sessionItem);
                    }
                }
                session.removeAttribute("cart"); // Clear session cart after saving to DB
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void handleFailedLogin(HttpServletResponse response, String loginStatus) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if ("inactive".equals(loginStatus)) {
            out.println("<h3>Your account is not yet activated. Please check your email to activate your account.</h3>");
        } else {
            out.println("<h3>Login Failed. Invalid Username or Password.</h3>");
        }
        out.flush();
    }

    private int getUserIdByUsername(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        try (Connection conn = Database.getConnection();
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

    private String checkLogin(String username, String password) {
        String status = null;
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT role, status FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }
}
