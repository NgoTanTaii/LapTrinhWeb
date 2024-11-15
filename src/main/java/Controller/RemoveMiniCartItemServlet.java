package Controller;

import Dao.CartItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/removeMiniCartItem")
public class RemoveMiniCartItemServlet extends HttpServlet {
    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        try {
            // Lấy propertyId từ request
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            int userId = (Integer) request.getSession().getAttribute("userId"); // Lấy userId từ session

            // Gọi DAO để xóa sản phẩm khỏi giỏ hàng nhỏ
            cartItemDAO.removeCartItem(userId, propertyId);

            // Chuyển hướng trở lại trang giỏ hàng nhỏ sau khi xóa
            response.sendRedirect("welcome"); // Thay đổi thành trang mini cart của bạn

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi xóa sản phẩm khỏi giỏ hàng nhỏ.");
        }
    }
}
