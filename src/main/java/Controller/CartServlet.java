package Controller;

import Entity.Book;
import Entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get book details from request parameters
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String bookGenre = request.getParameter("bookGenre");
        String bookTitle = request.getParameter("bookTitle");
        String bookImageUrl = request.getParameter("bookImageUrl");
        double bookPrice = Double.parseDouble(request.getParameter("bookPrice"));
        String bookDescription = request.getParameter("bookDescription");

        // Create a Book object
        Book book = new Book(bookId, bookGenre, bookTitle, bookImageUrl, bookPrice, bookDescription);

        // Get the session and retrieve the cart (stored as a map)
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>(); // Create a new cart if none exists
        }

        // Check if the book is already in the cart
        if (cart.containsKey(bookId)) {
            // If book is already in the cart, increment its quantity
            CartItem existingItem = cart.get(bookId);
            existingItem.incrementQuantity();
        } else {
            // Add new book to the cart
            CartItem newItem = new CartItem(book, 1);
            cart.put(bookId, newItem);
        }

        // Save the updated cart in session
        session.setAttribute("cart", cart);

        // Redirect to the cart display page (cart.jsp)
        response.sendRedirect("cart.jsp");
    }
}
