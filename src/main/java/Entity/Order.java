package Entity;

import java.sql.Date;

public class Order {
    private int orderId;
    private int userId;
    private int propertyId;
    private String title;
    private double price;
    private double area;
    private String address;
    private Date orderDate;

    // Constructor
    public Order(int orderId, int userId, int propertyId, String title, double price, double area, String address, Date orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.propertyId = propertyId;
        this.title = title;
        this.price = price;
        this.area = area;
        this.address = address;
        this.orderDate = orderDate;
    }

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}
