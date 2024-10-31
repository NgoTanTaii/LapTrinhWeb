package Entity;

public class PropertyProject {
    private int id;
    private String title;
    private double price;
    private double area;
    private String imageUrl;
    private String address;
    private String description;


    public PropertyProject() {

    }
    public PropertyProject(int id, String title, double price, double area, String imageUrl, String address, String description) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.area = area;
        this.imageUrl = imageUrl;
        this.address = address;
        this.description = description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }



    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // Constructors, Getters, and Setters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public double getPrice() {
        return price;
    }

    public double getArea() {
        return area;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getAddress() {
        return address;
    }


}
