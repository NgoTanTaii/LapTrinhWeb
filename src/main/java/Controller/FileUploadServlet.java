package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/upload")
@MultipartConfig(
        maxFileSize = 10485760,     // 10MB
        maxRequestSize = 20971520,  // 20MB
        fileSizeThreshold = 0       // Lưu tạm trong bộ nhớ
)
public class FileUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thư mục "uploads" trong dự án
        String uploadDir = getServletContext().getRealPath("/uploads");
        File uploadDirFile = new File(uploadDir);

        // Tạo thư mục uploads nếu chưa tồn tại
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        // Lấy tất cả các phần tử file từ request
        Collection<Part> fileParts = request.getParts(); // Lấy tất cả các phần file

        // Danh sách lưu tên các file đã tải lên
        List<String> uploadedFiles = new ArrayList<>();

        // Duyệt qua tất cả các phần tử và xử lý từng phần file
        for (Part filePart : fileParts) {
            if (filePart.getName().equals("file") && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();  // Lấy tên file
                String filePath = uploadDir + File.separator + fileName;
                filePart.write(filePath);  // Lưu file vào thư mục

                // Thêm đường dẫn của file vào danh sách
                uploadedFiles.add("uploads/" + fileName);
            }
        }

        // Gửi danh sách các file đã tải lên vào request
        request.setAttribute("uploadedFiles", uploadedFiles);

        // Chuyển hướng lại đến trang JSP để hiển thị hình ảnh
        request.getRequestDispatcher("post-status.jsp").forward(request, response);
    }
}
