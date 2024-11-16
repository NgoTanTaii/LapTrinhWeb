package Entity;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private String customerName;
    private String propertyName;
    private String status;
    private Timestamp createdAt;

    // Constructor
    public Order(int orderId, String customerName, String propertyName, String status, Timestamp createdAt) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.propertyName = propertyName;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getter and Setter methods
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPropertyName() {
        return propertyName;
    }

    public void setPropertyName(String propertyName) {
        this.propertyName = propertyName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
