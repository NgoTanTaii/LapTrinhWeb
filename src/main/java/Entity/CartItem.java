package Entity;

import java.math.BigDecimal;

public class CartItem {
    private int propertyId;
    private String title;
    private BigDecimal price;
    private BigDecimal area;
    private String imageUrl;
    private String address;

    // Constructor, getters, and setters
    public CartItem(int propertyId, String title, BigDecimal price, BigDecimal area, String imageUrl, String address) {
        this.propertyId = propertyId;
        this.title = title;
        this.price = price;
        this.area = area;
        this.imageUrl = imageUrl;
        this.address = address;
    }

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
}
