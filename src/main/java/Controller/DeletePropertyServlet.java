package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.List;
@WebServlet("/properties")
public class DeletePropertyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        PropertyDAO propertyDAO = new PropertyDAO();

        if ("delete".equals(action)) {
            String id = request.getParameter("id");

            if (id != null && !id.isEmpty()) {
                try {
                    propertyDAO.deleteProperty(Integer.parseInt(id));
                } catch (NumberFormatException e) {
                    // Xử lý lỗi khi id không phải là một số
                    request.setAttribute("errorMessage", "ID không hợp lệ.");
                    request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                    return;
                }
            } else {
                // Xử lý nếu id null hoặc rỗng
                request.setAttribute("errorMessage", "ID không được để trống.");
                request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                return;
            }
        } else if ("update".equals(action)) {
            // Tương tự xử lý cập nhật
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    // Lấy các trường khác từ request và cập nhật
                    // ...
                } catch (NumberFormatException e) {
                    // Xử lý lỗi khi id không phải là một số
                    request.setAttribute("errorMessage", "ID không hợp lệ.");
                    request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                    return;
                }
            } else {
                // Xử lý nếu id null hoặc rỗng
                request.setAttribute("errorMessage", "ID không được để trống.");
                request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                return;
            }
        }

        // Lấy danh sách bất động sản cập nhật
        List<Property1> properties = null;
        try {
            properties = propertyDAO.getAllProperties();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("properties", properties);

        // Chuyển tiếp đến trang home-manager để hiển thị danh sách bất động sản
        request.getRequestDispatcher("home-manager").forward(request, response);
    }
}