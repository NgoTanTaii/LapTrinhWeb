package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/editProperty")
@MultipartConfig(
        maxFileSize = 10485760,     // 10MB
        maxRequestSize = 20971520,  // 20MB
        fileSizeThreshold = 0       // Lưu tạm trong bộ nhớ
)
public class EditPropertyServlet extends HttpServlet {

    private CloudinaryService cloudinaryService;
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        cloudinaryService = new CloudinaryService();
        propertyDAO = new PropertyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyId = request.getParameter("property_id");
        Property1 property = propertyDAO.getPropertyById(Integer.parseInt(propertyId));

        if (property != null) {
            request.setAttribute("property", property);
            request.getRequestDispatcher("/edit-property.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String address = request.getParameter("address");
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        double area = Double.parseDouble(request.getParameter("area"));
        int propertyId = Integer.parseInt(request.getParameter("property_id"));

        // Lấy ảnh mới từ form (nếu có)
        Part filePart = request.getPart("image");  // Lấy file từ input có name="image"
        String imageUrl = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Nếu có ảnh mới, tải lên Cloudinary
            String fileName = filePart.getSubmittedFileName();
            String tempFilePath = getServletContext().getRealPath("/uploads") + File.separator + fileName;
            File tempFile = new File(tempFilePath);

            try (InputStream inputStream = filePart.getInputStream()) {
                // Copy ảnh vào file tạm
                Files.copy(inputStream, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Upload ảnh lên Cloudinary và lấy URL
            imageUrl = cloudinaryService.uploadImage(tempFile);
            tempFile.delete();  // Xóa file tạm sau khi upload
        } else {
            // Nếu không có ảnh mới, giữ nguyên URL ảnh cũ
            Property1 property = propertyDAO.getPropertyById(propertyId);
            imageUrl = property.getImageUrl();  // Giữ lại URL ảnh cũ
        }

        // Tạo đối tượng Property1 với thông tin đã chỉnh sửa
        Property1 property = new Property1(propertyId, title, description, price, address, type, status, area, imageUrl);

        // Gọi phương thức updateProperty để cập nhật thông tin vào DB
        boolean result = propertyDAO.updateProperty(property);

        if (result) {
            // Nếu cập nhật thành công, chuyển hướng đến trang chỉnh sửa với tham số property_id
            response.sendRedirect("edit-property.jsp?property_id=" + propertyId);
        } else {
            // Nếu thất bại, quay lại form và thông báo lỗi
            request.setAttribute("error", "Có lỗi khi cập nhật bất động sản.");
            request.setAttribute("property", property); // Gửi lại thông tin property để giữ dữ liệu trong form
            request.getRequestDispatcher("/edit-property.jsp").forward(request, response);
        }
    }
}