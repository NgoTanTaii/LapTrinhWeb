package Controller;

import DBcontext.Database;

import Entity.Comment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DisplayCommentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyId = request.getParameter("id");
        List<Comment> comments = new ArrayList<>();

        if (propertyId != null) {
            try (Connection conn = Database.getConnection()) {
                String sql = "SELECT user_id, content, comment_date FROM comments WHERE property_id = ?";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(propertyId));
                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setContent(rs.getString("content"));
                    comment.setCommentDate(rs.getTimestamp("comment_date"));
                    comments.add(comment);
                }
                System.out.println("Number of comments retrieved: " + comments.size());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Set comments as a request attribute
        request.setAttribute("comments", comments);

        // Forward with the id parameter in the URL
        request.getRequestDispatcher("property-detail.jsp?id=" + propertyId).forward(request, response);
    }
}