package Controller;

import Dao.PropertySearchDAO;
import Entity.Property1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số tìm kiếm từ form
        String searchText = request.getParameter("search");
        String city = request.getParameter("city");

        // Tạo đối tượng PropertySearchDAO để tìm kiếm sản phẩm từ cơ sở dữ liệu
        PropertySearchDAO propertySearchDAO = new PropertySearchDAO();

        // Tìm kiếm các bất động sản theo từ khóa tìm kiếm
        List<Property1> properties = propertySearchDAO.searchProducts(searchText, city);

        // Đặt kiểu trả về là text/html
        response.setContentType("text/html");

        // Kiểm tra nếu không có sản phẩm nào
        if (properties.isEmpty()) {
            response.getWriter().println("<p>Không có bất động sản nào phù hợp với từ khóa: " + searchText + " và thành phố: " + city + "</p>");
        } else {
            response.getWriter().println("<ul>");
            for (Property1 property : properties) {
                // Hiển thị tên và hình ảnh của sản phẩm
                response.getWriter().println("<li>");
                response.getWriter().println("<img src='" + property.getImageUrl() + "' alt='" + property.getTitle() + "' style='width: 100px; height: 100px;'><br>");
                response.getWriter().println("<strong>" + property.getTitle() + "</strong><br>");
                response.getWriter().println("</li>");
            }
            response.getWriter().println("</ul>");
        }
    }
}
