package Controller;

import Dao.CartItemDAO;
import Dao.DepositOrderDAO;
import com.google.gson.JsonObject;
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
    private DepositOrderDAO depositOrderDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
        depositOrderDAO = new DepositOrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();
        String propertyIdStr = request.getParameter("propertyId");

        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Thiếu thông tin bất động sản.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        int propertyId = Integer.parseInt(propertyIdStr);
        int userId = (Integer) request.getSession().getAttribute("userId");

        try {
            // Kiểm tra xem người dùng đã đặt cọc cho sản phẩm này chưa
            boolean isDeposited = depositOrderDAO.isDeposited(userId, propertyId);

            if (isDeposited) {
                // Nếu đã đặt cọc, gửi thông báo lỗi
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Sản phẩm đã được đặt cọc và không thể xóa.");
            } else {
                // Nếu chưa đặt cọc, xóa sản phẩm khỏi giỏ hàng
                cartItemDAO.removeCartItem(userId, propertyId);
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Sản phẩm đã được xóa khỏi giỏ hàng.");
            }

            // Trả về JSON phản hồi
            response.getWriter().write(jsonResponse.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi khi xóa sản phẩm: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
        }
    }
}

