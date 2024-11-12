package Entity;

public class CartItem {
    private int cartItemId;    // ID của mục giỏ hàng
    private int cartId;        // ID giỏ hàng
    private int propertyId;    // ID bất động sản
    private String title;      // Tiêu đề bất động sản
    private double price;      // Giá bất động sản
    private double area;       // Diện tích bất động sản
    private String imageUrl;   // URL của hình ảnh bất động sản
    private int quantity;      // Số lượng của mục này trong giỏ hàng


    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    // Getter và Setter cho cartId
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    // Getter và Setter cho propertyId
    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    // Getter và Setter cho title
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    // Getter và Setter cho price
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // Getter và Setter cho area
    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    // Getter và Setter cho imageUrl
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    // Getter và Setter cho quantity
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


}
