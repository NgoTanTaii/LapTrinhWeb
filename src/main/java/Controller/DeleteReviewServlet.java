package Controller;

import Dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        System.out.println(reviewId);
        System.out.println(propertyId);
        // Kết nối tới database và xóa đánh giá
        ReviewDAO reviewDAO = new ReviewDAO();

        // Gọi phương thức xóa đánh giá với reviewId và propertyId
        boolean isDeleted = false;
        try {
            isDeleted = reviewDAO.deleteReview(reviewId, propertyId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (isDeleted) {
            // Sau khi xoá thành công, gửi thông báo và chuyển hướng về trang chi tiết bất động sản
            request.getSession().setAttribute("message", "Đánh giá đã được xoá thành công.");
            response.sendRedirect("property-detail.jsp?id=" + propertyId);
        } else {
            // Nếu xoá không thành công, gửi thông báo lỗi
            request.getSession().setAttribute("message", "Không thể xoá đánh giá. Vui lòng thử lại.");
            response.sendRedirect("property-detail.jsp?id=" + propertyId);
        }
    }
}
