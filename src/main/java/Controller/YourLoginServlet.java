package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.UUID;

@WebServlet("/LoginServlet")
public class YourLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String facebookId = request.getParameter("facebookId");
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");



        String token = UUID.randomUUID().toString();

        // Mặc định trạng thái là 'active' và role là 'user'
        String status = "active";
        String role = "user";

        // Lưu thông tin vào session
        HttpSession session = request.getSession();
        session.setAttribute("userId", facebookId); // Lưu ID từ Facebook
        session.setAttribute("username", username); // Lưu tên người dùng

        // Gọi phương thức để thêm user vào cơ sở dữ liệu
        boolean userAdded = addUser(facebookId, username, password, email, token, status, role);

        if (userAdded) {
            // Nếu insert thành công, chuyển hướng đến trang chào mừng
            response.sendRedirect("welcome");
        } else {
            // Nếu không insert thành công, chuyển hướng đến trang lỗi
            response.sendRedirect("error.jsp");
        }
    }

    private boolean addUser(String facebookId, String username, String password, String email, String token, String status, String role) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Mở kết nối đến cơ sở dữ liệu
            connection = Database.getConnection();

            // Câu lệnh SQL để insert dữ liệu vào bảng 'users'
            String sql = "INSERT INTO users (id, username, password, email, token, status, role) VALUES (?, ?, ?, ?, ?, ?, ?)";

            // Tạo PreparedStatement
            statement = connection.prepareStatement(sql);

            // Set các tham số cho PreparedStatement
            statement.setString(1, facebookId);
            statement.setString(2, username);
            statement.setString(3, password);  // Mật khẩu đã mã hóa
            statement.setString(4, email);
            statement.setString(5, token);     // Token xác thực
            statement.setString(6, status);    // Trạng thái tài khoản
            statement.setString(7, role);      // Quyền người dùng

            // Thực thi câu lệnh INSERT
            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0;  // Nếu số dòng bị ảnh hưởng > 0 thì return true, tức là insert thành công

        } catch (SQLException e) {
            // In lỗi ra console và return false
            e.printStackTrace();
            return false;
        } finally {
            // Đóng kết nối và statement
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}
