package Controller;

import Entity.Book;

import javax.servlet.RequestDispatcher;
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

        // Gửi HTML kết quả tìm kiếm về phía client
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (books != null && !books.isEmpty()) {
            for (Book book : books) {
                out.println("<div class=\"product\">");
                out.println("<img src=\"" + book.getImageUrl() + "\" alt=\"" + book.getTitle() + "\" class=\"product-image\">");
                out.println("<p class=\"product-name\">" + book.getTitle() + "</p>");
                out.println("<div class=\"item-price\"><span class=\"price\">" + book.getPrice() + " đ</span></div>");
                out.println("<div class=\"icon-container\">");
                out.println("<a href=\"#\" class=\"icon magnifier\" title=\"Xem chi tiết\">");
                out.println("<img src=\"jpg/zoom-in.png\" alt=\"Kính lúp\" class=\"icon-image\">");
                out.println("</a>");
                out.println("<form method=\"post\" action=\"add-to-cart\" style=\"display:inline;\">");
                out.println("<input type=\"hidden\" name=\"bookId\" value=\"" + book.getId() + "\">");
                out.println("<input type=\"hidden\" name=\"bookName\" value=\"" + book.getTitle() + "\">");
                out.println("<input type=\"hidden\" name=\"bookPrice\" value=\"" + book.getPrice() + "\">");
                out.println("<input type=\"hidden\" name=\"bookImageUrl\" value=\"" + book.getImageUrl() + "\">");
                out.println("<button type=\"submit\" class=\"icon cart\" title=\"Thêm vào giỏ hàng\">");
                out.println("<img src=\"jpg/add-to-cart.png\" alt=\"Giỏ hàng\" class=\"icon-image\">");
                out.println("</button>");
                out.println("</form>");
                out.println("<a href=\"#\" class=\"icon eye\" title=\"Xem nhanh\">");
                out.println("<img src=\"jpg/eye.png\" alt=\"Con mắt\" class=\"icon-image\">");
                out.println("</a>");
                out.println("</div></div>");
            }
        } else {
            out.println("<p>Không có sản phẩm nào phù hợp với tìm kiếm.</p>");
        }
    }
}


