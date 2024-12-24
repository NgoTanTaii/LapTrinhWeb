package ckfinder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;

@WebServlet("/upload1")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 15    // 15 MB
)
public class UploadServlet extends HttpServlet {

    // Đường dẫn tới thư mục lưu trữ tệp tin
    private static final String UPLOAD_DIR = "/var/www/uploads/";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem yêu cầu có phải là multipart
        if (isMultipartContent(request)) {
            // Xử lý form tải lên tệp tin
            Part filePart = request.getPart("file"); // Tên input type="file"

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Đảm bảo thư mục tồn tại
                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                // Lưu tệp tin vào thư mục lưu trữ
                File file = new File(uploadDir, fileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                response.getWriter().println("Tệp tin đã được tải lên thành công: " + fileName);
            } else {
                response.getWriter().println("Không có tệp tin nào được tải lên.");
            }
        } else {
            // Xử lý khi form không phải multipart (sử dụng CKFinder)
            String fileUrl = request.getParameter("fileUrl");
            if (fileUrl != null && !fileUrl.isEmpty()) {
                // Bạn có thể xử lý đường dẫn URL của tệp tin tại đây
                // Ví dụ: Lưu đường dẫn vào cơ sở dữ liệu hoặc sử dụng theo mục đích của bạn
                response.getWriter().println("Đường dẫn tệp tin đã được nhận: " + fileUrl);
            } else {
                response.getWriter().println("Không có đường dẫn tệp tin nào được nhận.");
            }
        }
    }

    /**
     * Kiểm tra xem yêu cầu có phải là multipart không.
     *
     * @param request HttpServletRequest
     * @return true nếu là multipart, ngược lại false
     */
    private boolean isMultipartContent(HttpServletRequest request) {
        String contentType = request.getContentType();
        return contentType != null && contentType.toLowerCase().startsWith("multipart/");
    }
}
