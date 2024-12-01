package Entity;

import java.sql.Timestamp;

public class Property1 {
    private int id;               // ID của tài sản
    private String title;         // Tiêu đề tài sản
    private double price;         // Giá của tài sản
    private double area;          // Diện tích của tài sản
    private String address;       // Địa chỉ của tài sản
    private String type;          // Loại tài sản
    private String status;        // Trạng thái của tài sản
    private String imageUrl;      // URL của hình ảnh
    private String description;   // Mô tả
    private int posterId;         // ID của người đăng
    private Timestamp createdAt;
    private String videoUrl;

    // Constructor đầy đủ
    public Property1(int id, String title, double price, double area, String address, String type, String status, String imageUrl, String description, int posterId, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.area = area;
        this.address = address;
        this.type = type;
        this.status = status;
        this.imageUrl = imageUrl;
        this.description = description;
        this.posterId = posterId;
        this.createdAt = createdAt;
    }

    // Constructor thay đổi các tham số cho trường hợp không cần imageUrl
    public Property1(int id, String title, double price, double area, String address, String type, String status, String imageUrl) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.area = area;
        this.address = address;
        this.type = type;
        this.status = status;
        this.imageUrl = imageUrl;
    }

    // Constructor chỉ có các trường cơ bản
    public Property1(int id, String title, double price, String address, double area, String imageUrl) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.address = address;
        this.area = area;
        this.imageUrl = imageUrl;
    }

    public Property1(String title, String description, double price, String address, String type, String status, double area, int posterId, String imageUrl) {
        this.description = description;
        this.title = title;
        this.price = price;
        this.area = area;
        this.address = address;
        this.type = type;
        this.status = status;
        this.imageUrl = imageUrl;
        this.posterId = posterId;
    }

    public Property1(int propertyId, String title, double price, String address, double area, String description, String type, String status, String imageUrl) {
        this.id = propertyId;
        this.title = title;
        this.price = price;
        this.area = area;
        this.address = address;
        this.type = type;
        this.status = status;
        this.imageUrl = imageUrl != null ? imageUrl : "default-image-url.jpg"; // Chỉ sử dụng giá trị mặc định nếu imageUrl là null
        this.description = description;
    }


    public Property1(int id, String title, String description, double price, String address, String type, String status, double area, String imageUrl) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.address = address;
        this.type = type;
        this.status = status;
        this.area = area;
        this.imageUrl = imageUrl;
    }


    public Property1(String title, String description, double price, String address, String type, String status, double area, int posterId, String mainImageUrl, String videoUrl) {
        this.title = title;
        this.description = description;
        this.price = price;
        this.address = address;
        this.type = type;
        this.status = status;
        this.imageUrl = mainImageUrl;
        this.posterId = posterId;
        this.videoUrl = videoUrl;
 
    }


    // Getter và Setter cho các trường
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPosterId() {
        return posterId;
    }

    public void setPosterId(int posterId) {
        this.posterId = posterId;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    // Constructor mặc định
    public Property1() {
    }

    @Override
    public String toString() {
        return "Property1{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", price=" + price +
                ", area=" + area +
                ", address='" + address + '\'' +
                ", type='" + type + '\'' +
                ", status='" + status + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", description='" + description + '\'' +
                ", posterId=" + posterId +
                '}';
    }


}
