package Entity;

public class Property {
    private int id;
    private String title;
    private String address;
    private double price;
    private double area;
    private String imageUrl;


    public Property(int id, String title, String address, double price, double area, String imageUrl) {
        this.id = id;
        this.title = title;
        this.address = address;
        this.price = price;
        this.area = area;
        this.imageUrl = imageUrl;
    }

    // Getter và Setter
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }
public String toString()    {
        return "Id: " + this.id+" Title "+ this.title + " Address "+ this.address+ " Price "+ this.price+ " Area "+ this.area+ " Image Url "+this.imageUrl;
}
}
