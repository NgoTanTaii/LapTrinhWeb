package Entity;


import java.sql.Date;


public class Review {
    private int id;           // ID của đánh giá
    private int propertyId;   // ID của bất động sản
    private int rating;       // Điểm đánh giá (1 đến 5 sao)
    private String review;    // Nội dung đánh giá
    private Date createdAt;   // Thời gian tạo đánh giá
    private String imageUrl;

    // Constructor
    public Review(int propertyId, int rating, String review, Date createdAt) {
        this.propertyId = propertyId;
        this.rating = rating;
        this.review = review;
        this.createdAt = createdAt;
    }

    public Review(int propertyId, int rating, String review) {
        this.propertyId = propertyId;
        this.rating = rating;
        this.review = review;
    }

    public Review(int id, int propertyId, int rating, String review, Date createdAt) {
        this.id = id;
        this.propertyId = propertyId;
        this.rating = rating;
        this.review = review;
        this.createdAt = createdAt;

    }

    public Review(int propertyId, int rating, String reviewText, String imageUrl) {
        this.propertyId = propertyId;
        this.rating = rating;
        this.review = reviewText;
        this.imageUrl = imageUrl;

    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;

    }


}
