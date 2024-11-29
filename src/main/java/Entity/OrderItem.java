package Entity;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int propertyId;
    private int quantity;
    private double price;
    private String title;

    // Constructor
    public OrderItem(int orderItemId, int orderId, int propertyId, int quantity, double price, String title) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.propertyId = propertyId;
        this.quantity = quantity;
        this.price = price;
        this.title = title;
    }

    // Getters and setters
    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
