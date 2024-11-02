package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.xml.crypto.Data;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/submitComment")
public class SubmitCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String commentContent = request.getParameter("commentContent");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Kết nối đến cơ sở dữ liệu
            conn = Database.getConnection();

            // Thêm bình luận vào cơ sở dữ liệu
            String sql = "INSERT INTO comments (property_id, user_id, content, comment_date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, propertyId);
            ps.setInt(2, userId);
            ps.setString(3, commentContent);

            int result = ps.executeUpdate();
            if (result > 0) {
                // Bình luận thành công, chuyển hướng về trang chi tiết bất động sản
                response.sendRedirect("property-detail.jsp?id=" + propertyId);
            } else {
                response.getWriter().write("Failed to submit comment.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
