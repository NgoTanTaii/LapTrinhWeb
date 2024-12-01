package Controller;

import DBcontext.Database;
import Dao.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/confirm")
public class ConfirmServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get token from URL
        String token = request.getParameter("token");
        System.out.println("Received token: " + token); // Debugging

        if (token == null || token.isEmpty()) {
            response.getWriter().println("Token không hợp lệ.");
            return;
        }

        try (Connection conn = Database.getConnection()) {  // Use Database.getConnection() here
            // Check if the token is valid
            String checkQuery = "SELECT * FROM users WHERE token = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, token);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Token is valid, update account status to 'active'
                String updateQuery = "UPDATE users SET status = 'active', token = NULL WHERE token = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, token);
                int rowsUpdated = updateStmt.executeUpdate();

                System.out.println("Rows updated: " + rowsUpdated); // Debugging

                if (rowsUpdated > 0) {
                    // Retrieve user ID from the result set
                    int userId = rs.getInt("id");

                    // Create cart for the user after activation
                    CartDAO cartDAO = new CartDAO();
                    cartDAO.createCartIfNotExists(userId);

                    // Display confirmation message after successful activation and cart creation
                    response.setContentType("text/html; charset=UTF-8");
                    response.getWriter().println("<html><body>");
                    response.getWriter().println("<h2>Tài khoản của bạn đã được kích hoạt thành công!</h2>");
                    response.getWriter().println("<p>Giỏ hàng của bạn đã được tạo. Vui lòng <a href='login.jsp'>đăng nhập</a> để tiếp tục sử dụng tài khoản.</p>");
                    response.getWriter().println("</body></html>");
                } else {
                    // If no rows were updated
                    response.getWriter().println("Có lỗi xảy ra trong quá trình kích hoạt tài khoản. Vui lòng thử lại.");
                }
            } else {
                // Token is invalid or does not exist in the database
                response.getWriter().println("Token không hợp lệ.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Đã xảy ra lỗi trong quá trình kích hoạt tài khoản.");
        }
    }
}
