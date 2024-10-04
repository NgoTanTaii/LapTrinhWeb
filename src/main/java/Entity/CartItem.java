package Entity;

public class CartItem {
    private Book book; // Đối tượng Book
    private int quantity;

    public CartItem(Book book) {
        this.book = book;
        this.quantity = 1; // Default quantity to 1
    }

    public CartItem(Book book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }

    public CartItem() {

    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void incrementQuantity() {
        this.quantity++;
    }
}
