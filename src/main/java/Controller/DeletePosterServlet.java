package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/deletePoster")
public class DeletePosterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Xóa bản ghi mới nhất
            deleteLatestPoster();
            // Sau khi xóa thành công, chuyển hướng về trang chủ
            response.sendRedirect("welcome");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void deleteLatestPoster() throws SQLException {
        String query = "DELETE p FROM posters p JOIN (SELECT poster_id FROM posters ORDER BY created_at DESC LIMIT 1) AS latest ON p.poster_id = latest.poster_id";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.executeUpdate();  // Thực thi câu lệnh xóa bản ghi mới nhất
        }
    }
}

