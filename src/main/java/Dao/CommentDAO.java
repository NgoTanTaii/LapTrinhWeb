package Dao;

import DBcontext.Database;
import Entity.Comment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    // Method to add a comment to the database
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO Comments (property_id, user_id, content, comment_date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, comment.getPropertyId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getContent());

            return ps.executeUpdate() > 0; // Return true if insert was successful

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get all comments for a specific property by property ID
    public List<Comment> getCommentsByPropertyId(int propertyId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.comment_id, c.property_id, c.user_id, u.username AS user_name, c.content, c.comment_date " +
                "FROM Comments c JOIN Users u ON c.user_id = u.id WHERE c.property_id = ? ORDER BY c.comment_date DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, propertyId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPropertyId(rs.getInt("property_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setUserName(rs.getString("user_name"));
                comment.setContent(rs.getString("content"));
                comment.setCommentDate(rs.getString("comment_date"));

                comments.add(comment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}
