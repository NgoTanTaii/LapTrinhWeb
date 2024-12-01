package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/user-posts")
public class UserPostsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy userId từ session
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy danh sách bài đăng của người dùng
        PropertyDAO propertyDao = new PropertyDAO();
        List<Property1> properties = null;

        try {
            properties = propertyDao.getPropertiesByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Truyền dữ liệu vào JSP
        request.setAttribute("properties", properties);

        // Forward đến trang hiển thị danh sách bài đăng
        RequestDispatcher dispatcher = request.getRequestDispatcher("user-posts.jsp");
        dispatcher.forward(request, response);
    }
}
