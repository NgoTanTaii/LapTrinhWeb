package Controller;

import DBcontext.ConnectDB;
import Dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Lấy thông tin tài khoản đăng nhập từ session
            HttpSession session = request.getSession();
            String loggedInUsername = (String) session.getAttribute("username"); // Giả sử username của admin đang đăng nhập có trong session

            // Kết nối cơ sở dữ liệu
            conn = ConnectDB.getConnection();

            // Truy vấn dữ liệu người dùng
            String query = "SELECT id, username, email, role FROM users";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Lấy dữ liệu từ ResultSet và thêm vào danh sách
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                users.add(user);
            }

            // Đưa danh sách người dùng và username admin vào request attribute để gửi đến JSP
            request.setAttribute("users", users);
            request.setAttribute("loggedInUsername", loggedInUsername);

            // Chuyển tiếp request đến trang user.jsp
            request.getRequestDispatcher("user.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi trong quá trình truy xuất dữ liệu.");
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (conn != null) try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("update".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            String role = request.getParameter("role");

            // Cập nhật quyền người dùng
            userDAO.updateUserRole(userId, role);
            response.sendRedirect("users");  // Sau khi cập nhật, điều hướng lại trang người dùng

        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));

            // Xóa người dùng
            userDAO.deleteUser(userId);
            response.sendRedirect("users");  // Sau khi xóa, điều hướng lại trang người dùng
        }
    }

}
