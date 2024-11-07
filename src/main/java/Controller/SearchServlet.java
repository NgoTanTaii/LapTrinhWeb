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

    // Phương thức loại bỏ dấu và chuyển thành chữ thường
    private String removeAccents(String input) {
        if (input == null) return "";

        // Loại bỏ dấu và chuyển chuỗi thành chữ thường
        String normalized = java.text.Normalizer.normalize(input, java.text.Normalizer.Form.NFD);
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        String result = pattern.matcher(normalized).replaceAll("");

        return result.toLowerCase(); // Chuyển thành chữ thường
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tham số tìm kiếm từ form
        String searchText = request.getParameter("search");
        String city = request.getParameter("city");

        // Loại bỏ dấu và chuyển chuỗi thành chữ thường
        searchText = removeAccents(searchText);
        city = removeAccents(city);

        // Đảm bảo tham số không null hoặc rỗng
        if (searchText == null) searchText = "";
        if (city == null) city = "";

        // Tạo đối tượng PropertySearchDAO để tìm kiếm sản phẩm từ cơ sở dữ liệu
        PropertySearchDAO propertySearchDAO = new PropertySearchDAO();

        // Tìm kiếm các bất động sản theo từ khóa tìm kiếm
        List<Property1> properties = propertySearchDAO.searchProducts(searchText, city);

        // Đặt kiểu trả về là text/html
        response.setContentType("text/html");

        // Tạo header HTML cho phản hồi
        response.getWriter().println("<html><head><title>Search Results</title></head><body>");

        // Hiển thị tiêu đề của trang
        response.getWriter().println("<h1>Kết quả tìm kiếm</h1>");

        // Kiểm tra nếu không có sản phẩm nào
        if (properties.isEmpty()) {
            response.getWriter().println("<p>Không có bất động sản nào phù hợp với từ khóa: <strong>" + searchText + "</strong> và thành phố: <strong>" + city + "</strong>.</p>");
        } else {
            // Nếu có kết quả, hiển thị danh sách sản phẩm
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

        // Tạo footer HTML cho phản hồi
        response.getWriter().println("</body></html>");
    }
}