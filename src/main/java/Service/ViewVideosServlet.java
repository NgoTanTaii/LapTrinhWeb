package Service;

import DBcontext.Database;
import Dao.VideoDAO;
import Entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewVideos")
public class ViewVideosServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gọi DAO để lấy danh sách video
        VideoDAO videoDAO = new VideoDAO();
        List<Video> videos = videoDAO.getAllVideos();

        // Gửi danh sách video tới JSP
        request.setAttribute("videos", videos);
        request.getRequestDispatcher("/viewVideos.jsp").forward(request, response);
    }
}
