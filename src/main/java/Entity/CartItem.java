package Entity;

public class CartItem {
    private int propertyId;
    private String title;
    private double price;
    private double area;
    private String imageUrl;
    private int cartId;
    private int quantity;
    private String address;

    // Constructor
    public CartItem(int propertyId, String title, double price, double area, String imageUrl, int cartId, int quantity, String address) {
        this.propertyId = propertyId;
        this.title = title;
        this.price = price;
        this.area = area;
        this.imageUrl = imageUrl;
        this.cartId = cartId;
        this.quantity = quantity;
        this.address = address;
    }

    public CartItem() {

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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
