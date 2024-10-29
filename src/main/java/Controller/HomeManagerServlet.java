package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;

@WebServlet("/home-manager")
public class HomeManagerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");

            if (session == null || role == null || (!"admin".equals(role) && !"manager".equals(role))) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Nhận số trang hiện tại từ request, mặc định là trang 1
            int page = 1;
            int recordsPerPage = 5; // Số sản phẩm hiển thị trên mỗi trang
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            PropertyDAO propertyDAO = new PropertyDAO();
            List<Property1> properties = propertyDAO.getPropertiesByPage((page - 1) * recordsPerPage, recordsPerPage);
            int totalRecords = propertyDAO.getTotalRecords();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            request.setAttribute("properties", properties);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("home-manager.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi trong quá trình truy xuất dữ liệu.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        PropertyDAO propertyDAO = new PropertyDAO();

        try {
            // Kiểm tra hành động: Cập nhật hay xóa
            if ("update".equals(action)) {
                int propertyId = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                double price = Double.parseDouble(request.getParameter("price"));
                String address = request.getParameter("address");
                double area = Double.parseDouble(request.getParameter("area"));
                String type = request.getParameter("type");
                String status = request.getParameter("status");
                String imageUrl = request.getParameter("imageUrl");

                // Cập nhật thông tin bất động sản
                Property1 property = new Property1(propertyId, title, price, area, address, type, status, imageUrl);
                propertyDAO.updateProperty(property);
                response.sendRedirect("home-manager");  // Sau khi cập nhật, điều hướng lại trang bất động sản

            } else if ("delete".equals(action)) {
                int propertyId = Integer.parseInt(request.getParameter("id"));

                // Xóa bất động sản
                propertyDAO.deleteProperty(propertyId);
                response.sendRedirect("home-manager");  // Sau khi xóa, điều hướng lại trang bất động sản
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi trong quá trình xử lý yêu cầu.");
        }
    }
}
