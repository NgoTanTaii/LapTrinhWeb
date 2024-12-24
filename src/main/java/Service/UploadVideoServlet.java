package Service;

import Dao.VideoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/uploadVideo")
@MultipartConfig(
        maxFileSize = 50 * 1024 * 1024, // 50MB
        maxRequestSize = 100 * 1024 * 1024, // 100MB
        fileSizeThreshold = 1024 // 1MB
)
public class UploadVideoServlet extends HttpServlet {

    // Đường dẫn thư mục lưu trữ video trên server
    private static final String UPLOAD_DIRECTORY = "uploads";

    // Tạo đối tượng VideoDAO
    private VideoDAO videoDAO = new VideoDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy ID sản phẩm từ form
        String productId = request.getParameter("productId");

        // Kiểm tra productId có hợp lệ không
        if (productId == null || productId.trim().isEmpty()) {
            response.getWriter().write("Product ID is required.");
            return;
        }

        // Lấy tệp video từ form
        Part filePart = request.getPart("videoFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Đặt đường dẫn lưu video trên server (lưu trong thư mục "uploads")
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

        // Tạo thư mục nếu chưa có
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Lưu video vào thư mục
        String videoPath = uploadPath + File.separator + fileName;
        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, Paths.get(videoPath), StandardCopyOption.REPLACE_EXISTING);
        }

        // Lưu thông tin video vào cơ sở dữ liệu sử dụng VideoDAO
        try {
            int productIdInt = Integer.parseInt(productId);  // Chuyển đổi thành int
            videoDAO.saveOrUpdateVideo(productIdInt, "/uploads/" + fileName);
            response.getWriter().write("Video uploaded successfully!");
            response.sendRedirect("welcome");
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid Product ID format.");
            response.sendRedirect("welcome");
        }
    }
}
