package Controller;

import Dao.PropertyDAO;
import Entity.Property1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/properties")
public class DeletePropertyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        PropertyDAO propertyDAO = null;
        if ("delete".equals(action)) {
            String id = request.getParameter("id");

            // Gọi phương thức để xóa sản phẩm trong CSDL
            propertyDAO = new PropertyDAO();
            propertyDAO.deleteProperty(id);
        }

        // Lấy lại danh sách bất động sản để hiển thị
        List<Property1> properties = null;
        try {
            properties = propertyDAO.getAllProperties();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("properties", properties);

        // Lấy thông tin trang hiện tại
        String currentPageParam = request.getParameter("currentPage");
        int currentPage = 1; // Giá trị mặc định

        if (currentPageParam != null && !currentPageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(currentPageParam);
            } catch (NumberFormatException e) {
                // Xử lý nếu cần
            }
        }

        request.setAttribute("currentPage", currentPage);

        // Chuyển tiếp đến trang properties.jsp
        request.getRequestDispatcher("home-manager").forward(request, response);
    }
}
