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
        response.getWriter().println("<html><head><title>Search Results</title>");
        response.getWriter().println("<style>");
        // Định dạng cho phần kết quả tìm kiếm
        response.getWriter().println("#search-results { display: flex; flex-wrap: wrap; gap: 20px; justify-content: space-between; padding: 20px; }");
        response.getWriter().println(".search-product-item { width: calc(20% - 20px); padding: 15px; border: 1px solid #ddd; border-radius: 8px; background-color: #fff; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); text-align: center; transition: transform 0.3s ease, box-shadow 0.3s ease; }");
        response.getWriter().println(".search-product-item:hover { transform: translateY(-5px); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); }");
        response.getWriter().println(".search-product-item img { width: 100%; height: auto; max-height: 200px; object-fit: cover; margin-bottom: 15px; border-radius: 5px; }");
        response.getWriter().println(".search-product-item h3 { font-size: 18px; color: #333; margin-bottom: 10px; }");
        response.getWriter().println(".search-product-item p { font-size: 14px; color: #777; margin-bottom: 10px; }");
        response.getWriter().println(".search-product-item .price { font-size: 16px; color: #e74c3c; font-weight: bold; margin-bottom: 10px; }");
        response.getWriter().println(".search-product-item button { background-color: #3498db; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; font-size: 14px; transition: background-color 0.3s ease; }");
        response.getWriter().println(".search-product-item button:hover { background-color: #2980b9; }");
        response.getWriter().println("</style></head><body>");

        // Hiển thị tiêu đề của trang
        response.getWriter().println("<h1>Kết quả tìm kiếm</h1>");

        // Kiểm tra nếu không có sản phẩm nào
        if (properties.isEmpty()) {
            response.getWriter().println("<p>Không có bất động sản nào phù hợp với từ khóa: <strong>" + searchText + "</strong> và thành phố: <strong>" + city + "</strong>.</p>");
        } else {
            // Thêm phần hiển thị kết quả tìm kiếm
            response.getWriter().println("<div id='search-results'>");

            // Lặp qua danh sách các bất động sản và hiển thị chúng
            for (Property1 property : properties) {
                response.getWriter().println("<div class='search-product-item'>");
                // Hiển thị hình ảnh bất động sản
                response.getWriter().println("<a href='property-detail.jsp?id=" + property.getId() + "' style='text-decoration: none;'>");
                response.getWriter().println("<img src='" + property.getImageUrl() + "' alt='" + property.getId() + "'>");

                // Hiển thị tên và mô tả
                response.getWriter().println("<h3>" + property.getTitle() + "</h3>");




                response.getWriter().println("</div>");  // Đóng thẻ div cho mỗi sản phẩm
            }

            response.getWriter().println("</div>");  // Đóng thẻ div cho search-results
        }

        response.getWriter().println("</body></html>");
    }
}

