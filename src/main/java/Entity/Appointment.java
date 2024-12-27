package Entity;

public class Appointment {
    private int id;
    private int orderId;
    private String address;
    private String phone;
    private String appointmentDate;
    private String appointmentTime;
    private int propertyCount;
    private String createdAt;
    private String username;
    private int Contacted;


    public Appointment(int id, String address, String phone, String appointmentDate, String appointmentTime,
                       int propertyCount, String createdAt, String username, int Contacted) {
        this.id = id;
        this.address = address;
        this.phone = phone;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.propertyCount = propertyCount;
        this.createdAt = createdAt;
        this.username = username;
        this.Contacted = Contacted;
    }

    public Appointment(int id, int orderId, String address, String phone, String appointmentDate, String appointmentTime, int propertyCount, String createdAt, String username) {
        this.id = id;
        this.orderId = orderId;
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

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }


    public int getContacted() {
        return Contacted;
    }

    public void setContacted(int contacted) {
        Contacted = contacted;
    }
}
