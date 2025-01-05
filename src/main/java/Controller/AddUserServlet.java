package Controller;

import Dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

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
                request.getRequestDispatcher("add-user.jsp").forward(request, response);
                return;
            }

            // Kiểm tra nếu người dùng đã tồn tại
            try {
                boolean userCount = userDAO.checkUserExists(username);
                if (userCount) {
                    request.setAttribute("error", "Tên người dùng đã tồn tại");
                    request.getRequestDispatcher("add-user.jsp").forward(request, response);
                    return;
                }

                // Thêm người dùng vào cơ sở dữ liệu
                boolean isUserAdded = userDAO.addUser(username, password, email, null, status, role);

                // Sử dụng sendRedirect để chuyển hướng người dùng tới trang users
                if (isUserAdded) {
                    response.sendRedirect("users?success=true"); // Chuyển hướng tới trang quản lý người dùng và truyền tham số success
                } else {
                    response.sendRedirect("users?error=true"); // Nếu thêm người dùng thất bại, chuyển hướng về trang users với thông báo lỗi
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("users?error=true"); // Lỗi xảy ra, chuyển hướng về trang users với thông báo lỗi
            }
        }
    }




//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
//    }
}
