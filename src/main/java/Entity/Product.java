package Entity;

public class Product {
    private int id;
    private String productName;
    private double price;
    private int quantity;
    private String imageUrl1; // Đường dẫn hình ảnh 1
    private String imageUrl2; // Đường dẫn hình ảnh 2

    public Product(int id, String productName, double price, int quantity, String imageUrl1, String imageUrl2) {
        this.id = id;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.imageUrl1 = imageUrl1;
        this.imageUrl2 = imageUrl2;
    }

    // Getters và Setters
    public int getId() { return id; }
    public String getProductName() { return productName; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public String getImageUrl1() { return imageUrl1; }
    public String getImageUrl2() { return imageUrl2; }

    public void setId(int id) { this.id = id; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setPrice(double price) { this.price = price; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setImageUrl1(String imageUrl1) { this.imageUrl1 = imageUrl1; }
    public void setImageUrl2(String imageUrl2) { this.imageUrl2 = imageUrl2; }
}
