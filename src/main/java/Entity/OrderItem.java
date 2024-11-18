package Entity;

public class OrderItem {
    private int id;
    private int cartId;
    private int propertyId;
    private String title;
    private double price;
    private float area;
    private String imageUrl;
    private int quantity;
    private String address;

    // Constructors, Getters, and Setters
    public OrderItem() {}

    public OrderItem(int id, int cartId, int propertyId, String title, double price, float area,
                     String imageUrl, int quantity, String address) {
        this.id = id;
        this.cartId = cartId;
        this.propertyId = propertyId;
        this.title = title;
        this.price = price;
        this.area = area;
        this.imageUrl = imageUrl;
        this.quantity = quantity;
        this.address = address;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public int getPropertyId() { return propertyId; }
    public void setPropertyId(int propertyId) { this.propertyId = propertyId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public float getArea() { return area; }
    public void setArea(float area) { this.area = area; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
