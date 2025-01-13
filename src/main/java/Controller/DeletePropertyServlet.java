package Controller;

import Dao.PosterDAO;
import Dao.PropertyDAO;
import Entity.Poster;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/properties")
public class DeletePropertyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        PropertyDAO propertyDAO = new PropertyDAO();

        if ("delete".equals(action)) {
            String id = request.getParameter("id");

            if (id != null && !id.isEmpty()) {
                try {
                    propertyDAO.deleteProperty(Integer.parseInt(id)); // Xóa bất động sản


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
            // Xử lý cập nhật thông tin bất động sản
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    // Cập nhật bất động sản (các trường khác có thể lấy từ request)
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
        } else if ("disable".equals(action) || "enable".equals(action)) {
            // Xử lý vô hiệu hóa hoặc kích hoạt bất động sản
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try {
                    int propertyId = Integer.parseInt(id);
                    Property1 property = propertyDAO.getPropertyById(propertyId);
                    if (property != null) {
                        String currentStatus = property.getStatus();

                        if ("disable".equals(action)) {
                            property.setStatus("0");  // Chuyển sang vô hiệu hóa (0)
                        } else if ("enable".equals(action)) {
                            // Trả lại trạng thái ban đầu nếu kích hoạt
                            // Giả sử trạng thái ban đầu là "1"
                            property.setStatus(currentStatus.equals("0") ? "1" : currentStatus); // Chỉ thay đổi nếu là "0"
                        }

                        propertyDAO.updateProperty(property);  // Cập nhật lại bất động sản
                    }
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

        // Lấy URL trước đó (referer)
        String refererURL = request.getHeader("Referer");

        // Nếu có referer, chuyển hướng về đó; nếu không, giữ nguyên trang hiện tại
        if (refererURL != null) {
            response.sendRedirect(refererURL); // Quay lại trang trước
        } else {
            // Nếu không có referer, quay lại trang mặc định hoặc xử lý trường hợp này.
            response.sendRedirect("properties");
        }
    }
}
