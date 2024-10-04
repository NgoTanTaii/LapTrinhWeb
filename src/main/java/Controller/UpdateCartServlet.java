package Controller;

import Entity.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookIdStr = request.getParameter("bookId");
        int bookId = Integer.parseInt(bookIdStr);

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        switch (action) {
            case "increase":
                // Thao tác với giỏ hàng chính
                if (cart.containsKey(bookId)) {
                    cart.get(bookId).setQuantity(cart.get(bookId).getQuantity() + 1);
                }
                break;
            case "decrease":
                // Thao tác với giỏ hàng chính
                if (cart.containsKey(bookId)) {
                    CartItem item = cart.get(bookId);
                    if (item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    } else {
                        cart.remove(bookId); // Xóa nếu số lượng là 1
                    }
                }
                break;
            case "remove":
                cart.remove(bookId); // Xóa sản phẩm khỏi giỏ hàng
                break;
        }

        session.setAttribute("cart", cart); // Cập nhật giỏ hàng vào session
        response.sendRedirect("cart.jsp"); // Chuyển hướng tới trang giỏ hàng
    }
}
