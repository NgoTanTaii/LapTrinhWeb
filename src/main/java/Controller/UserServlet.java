package Controller;

import DBcontext.ConnectDB;
import Dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/users") // Ánh xạ URL để thay đổi từ /user.jsp thành /users
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
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

            // Đưa danh sách người dùng vào request attribute để gửi đến JSP
            request.setAttribute("users", users);

            // Chuyển tiếp request đến trang user.jsp
            request.getRequestDispatcher("user.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi trong quá trình truy xuất dữ liệu.");
        } finally {
            // Đóng kết nối
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("id"));
        UserDAO userDAO = new UserDAO();

        if ("update".equals(action)) {
            // Chuyển vai trò về chữ thường
            String newRole = request.getParameter("role").toLowerCase();
            userDAO.updateUserRole(userId, newRole);
            response.sendRedirect("users"); // Reload lại trang sau khi cập nhật
        } else if ("delete".equals(action)) {
            userDAO.deleteUser(userId);
            response.sendRedirect("users"); // Reload lại trang sau khi xóa
        }
    }
}
