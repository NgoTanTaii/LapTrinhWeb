package Controller;

import Dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteOrder")
public class DeleteOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        OrderDAO orderDAO = new OrderDAO();

        // Kiểm tra xem orderId có hợp lệ không
        if (orderId != null && !orderId.isEmpty()) {
            try {
                // Xóa các item trong đơn hàng
                boolean orderItemsDeleted = orderDAO.deleteOrderItemsByOrderId(orderId);

                if (orderItemsDeleted) {
                    // Xóa đơn hàng
                    boolean orderDeleted = orderDAO.deleteOrder(Integer.parseInt(orderId));

                    response.setContentType("application/json");
                    if (orderDeleted) {
                        // Trả về JSON thành công
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().write("{\"status\":\"success\",\"message\":\"Đơn hàng đã được xóa thành công\"}");
                    } else {
                        // Trả về JSON lỗi
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể xóa đơn hàng\"}");
                    }
                } else {
                    // Trả về JSON lỗi nếu xóa item thất bại
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể xóa các item trong đơn hàng\"}");
                }
            } catch (Exception e) {
                // Xử lý lỗi khi có ngoại lệ
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Có lỗi xảy ra khi xóa đơn hàng\"}");
            }
        } else {
            // Trả về lỗi nếu orderId không hợp lệ
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Mã đơn hàng không hợp lệ\"}");
        }
    }
}
