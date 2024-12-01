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
import java.util.List;

@WebServlet("/uploadProperty")
@MultipartConfig(
        maxFileSize = 10485760,     // 10MB
        maxRequestSize = 20971520,  // 20MB
        fileSizeThreshold = 0       // Lưu tạm trong bộ nhớ
)
public class PropertyUploadServlet extends HttpServlet {

    private CloudinaryService cloudinaryService;
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo CloudinaryService và PropertyDAO
        cloudinaryService = new CloudinaryService();
        propertyDAO = new PropertyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
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
        int posterId = Integer.parseInt(request.getParameter("poster_id"));

        // Xử lý ảnh chính
        Part mainImagePart = request.getPart("file");
        String mainImageUrl = null;

        if (mainImagePart != null && mainImagePart.getSize() > 0) {
            String fileName = mainImagePart.getSubmittedFileName();
            String tempFilePath = getServletContext().getRealPath("/uploads") + File.separator + fileName;
            File tempFile = new File(tempFilePath);

            try (InputStream inputStream = mainImagePart.getInputStream()) {
                Files.copy(inputStream, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Upload ảnh chính lên Cloudinary và lấy URL với chất lượng cao
            mainImageUrl = cloudinaryService.uploadImage(tempFile); // Chắc chắn rằng hàm uploadImage() đã được chỉnh sửa như trên
        }

        // Tạo đối tượng Property1
        Property1 property = new Property1(title, description, price, address, type, status, area, posterId, mainImageUrl);

        // Thêm bất động sản vào bảng properties và lấy property_id
        int propertyId = propertyDAO.insertProperty(property);

        if (propertyId != -1) {
            // Xử lý các ảnh bổ sung
            List<Part> additionalImageParts = request.getParts().stream()
                    .filter(part -> "additional_images".equals(part.getName()) && part.getSize() > 0)
                    .toList();

            for (Part part : additionalImageParts) {
                String additionalFileName = part.getSubmittedFileName();
                String additionalTempFilePath = getServletContext().getRealPath("/uploads") + File.separator + additionalFileName;
                File additionalTempFile = new File(additionalTempFilePath);

                try (InputStream inputStream = part.getInputStream()) {
                    Files.copy(inputStream, additionalTempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }

                // Upload ảnh bổ sung lên Cloudinary với chất lượng cao
                String additionalImageUrl = cloudinaryService.uploadImage(additionalTempFile); // Upload ảnh phụ
                propertyDAO.insertPropertyImage(propertyId, additionalImageUrl); // Lưu vào bảng property_images
            }

            // Chuyển hướng đến trang thành công
            response.sendRedirect("upload-success.jsp");
        } else {
            // Nếu thêm bất động sản thất bại
            response.sendRedirect("upload-error.jsp");
        }
    }
}