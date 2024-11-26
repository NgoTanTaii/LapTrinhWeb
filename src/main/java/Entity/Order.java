package Entity;

import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private String status;
    private String createdAt;
    private List<OrderItem> items;

    // Constructors, Getters, and Setters
    public Order() {}

    public Order(int orderId, int userId, String status, String createdAt, List<OrderItem> items) {
        this.orderId = orderId;
        this.userId = userId;

        this.status = status;
        this.createdAt = createdAt;
        this.items = items;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }


    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}
