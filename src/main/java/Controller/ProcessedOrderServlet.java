package Controller;

import Dao.OrderDAO;
import Entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/processed-order")
public class ProcessedOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        List<Order> processedOrders = orderDAO.getProcessedOrders();  // Lấy danh sách đơn hàng đã được xử lý

        request.setAttribute("processedOrders", processedOrders);
        request.getRequestDispatcher("processed-order.jsp").forward(request, response);  // Chuyển dữ liệu sang JSP
    }
}
