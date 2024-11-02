package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.sql.*;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Kết nối đến CSDL
    private Connection connect() throws SQLException {
        String jdbcURL = "jdbc:mysql://localhost:3306/webbds"; // Thay thế bằng tên database của bạn
        String dbUser = "root"; // Thay thế bằng username CSDL của bạn
        String dbPassword = "123456"; // Thay thế bằng mật khẩu CSDL của bạn
        return DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String username = (String) request.getSession().getAttribute("username"); // Assuming the username is stored in the session

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        try (Connection conn = connect()) {
            // Kiểm tra mật khẩu cũ
            String checkOldPasswordQuery = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkOldPasswordQuery);
            checkStmt.setString(1, username);
            checkStmt.setString(2, oldPassword); // Setting old password here
            ResultSet resultSet = checkStmt.executeQuery();

            if (resultSet.next()) {
                // Cập nhật mật khẩu mới
                String updatePasswordQuery = "UPDATE users SET password = ? WHERE username = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updatePasswordQuery);
                updateStmt.setString(1, newPassword); // New password
                updateStmt.setString(2, username); // Username
                updateStmt.executeUpdate();

                request.setAttribute("successMessage", "Mật khẩu đã được đổi thành công!");
            } else {
                request.setAttribute("errorMessage", "Mật khẩu cũ không đúng!");
            }

            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình đổi mật khẩu. Vui lòng thử lại.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        }
    }


}
