package Entity;

public class Comment {
    private int commentId;
    private int propertyId;
    private int userId;
    private String userName; // Tên người dùng, có thể lấy từ bảng Users
    private String content;
    private String commentDate;

    // Constructor không tham số
    public Comment() {
    }

    // Constructor với tất cả các tham số
    public Comment(int commentId, int propertyId, int userId, String userName, String content, String commentDate) {
        this.commentId = commentId;
        this.propertyId = propertyId;
        this.userId = userId;
        this.userName = userName;
        this.content = content;
        this.commentDate = commentDate;
    }

    // Getter và Setter cho commentId
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    // Getter và Setter cho propertyId
    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    // Getter và Setter cho userId
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Getter và Setter cho userName
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Getter và Setter cho content
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    // Getter và Setter cho commentDate
    public String getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }
}
