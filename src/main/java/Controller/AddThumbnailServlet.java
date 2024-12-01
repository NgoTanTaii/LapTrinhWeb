package Controller;

import Dao.PropertyDAO;
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

@WebServlet("/AddThumbnailServlet")
@MultipartConfig(
        maxFileSize = 10485760,     // 10MB
        maxRequestSize = 20971520,  // 20MB
        fileSizeThreshold = 0       // Lưu tạm trong bộ nhớ
)
public class AddThumbnailServlet extends HttpServlet {

    private PropertyDAO propertyDAO;
    private CloudinaryService cloudinaryService;

    @Override
    public void init() throws ServletException {
        propertyDAO = new PropertyDAO();  // Khởi tạo PropertyDAO
        cloudinaryService = new CloudinaryService();  // Khởi tạo CloudinaryService
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyIdParam = request.getParameter("property_id");

        // Kiểm tra xem property_id có được gửi không
        if (propertyIdParam == null || propertyIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required.");
            return;
        }

        int propertyId = Integer.parseInt(propertyIdParam);
        String thumbnailUrl = request.getParameter("thumbnailUrl");

        // Thêm thumbnail nếu có URL được nhập
        if (thumbnailUrl != null && !thumbnailUrl.isEmpty()) {
            propertyDAO.addThumbnail(propertyId, thumbnailUrl);
        } else {
            // Nếu không có URL thì kiểm tra ảnh tải lên từ máy tính
            Part thumbnailFilePart = request.getPart("thumbnailFile");

            if (thumbnailFilePart != null && thumbnailFilePart.getSize() > 0) {
                String uploadedFileUrl = uploadThumbnailToCloudinary(thumbnailFilePart);
                propertyDAO.addThumbnail(propertyId, uploadedFileUrl);  // Lưu URL ảnh vào cơ sở dữ liệu
            }
        }

        // Sau khi thêm thumbnail thành công, chuyển hướng về trang quản lý
        response.sendRedirect("add-thumbnail.jsp?property_id=" + propertyId);
    }

    private String uploadThumbnailToCloudinary(Part filePart) throws IOException {
        // Lấy tên file và đường dẫn tạm thời
        String fileName = filePart.getSubmittedFileName();
        String uploadDir = getServletContext().getRealPath("/uploads");
        File tempFile = new File(uploadDir, fileName);

        // Lưu file vào server tạm thời
        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Upload file lên Cloudinary
        String uploadedImageUrl = cloudinaryService.uploadImage(tempFile);  // Sử dụng File thay vì InputStream

        // Sau khi upload xong, xóa file tạm
        tempFile.delete();

        return uploadedImageUrl;
    }

}
