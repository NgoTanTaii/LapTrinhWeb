package Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    // Thông tin kết nối cơ sở dữ liệu
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/mysql"; // Thay thế bằng URL của CSDL
    private static final String JDBC_USERNAME = "root"; // Tài khoản CSDL
    private static final String JDBC_PASSWORD = ""; // Mật khẩu CSDL

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Lấy thông tin người dùng từ session (đã đăng nhập)
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String dbPassword = "";

        try {
            // Tải driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Kết nối tới cơ sở dữ liệu
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Truy vấn mật khẩu hiện tại của người dùng từ cơ sở dữ liệu
            String query = "SELECT password FROM users WHERE username = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                dbPassword = rs.getString("password");
            }

            // Kiểm tra mật khẩu cũ có khớp không
            if (!oldPassword.equals(dbPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác.");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return; // Thêm return để đảm bảo không thực hiện tiếp
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp.");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return; // Thêm return để đảm bảo không thực hiện tiếp
            } else {
                // Cập nhật mật khẩu mới trong cơ sở dữ liệu
                query = "UPDATE users SET password = ? WHERE username = ?";
                ps = conn.prepareStatement(query);

                ps.setString(1, newPassword); // Lưu mật khẩu mới


                int result = ps.executeUpdate();

                if (result > 0) {
                    request.setAttribute("successMessage", "Đổi mật khẩu thành công.");
                    request.getRequestDispatcher("change-password.jsp").forward(request, response); // Chuyển hướng về trang đổi mật khẩu để hiển thị thông báo
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra. Vui lòng thử lại.");
                    request.getRequestDispatcher("change-password.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } finally {
            // Đóng các tài nguyên
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("change-password.jsp");
    }
}
