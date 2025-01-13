package cart;

import DBcontext.Database;
import Entity.DepositOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/submitDeposit")
public class SubmitDepositServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        int userId = Integer.parseInt(request.getParameter("userId"));
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        BigDecimal depositAmount = new BigDecimal(request.getParameter("depositAmount").replaceAll("\\.", ""));
        String comments = request.getParameter("comments");

        // Kiểm tra xem sản phẩm đã được đặt cọc hay chưa
        if (isPropertyDeposited(userId, propertyId)) {
            response.sendRedirect("propertyAlreadyDeposited.jsp");
            return;
        }

        // Lưu thông tin vào cơ sở dữ liệu
        try (Connection connection = Database.getConnection()) {
            // Bắt đầu một giao dịch để đảm bảo tính toàn vẹn
            connection.setAutoCommit(false);

            try {
                // 1. Lưu thông tin đơn đặt cọc vào bảng deposit_orders
                String insertDepositSQL = "INSERT INTO deposit_orders (user_id, property_id, deposit_amount, comments) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(insertDepositSQL)) {
                    stmt.setInt(1, userId);
                    stmt.setInt(2, propertyId);
                    stmt.setBigDecimal(3, depositAmount);
                    stmt.setString(4, comments);
                    stmt.executeUpdate();
                }

                // 2. Cập nhật trạng thái "available" của sản phẩm (property_id) trong bảng properties
                String updatePropertySQL = "UPDATE properties SET available = 0 WHERE property_id = ?";
                try (PreparedStatement stmt = connection.prepareStatement(updatePropertySQL)) {
                    stmt.setInt(1, propertyId);
                    stmt.executeUpdate();
                }

                // Commit giao dịch
                connection.commit();
            } catch (SQLException e) {
                // Rollback nếu có lỗi xảy ra
                connection.rollback();
                throw e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        // Chuyển hướng người dùng đến trang xác nhận đặt cọc
        response.sendRedirect("depositSuccess.jsp");
    }

    // Phương thức kiểm tra xem sản phẩm đã được đặt cọc hay chưa
    private boolean isPropertyDeposited(int userId, int propertyId) {
        String sql = "SELECT COUNT(*) FROM deposit_orders WHERE user_id = ? AND property_id = ?";
        try (Connection connection = Database.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, propertyId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    // Nếu số lượng đơn đặt cọc là > 0, tức là sản phẩm đã được đặt cọc
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
