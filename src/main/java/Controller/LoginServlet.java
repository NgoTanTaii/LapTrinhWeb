package Controller;

import DBcontext.Database;
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
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            initializeSession(session, userId, username, loginStatus);

            try {
                CartItemDAO cartItemDAO = new CartItemDAO();
                int cartId = new CartDAO().createCartIfNotExists(userId); // Ensure cart exists and get cartId
                synchronizeSessionCartWithDatabase(session, userId, cartId); // Sync session cart with DB
            } catch (SQLException e) {
                e.printStackTrace();
            }

            response.sendRedirect("welcome");
        } else {
            response.getWriter().println("Error: User ID not found.");
        }
    }

    private void initializeSession(HttpSession session, int userId, String username, String loginStatus) {
        session.setAttribute("userId", userId);
        session.setAttribute("username", username);
        session.setAttribute("role", "admin".equals(loginStatus) ? "admin" : "user");
    }

    // Synchronize session cart items with the database cart
    private void synchronizeSessionCartWithDatabase(HttpSession session, int userId, int cartId) {
        List<CartItem> sessionCartItems = (List<CartItem>) session.getAttribute("cart");
        if (sessionCartItems != null && !sessionCartItems.isEmpty()) {
            try {
                CartItemDAO cartItemDAO = new CartItemDAO();
                List<CartItem> existingCartItems = cartItemDAO.getCartItemsByCartId(cartId);

                for (CartItem sessionItem : sessionCartItems) {
                    boolean itemExistsInCart = existingCartItems.stream()
                            .anyMatch(dbItem -> dbItem.getPropertyId() == sessionItem.getPropertyId());

                    if (itemExistsInCart) {
                        cartItemDAO.updateCartItemQuantity(cartId, sessionItem.getPropertyId(), sessionItem.getQuantity());
                    } else {
                        sessionItem.setCartId(cartId); // Set cartId for new item
                        cartItemDAO.addCartItem(cartId, sessionItem);
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
        try (PrintWriter out = response.getWriter()) {
            if ("inactive".equals(loginStatus)) {
                out.println("<h3>Your account is not yet activated. Please check your email to activate your account.</h3>");
            } else {
                out.println("<h3>Login Failed. Invalid Username or Password.</h3>");
            }
        }
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
        String sql = "SELECT role, status, password FROM users WHERE username = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("password"); // Mật khẩu đã hash trong DB
                String role = rs.getString("role");
                String accountStatus = rs.getString("status");

                // Mã hóa mật khẩu người dùng nhập vào bằng MD5
                String hashedPassword = hashPasswordWithMD5(password);

                // So sánh mật khẩu đã mã hóa
                if (hashedPassword.equals(dbPassword)) {
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

    // Hàm mã hóa mật khẩu bằng MD5
    private String hashPasswordWithMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b)); // Convert each byte to hexadecimal
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
}
