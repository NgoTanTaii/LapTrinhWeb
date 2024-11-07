package Entity;

import java.math.BigDecimal;

public class CartItem {
    private int propertyId;     // ID của sản phẩm (bất động sản)
    private String title;       // Tiêu đề sản phẩm
    private BigDecimal price;   // Giá sản phẩm
    private BigDecimal area;    // Diện tích sản phẩm
    private String imageUrl;    // URL hình ảnh sản phẩm
    private String address;     // Địa chỉ sản phẩm
    private int quantity;       // Số lượng sản phẩm trong giỏ hàng

    // Constructor
    public CartItem(int propertyId, String title, BigDecimal price, BigDecimal area, String imageUrl, String address) {
        this.propertyId = propertyId;
        this.title = title;
        this.price = price;
        this.area = area;
        this.imageUrl = imageUrl;
        this.address = address;
        this.quantity = 1; // Mỗi sản phẩm chỉ được thêm 1 lần vào giỏ hàng
    }

    // Getters and Setters
    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getArea() {
        return area;
    }

    public void setArea(BigDecimal area) {
        this.area = area;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Optional: Override toString() for better debug output
    @Override
    public String toString() {
        return "CartItem{" +
                "propertyId=" + propertyId +
                ", title='" + title + '\'' +
                ", price=" + price +
                ", area=" + area +
                ", imageUrl='" + imageUrl + '\'' +
                ", address='" + address + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}
