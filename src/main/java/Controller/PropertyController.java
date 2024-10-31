package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


import java.io.IOException;

public class PropertyController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            int propertyId = Integer.parseInt(request.getParameter("property_id"));
            String title = request.getParameter("title");
            double price = Double.parseDouble(request.getParameter("price"));
            String address = request.getParameter("address");
            double area = Double.parseDouble(request.getParameter("area"));
            String imageUrl = null;

            String imageOption = request.getParameter("imageOption");

            if ("file".equals(imageOption)) {
                // Nếu là hình ảnh từ file tải lên
                Part filePart = request.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    // Lưu file hình ảnh vào thư mục server
                    String fileName = filePart.getSubmittedFileName();
                    String filePath = "path/to/save/" + fileName; // Cập nhật đường dẫn phù hợp
                    filePart.write(filePath);
                    imageUrl = filePath; // Cập nhật đường dẫn hình ảnh
                }
            } else {
                // Nếu là hình ảnh từ URL
                imageUrl = request.getParameter("imageUrl");
            }

            // Tạo đối tượng Property1 và cập nhật thông tin
            Property1 property = new Property1();
            property.setId(propertyId);
            property.setTitle(title);
            property.setPrice(price);
            property.setAddress(address);
            property.setArea(area);
            property.setImageUrl(imageUrl); // Cập nhật đường dẫn hình ảnh nếu có

            // Cập nhật bất động sản
            PropertyDAO propertyDAO = new PropertyDAO();
            propertyDAO.updateProperty(property); // Sử dụng phương thức updateProperty thay vì updateProperty1

            // Chuyển hướng về trang quản lý admin sau khi cập nhật
            response.sendRedirect(request.getContextPath() + "/home-manager");
        }
    }

}