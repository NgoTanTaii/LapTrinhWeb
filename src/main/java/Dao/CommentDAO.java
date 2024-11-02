package Dao;

import DBcontext.Database;
import Entity.Comment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    // Phương thức để thêm bình luận vào cơ sở dữ liệu
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO Comments (property_id, user_id, content, comment_date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, comment.getPropertyId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getContent());

            return ps.executeUpdate() > 0; // Trả về true nếu thêm thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức để lấy tất cả các bình luận của một bất động sản theo ID
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

    // Phương thức để xóa một bình luận theo ID
    public boolean deleteComment(int commentId) {
        String sql = "DELETE FROM Comments WHERE comment_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, commentId);
            return ps.executeUpdate() > 0; // Trả về true nếu xóa thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức để lấy tất cả bình luận của một người dùng
    public List<Comment> getCommentsByUserId(int userId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.comment_id, c.property_id, c.user_id, u.name AS user_name, c.content, c.comment_date " +
                "FROM Comments c JOIN Users u ON c.user_id = u.user_id WHERE c.user_id = ? ORDER BY c.comment_date DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
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
