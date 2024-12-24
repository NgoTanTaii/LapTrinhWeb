package Controller;

import Dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getReviewImages")
public class ReviewImagesServlet extends HttpServlet {

    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy reviewId từ tham số trong URL
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));

        try {
            // Lấy danh sách ảnh của review từ ReviewDAO
            List<String> imageUrls = reviewDAO.getImagesByReviewId(reviewId);

            if (imageUrls != null && !imageUrls.isEmpty()) {
                // Truyền dữ liệu vào request
                request.setAttribute("imageUrls", imageUrls);
            } else {
                request.setAttribute("imageUrls", new ArrayList<String>()); // Trường hợp không có ảnh
            }

            // Chuyển hướng hoặc forward đến JSP để hiển thị
            request.getRequestDispatcher("property-detail.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể lấy hình ảnh.");
        }
    }


}
