package Entity;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int propertyId;
    private int quantity;
    private double price;
    private String title;
    private String status;


    public OrderItem(int propertyId, String title, double price, int quantity) {
        this.propertyId = propertyId;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
    }

    public OrderItem(int orderItemId, int orderId, int propertyId, int quantity, double price, String title, String status) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.propertyId = propertyId;
        this.quantity = quantity;
        this.price = price;
        this.title = title;
        this.status = status;

    }

    public OrderItem() {

    }

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemId=" + orderItemId +
                ", orderId=" + orderId +
                ", propertyId=" + propertyId +
                ", quantity=" + quantity +
                ", price=" + price +
                ", title='" + title + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
