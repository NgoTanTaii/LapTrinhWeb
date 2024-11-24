package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class YourLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String facebookId = request.getParameter("facebookId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webbds", "root", "123456")) {
                PreparedStatement checkUserStmt = conn.prepareStatement("SELECT id, username FROM users WHERE facebook_id = ?");
                checkUserStmt.setString(1, facebookId);
                ResultSet rs = checkUserStmt.executeQuery();

                int userId;
                String username;
                if (rs.next()) {
                    userId = rs.getInt("id");
                    username = rs.getString("username");
                } else {
                    PreparedStatement insertUserStmt = conn.prepareStatement(
                            "INSERT INTO users (facebook_id, username, email, status, role) VALUES (?, ?, ?, 'active', 'user')",
                            Statement.RETURN_GENERATED_KEYS);
                    insertUserStmt.setString(1, facebookId);
                    insertUserStmt.setString(2, name);
                    insertUserStmt.setString(3, email);
                    insertUserStmt.executeUpdate();

                    ResultSet generatedKeys = insertUserStmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        userId = generatedKeys.getInt(1);
                        username = name;
                    } else {
                        throw new SQLException("Failed to create new user.");
                    }
                }

                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);

                // Send a redirect to the welcome page
                response.sendRedirect("welcome.jsp");

            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
