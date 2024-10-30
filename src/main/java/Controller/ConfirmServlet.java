package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/confirm")
public class ConfirmServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Đảm bảo driver MySQL đã được thêm vào classpath
        } catch (ClassNotFoundException e) {
            throw new ServletException("Cannot load JDBC driver", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy token từ URL
        String token = request.getParameter("token");
        System.out.println("Received token: " + token); // Debugging

        if (token == null || token.isEmpty()) {

            response.getWriter().println("Token không hợp lệ.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/webbds?useSSL=false&serverTimezone=UTC", "root", "")) { // Thay đổi thông tin kết nối

            // Kiểm tra token có hợp lệ không
            String checkQuery = "SELECT * FROM users WHERE token = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, token);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Token hợp lệ, cập nhật trạng thái tài khoản thành 'active'
                String updateQuery = "UPDATE users SET status = 'active', token = NULL WHERE token = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, token);
                int rowsUpdated = updateStmt.executeUpdate();

                System.out.println("Rows updated: " + rowsUpdated); // Debugging

                if (rowsUpdated > 0) {
                    // Hiển thị thông báo sau khi cập nhật thành công
                    response.setContentType("text/html; charset=UTF-8");
                    response.getWriter().println("<html><body>");
                    response.getWriter().println("<h2>Tài khoản của bạn đã được kích hoạt thành công!</h2>");
                    response.getWriter().println("<p>Vui lòng <a href='login.jsp'>đăng nhập</a> để tiếp tục sử dụng tài khoản.</p>");
                    response.getWriter().println("</body></html>");
                } else {
                    // Nếu không có tài khoản nào được cập nhật
                    response.getWriter().println("Có lỗi xảy ra trong quá trình kích hoạt tài khoản. Vui lòng thử lại.");
                }
            } else {
                // Token không hợp lệ hoặc không tồn tại trong cơ sở dữ liệu
                response.getWriter().println("Token không hợp lệ.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Đã xảy ra lỗi trong quá trình kích hoạt tài khoản.");
        }
    }
}
