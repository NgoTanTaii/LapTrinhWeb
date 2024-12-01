package Entity;

public class Appointment {
    private int id;
    private String address;
    private String phone;
    private String appointmentDate;
    private String appointmentTime;
    private int propertyCount;
    private String createdAt;
    private String username;


    public Appointment(int id, String address, String phone, String appointmentDate, String appointmentTime,
                       int propertyCount, String createdAt, String username) {
        this.id = id;
        this.address = address;
        this.phone = phone;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.propertyCount = propertyCount;
        this.createdAt = createdAt;
        this.username = username;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(String appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public int getPropertyCount() {
        return propertyCount;
    }

    public void setPropertyCount(int propertyCount) {
        this.propertyCount = propertyCount;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Override toString for better logging
    @Override
    public String toString() {
        return "Appointment{" +
                "id=" + id +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", appointmentDate='" + appointmentDate + '\'' +
                ", appointmentTime='" + appointmentTime + '\'' +
                ", propertyCount=" + propertyCount +
                ", createdAt='" + createdAt + '\'' +
                ", username='" + username + '\'' +
                '}';
    }
}
