package Controller;

import Dao.OrderDAO;
import Entity.Order;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.List;

public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    // Xử lý yêu cầu GET để hiển thị đơn hàng
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);

        // Chuyển đến trang JSP để hiển thị dữ liệu
        RequestDispatcher dispatcher = request.getRequestDispatcher("orders.jsp");
        dispatcher.forward(request, response);
    }

    // Xử lý yêu cầu POST để cập nhật trạng thái đơn hàng
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        boolean isUpdated = orderDAO.updateOrderStatus(orderId, newStatus);

        if (isUpdated) {
            response.sendRedirect("booking-manager.jsp");
        } else {
            response.getWriter().write("Failed to update status.");
        }
    }
}
