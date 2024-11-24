package Controller;

import Dao.OrderDAO;
import Entity.Order;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/booking-manager")
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            orderDAO = new OrderDAO();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể kết nối với cơ sở dữ liệu: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("access-denied.jsp");
            return;
        }

        try {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);

            RequestDispatcher dispatcher = request.getRequestDispatcher("orders.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách đơn hàng: " + e.getMessage());
            e.printStackTrace();
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("access-denied.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");

            boolean isUpdated = orderDAO.updateOrderStatus(orderId, newStatus);

            if (isUpdated) {
                response.sendRedirect("booking-manager");
            } else {
                request.setAttribute("error", "Cập nhật trạng thái thất bại!");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn hàng không hợp lệ.");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật trạng thái: " + e.getMessage());
            doGet(request, response);
        }
    }
}
