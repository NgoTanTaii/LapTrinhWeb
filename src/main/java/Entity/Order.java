package Entity;

import java.util.Date;

public class Order {
    private int orderId;
    private int userId;
    private String userName;
    private Date orderDate;
    private String status;  // Thêm trường status

    public Order(int orderId, int userId, String userName, Date orderDate, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.userName = userName;
        this.orderDate = orderDate;
        this.status = status;  // Khởi tạo status
    }

    public Order(int orderId, Date orderDate, String userName, int userId) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.userName = userName;
        this.userId = userId;
    }



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

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Getter và Setter cho status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", userName='" + userName + '\'' +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                '}';
    }
}
