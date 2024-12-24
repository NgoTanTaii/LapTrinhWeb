package Controller;

import Dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        // Xử lý xác nhận đơn hàng (cập nhật trạng thái đơn hàng trong cơ sở dữ liệu)
        OrderDAO orderDAO = new OrderDAO();
        boolean isUpdated = orderDAO.confirmOrder(Integer.parseInt(orderId));

        if (isUpdated) {
            // Nếu thành công, chuyển hướng lại trang quản lý đơn hàng
            response.sendRedirect("orders");
        } else {
            // Nếu thất bại, chuyển hướng đến trang lỗi
            response.sendRedirect("error.jsp");
        }
    }
}
