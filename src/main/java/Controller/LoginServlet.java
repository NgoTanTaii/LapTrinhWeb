package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Kiểm tra trạng thái của người dùng
            String loginStatus = checkLogin(username, password);

            HttpSession session = request.getSession();

            if ("admin".equals(loginStatus)) {
                // Nếu người dùng là admin, lưu vai trò và chuyển đến trang welcome.jsp
                session.setAttribute("username", username);
                session.setAttribute("role", "admin"); // Vai trò admin
                response.sendRedirect("welcome");
            } else if ("active".equals(loginStatus)) {
                // Nếu người dùng là user, lưu vai trò và chuyển đến trang welcome.jsp
                session.setAttribute("username", username);
                session.setAttribute("role", "user"); // Vai trò người dùng
                response.sendRedirect("welcome");
            } else if ("inactive".equals(loginStatus)) {
                // Nếu tài khoản chưa được kích hoạt
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h3>Tài khoản của bạn chưa được kích hoạt. Vui lòng kiểm tra email để xác nhận tài khoản.</h3>");
                request.getRequestDispatcher("login.jsp").include(request, response);
            } else {
                // Nếu đăng nhập thất bại
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h3>Login Failed. Invalid Username or Password.</h3>");
                request.getRequestDispatcher("login.jsp").include(request, response);
            }
        }

        // Kiểm tra thông tin đăng nhập và trạng thái tài khoản
        private String checkLogin(String username, String password) {
            String status = null;
            String url = "jdbc:mysql://localhost:3306/webbds"; // Đảm bảo thay thế đúng tên cơ sở dữ liệu của bạn
            String dbUser = "root";
            String dbPassword = "";

            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                // Truy vấn cơ sở dữ liệu
                String sql = "SELECT role, status FROM users WHERE username = ? AND password = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String role = rs.getString("role");
                    String accountStatus = rs.getString("status");

                    // Kiểm tra vai trò và trạng thái tài khoản
                    if ("admin".equals(role)) {
                        status = "admin";
                    } else if ("active".equals(accountStatus)) {
                        status = "active";
                    } else if ("inactive".equals(accountStatus)) {
                        status = "inactive";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return status;
        }
    }

