package Controller;

import Dao.PosterDAO;
import Entity.Poster;
import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/createPoster")
@MultipartConfig(
        maxFileSize = 10485760,     // 10MB
        maxRequestSize = 20971520,  // 20MB
        fileSizeThreshold = 0       // Lưu tạm trong bộ nhớ
)
public class CreatePosterServlet extends HttpServlet {

    private CloudinaryService cloudinaryService;
    private PosterDAO posterDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo CloudinaryService và PosterDAO
        cloudinaryService = new CloudinaryService();
        posterDAO = new PosterDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");
        String mail = request.getParameter("mail");
        String phone = request.getParameter("phone");

        // Lấy user_id từ session
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            // Nếu không có userId trong session, chuyển hướng đến trang login
            response.sendRedirect("login.jsp?redirect=createPoster.jsp");
            return;
        }

        // Tiến hành xử lý ảnh và tạo bài đăng nếu user_id hợp lệ
        Part filePart = request.getPart("image_url");
        String fileName = filePart.getSubmittedFileName();
        String tempFilePath = getServletContext().getRealPath("/uploads") + File.separator + fileName;
        File tempFile = new File(tempFilePath);

        // Lưu tạm file vào server trước khi upload lên Cloudinary
        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Upload ảnh lên Cloudinary với chất lượng tối ưu
        String imageUrl = cloudinaryService.uploadImage(tempFile);

        // Tạo đối tượng Poster và gán userId từ session vào
        Poster poster = new Poster(name, mail, phone, imageUrl, userId);

        // Thêm bài đăng vào cơ sở dữ liệu và lấy poster_id
        boolean isAdded = posterDAO.addPoster(poster);

        if (isAdded) {
            // Sau khi thêm thành công, lấy poster_id và gán vào session hoặc sử dụng cho mục đích khác
            Integer posterId = poster.getId(); // Đảm bảo Poster có poster_id sau khi thêm vào DB
            request.getSession().setAttribute("posterId", posterId);

            response.sendRedirect("post-status.jsp?status=success");
        } else {
            response.sendRedirect("post-status.jsp?status=error");
        }
    }
}
