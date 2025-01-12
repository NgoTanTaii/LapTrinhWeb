package Controller;

import Dao.DepositOrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateDepositStatus")
public class UpdateDepositServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String depositIdStr = request.getParameter("depositId");
        String status = request.getParameter("status");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (depositIdStr != null && !depositIdStr.isEmpty() && status != null && !status.isEmpty()) {
            try {
                int depositId = Integer.parseInt(depositIdStr);
                DepositOrderDAO dao = new DepositOrderDAO();

                // Cập nhật trạng thái theo hành động của người dùng
                if ("confirmed".equalsIgnoreCase(status)) {
                    dao.updateDepositStatus(depositId, "process"); // Cập nhật trạng thái 'process' (xác nhận)
                } else if ("rejected".equalsIgnoreCase(status)) {
                    dao.updateDepositStatus(depositId, "cancel"); // Cập nhật trạng thái 'cancel' (hủy)
                }

                response.getWriter().write("{\"success\": true}");
            } catch (SQLException e) {
                response.getWriter().write("{\"success\": false, \"message\": \"Error updating deposit status: " + e.getMessage() + "\"}");
            }
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Deposit ID or status is missing.\"}");
        }
    }
}


