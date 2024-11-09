package Entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Comment implements Serializable {
    private int commentId;
    private int propertyId;
    private int userId;
    private String userName; // User name from the Users table
    private String content;
    private Timestamp commentDate; // Timestamp for database compatibility

    // No-argument constructor
    public Comment() {
    }

    // All-arguments constructor
    public Comment(int commentId, int propertyId, int userId, String userName, String content, Timestamp commentDate) {
        this.commentId = commentId;
        this.propertyId = propertyId;
        this.userId = userId;
        this.userName = userName;
        this.content = content;
        this.commentDate = commentDate;
    }

    // Getters and Setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Timestamp commentDate) {
        this.commentDate = commentDate;
    }
}
