import Controller.User;
import DBcontext.UserDbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    try {
        // Kết nối cơ sở dữ liệu
        Connection conn = UserDbConnection.initializeDatabase();
        Statement stmt = conn.createStatement();
        String query = "SELECT id, username, email, role FROM users";
        ResultSet rs = stmt.executeQuery(query);

        List<User> userList = new ArrayList<>();

        // Lấy dữ liệu từ ResultSet và thêm vào danh sách userList
        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));

            // Kiểm tra dữ liệu được thêm vào danh sách
            System.out.println("User: " + user.getUsername() + ", Email: " + user.getEmail() + ", Role: " + user.getRole());

            userList.add(user);
        }

        // Đóng tài nguyên
        rs.close();
        stmt.close();
        conn.close();

        // Đưa danh sách người dùng vào request để chuyển sang JSP
        request.setAttribute("userlist", userList);
        request.getRequestDispatcher("user.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        // Xử lý lỗi phù hợp
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
    }
}

public void main() {
}


