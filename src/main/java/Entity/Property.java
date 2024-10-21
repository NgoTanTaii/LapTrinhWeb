package Entity;

public class Property {
    private String title;
    private String address;
    private double price;
    private double area;
    private String imageUrl;

    // Constructor
    public Property(String title, String address, double price, double area, String imageUrl) {
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
}
