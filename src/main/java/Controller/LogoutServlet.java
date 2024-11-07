// LogoutServlet.java
package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Lấy userId từ session (giả sử userId được lưu trong session khi đăng nhập)
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId != null) {
                // Xóa giỏ hàng từ CSDL dựa trên userId
                try {
                    Connection connection = Database.getConnection(); // Giả sử bạn có phương thức này để lấy kết nối CSDL
                    String deleteCartQuery = "DELETE FROM cart_items WHERE user_id = ?";
                    PreparedStatement statement = connection.prepareStatement(deleteCartQuery);
                    statement.setInt(1, userId);
                    statement.executeUpdate();
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.getWriter().write("Có lỗi xảy ra khi xóa giỏ hàng.");
                    return;
                }
            }

            // Xóa session
            session.invalidate();
        }

        // Chuyển hướng về trang "homes"
        response.sendRedirect("homes");
    }
}
