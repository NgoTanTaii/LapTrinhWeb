package Controller;

import Dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createUser(request, response);
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");  // Ensure this is captured
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        // Debugging print statements
        System.out.println("Received username: " + username);

        System.out.println("Received email: " + email);
        System.out.println("Received password: " + password);
        System.out.println("Received role: " + role);
        System.out.println("Received status: " + status);

        // Check if username is null or empty
        if (username == null || username.isEmpty()) {
            System.out.println("Error: Username is null or empty.");
            response.sendRedirect("add-user.jsp?error=Username cannot be null");
            return;
        }

        // Create the new user object
        User newUser = new User(username, email, password, role, status, null); // Assuming token can be null

        // Add the user to the database
        userDAO.addUser(newUser);
        response.sendRedirect("users");
    }
}
