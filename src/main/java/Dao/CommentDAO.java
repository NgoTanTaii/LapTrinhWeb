package Dao;

import DBcontext.Database;
import Entity.Comment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    // Method to retrieve comments for a specific property by property ID
    public List<Comment> getCommentsByPropertyId(String propertyId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.comment_id, c.property_id, c.user_id, u.username AS user_name, c.content, c.comment_date " +
                "FROM Comments c JOIN Users u ON c.user_id = u.id WHERE c.property_id = ? ORDER BY c.comment_date DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(propertyId));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPropertyId(rs.getInt("property_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setUserName(rs.getString("user_name"));
                comment.setContent(rs.getString("content"));
                comment.setCommentDate(rs.getTimestamp("comment_date")); // Set comment date

                comments.add(comment);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching comments for property ID " + propertyId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return comments;
    }
    public int getTotalComments() {
        int totalComments = 0;
        String sql = "SELECT COUNT(*) AS total FROM Comments";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalComments = rs.getInt("total");
            }

        } catch (SQLException e) {
            System.err.println("Error fetching total comments: " + e.getMessage());
            e.printStackTrace();
        }
        return totalComments;
    }
    public boolean deleteComment(int commentId) {
        String sql = "DELETE FROM Comments WHERE comment_id = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, commentId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting comment with ID " + commentId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    public List<Comment> getAllComments() {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.comment_id, c.property_id, c.user_id, u.username AS user_name, c.content, c.comment_date " +
                "FROM Comments c JOIN Users u ON c.user_id = u.id ORDER BY c.comment_date DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPropertyId(rs.getInt("property_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setUserName(rs.getString("user_name"));
                comment.setContent(rs.getString("content"));
                comment.setCommentDate(rs.getTimestamp("comment_date"));
                comments.add(comment);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching all comments: " + e.getMessage());
            e.printStackTrace();
        }
        return comments;
    }
    public String getCommentAuthorUsername(int commentId) {
        String username = null;
        String sql = "SELECT u.username FROM Comments c JOIN Users u ON c.user_id = u.id WHERE c.comment_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, commentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                username = rs.getString("username");
            }

        } catch (SQLException e) {
            System.err.println("Error fetching username for comment ID " + commentId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return username;
    }

}
