package Controller;

import DBcontext.Database;
import Entity.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DisplayCommentsServletTest {

    public static void main(String[] args) {
        // Simulate the property ID for testing
        String propertyId = "5"; // Use an existing property ID in your database
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

                // Debug output: Display the retrieved comments
                System.out.println("Number of comments retrieved for property_id " + propertyId + ": " + comments.size());
                for (Comment comment : comments) {
                    System.out.println("User ID: " + comment.getUserId());
                    System.out.println("Content: " + comment.getContent());
                    System.out.println("Date: " + comment.getCommentDate());
                    System.out.println("---------------");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (comments.isEmpty()) {
            System.out.println("No comments found for property ID " + propertyId);
        }
    }
}
