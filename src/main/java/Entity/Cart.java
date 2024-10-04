package Entity;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items; // Danh sách các sản phẩm trong giỏ hàng

    public Cart() {
        this.items = new ArrayList<>();
    }

    // Phương thức thêm sản phẩm vào giỏ hàng
    public void addItem(CartItem item) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        for (CartItem cartItem : items) {
            if (cartItem.getBook().getId() == item.getBook().getId()) {
                cartItem.setQuantity(cartItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item); // Nếu chưa có, thêm mới
    }

    // Phương thức lấy danh sách sản phẩm trong giỏ hàng
    public List<CartItem> getItems() {
        return items;
    }

    // Phương thức kiểm tra xem giỏ hàng có rỗng không
    public boolean isEmpty() {
        return items.isEmpty();
    }

    // Phương thức tính tổng số lượng sản phẩm
    public int getTotalQuantity() {
        int totalQuantity = 0;
        for (CartItem item : items) {
            totalQuantity += item.getQuantity();
        }
        return totalQuantity;
    }

    // Phương thức tính tổng giá trị của giỏ hàng
    public double getTotalPrice() {
        double totalPrice = 0;
        for (CartItem item : items) {
            totalPrice += item.getBook().getPrice() * item.getQuantity();
        }
        return totalPrice;
    }
}
