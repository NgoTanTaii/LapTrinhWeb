package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/SubmitCommentServlet")
public class SubmitCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username"); // Get username from session
        Integer userId = null;

        // Check if the user is logged in
        if (username == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
            return;
        }

        // Retrieve userId from the database using the username
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT id FROM users WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Proceed only if userId is found
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String commentContent = request.getParameter("comment");
        String propertyId = request.getParameter("productId");

        if (commentContent != null && !commentContent.trim().isEmpty()) {
            try (Connection conn = Database.getConnection()) {
                String sql = "INSERT INTO comments (property_id, user_id, content) VALUES (?, ?, ?)";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(propertyId));
                statement.setInt(2, userId);
                statement.setString(3, commentContent);
                statement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("property-detail.jsp?id=" + propertyId);
    }
}
