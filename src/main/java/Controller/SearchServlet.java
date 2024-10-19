package Controller;

import Entity.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Book> books = bookService.searchBooksByName(query);

        // Thiết lập Content-Type là text/html để trả về HTML
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (books != null && !books.isEmpty()) {
            for (Book book : books) {
                out.println("<div class=\"product\">");
                out.println("<img src=\"" + book.getImageUrl() + "\" alt=\"" + book.getTitle() + "\" class=\"product-image\">");
                out.println("<p class=\"product-name\">" + book.getTitle() + "</p>");
                out.println("</div>");
            }
        } else {
            out.println("<p>Không có sản phẩm nào phù hợp với tìm kiếm.</p>");
        }
    }
}
