package Entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class DepositOrder implements Serializable {
    private int id;
    private int userId;
    private int propertyId;
    private BigDecimal depositAmount;  // Change this to BigDecimal for consistency
    private Date depositDate;
    private String status;
    private String comments;

    // Constructor with full parameters
    public DepositOrder(int id, int userId, int propertyId, BigDecimal depositAmount, Date depositDate, String status) {
        this.id = id;
        this.userId = userId;
        this.propertyId = propertyId;
        this.depositAmount = depositAmount;
        this.depositDate = depositDate;
        this.status = status;
    }

    // Constructor with userId, propertyId, depositAmount, and comments (you may not need to use this)
    public DepositOrder(int userId, int propertyId, BigDecimal depositAmount, String comments) {
        this.userId = userId;
        this.propertyId = propertyId;
        this.depositAmount = depositAmount;
        this.depositDate = new Date();  // Current date
        this.status = "Pending";  // Default status
        this.comments = comments;
    }

    public DepositOrder(int id, int userId, int propertyId, double depositAmount, java.sql.Date depositDate, String status,String comments) {
        this.id = id;
        this.userId = userId;
        this.propertyId = propertyId;
        this.depositAmount = BigDecimal.valueOf(depositAmount);
        this.depositDate = depositDate;
        this.status = status;
        this.comments = comments;
    }


    // Getter and Setter for `id`
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for `userId`
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Getter and Setter for `propertyId`
    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    // Getter and Setter for `depositAmount`
    public BigDecimal getDepositAmount() {
        return depositAmount;
    }

    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }

    // Getter and Setter for `depositDate`
    public Date getDepositDate() {
        return depositDate;
    }

    public void setDepositDate(Date depositDate) {
        this.depositDate = depositDate;
    }

    // Getter and Setter for `status`
    public String getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "DepositOrder{" +
                "id=" + id +
                ", userId=" + userId +
                ", propertyId=" + propertyId +
                ", depositAmount=" + depositAmount +
                ", depositDate=" + depositDate +
                ", status='" + status + '\'' +
                ", comments='" + comments + '\'' +
                '}';
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Getter and Setter for `comments`
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
}
