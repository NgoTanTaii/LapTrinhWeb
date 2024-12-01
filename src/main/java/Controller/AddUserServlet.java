package Controller;

import Dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createUser(request, response);
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        // Tạo token duy nhất cho người dùng mới
        String token = UUID.randomUUID().toString();

        // Kiểm tra dữ liệu đầu vào
        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Tên người dùng không được để trống");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);
            return;
        }

        if (email == null || email.isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);
            return;
        }

        if (password == null || password.isEmpty()) {
            request.setAttribute("error", "Mật khẩu không được để trống");
            request.getRequestDispatcher("users").forward(request, response);
            return;
        }

        // Kiểm tra nếu người dùng đã tồn tại
        try {
            boolean userCount = userDAO.checkUserExists(username);
            if (userCount) {
                request.setAttribute("error", "Tên người dùng đã tồn tại");
                request.getRequestDispatcher("users").forward(request, response);
                return;
            }

            // Thêm người dùng vào cơ sở dữ liệu
            userDAO.addUser(username, password, email, token, status, role);
            request.setAttribute("success", "Thêm người dùng thành công");
            request.getRequestDispatcher("users").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi thêm người dùng");
            request.getRequestDispatcher("users").forward(request, response);
        }


        // Thêm người dùng vào cơ sở dữ liệu
        userDAO.addUser(username, password, email, token, status, role);
        request.setAttribute("success", "Thêm người dùng thành công");
        request.getRequestDispatcher("users").forward(request, response);


    }


}
