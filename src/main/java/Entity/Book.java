package Entity;


public class Book {
    // Các thuộc tính của Book
    private int id;
    private String genre;
    private String title;
    private String imageUrl;
    private double price;
    private String description;

    public Book() {
    }

    public Book(int id, String genre, String title, String imageUrl, double price, String description) {
        this.id = id;
        this.genre = genre;
        this.title = title;
        this.imageUrl = imageUrl;
        this.price = price;
        this.description = description;
    }

    public Book(int bookId, String bookName, double bookPrice, String bookImageUrl) {
    }

    // Getter và Setter cho id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter và Setter cho genre
    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    // Getter và Setter cho title
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    // Getter và Setter cho imageUrl
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    // Getter và Setter cho price
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // Getter và Setter cho description
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Phương thức toString()
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", genre='" + genre + '\'' +
                ", title='" + title + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                '}';
    }

}
