package Entity;

import java.util.List;

public class Property1 {
    private int id;               // ID của tài sản
    private String title;         // Tiêu đề tài sản
    private double price;         // Giá của tài sản
    private double area;          // Diện tích của tài sản
    private String address;       // Địa chỉ của tài sản
    private String type;          // Loại tài sản
    private String status;        // Trạng thái của tài sản
    private String imageUrl;      // URL của hình ảnh
    private String description;
    private List<String> imageUrls; // Danh sách hình ảnh khác

    public Property1(int id, String title, double price, double area, String address, String type, String status, String imageUrl, String description, List<String> imageUrls) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.area = area;
        this.address = address;
        this.type = type;
        this.status = status;
        this.imageUrl = imageUrl;
        this.description = description;
        this.imageUrls = imageUrls;
    }

    public Property1() {

    }

    public Property1(String title, double price, String address, double area, String imageUrl, String description) {
    }

    public Property1(int propertyId, String title, double price, double area, String address, String type, String status, String imageUrl) {
    }

    public List<String> getImageUrls() {
        return imageUrls;
    }

    public void setImageUrls(List<String> imageUrls) {
        this.imageUrls = imageUrls;
    }

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


}
