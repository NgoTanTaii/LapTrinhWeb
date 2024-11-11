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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId != null) {
                // Xóa giỏ hàng từ cơ sở dữ liệu dựa trên userId
                try {
                    Connection connection = Database.getConnection(); // Lấy kết nối cơ sở dữ liệu
                    String deleteCartQuery = "DELETE FROM cart_item WHERE cart_id IN (SELECT cart_id FROM cart WHERE user_id = ?)";
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

            // Hủy session
            session.invalidate();
        }

        // Chuyển hướng về trang "homes" sau khi đăng xuất
        response.sendRedirect("homes"); // Trang đăng nhập hoặc trang bạn muốn chuyển hướng tới
    }
}
