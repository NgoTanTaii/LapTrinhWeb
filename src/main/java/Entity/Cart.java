package Entity;

public class Cart {
    private int cartId;
    private int userId;

    public Cart() {
    }

    public Cart(int userId) {
        this.userId = userId;
    }

    // Getters and Setters
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
