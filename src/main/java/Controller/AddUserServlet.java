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

    private void createUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        // Debugging print statements to check the values
        System.out.println("Received username: " + username);
        System.out.println("Received email: " + email);
        System.out.println("Received password: " + password);
        System.out.println("Received role: " + role);
        System.out.println("Received status: " + status);

        // Check if username is null or empty
        if (username == null || username.isEmpty()) {
            System.out.println("Error: Username is null or empty.");
            request.setAttribute("error", "Username cannot be null or empty");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);
            return;
        }

        // Check if email is null or empty
        if (email == null || email.isEmpty()) {
            System.out.println("Error: Email is null or empty.");
            request.setAttribute("error", "Email cannot be null or empty");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);
            return;
        }

        // Check if password is null or empty
        if (password == null || password.isEmpty()) {
            System.out.println("Error: Password is null or empty.");
            request.setAttribute("error", "Password cannot be null or empty");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);
            return;
        }

        // Create the new user object
        User newUser = new User(username, email, password, role, status, null);

        try {
            // Check if the user already exists by username
            boolean userExists = userDAO.checkUserExists(username);
            if (userExists) {
                request.setAttribute("error", "User already exists");
                request.getRequestDispatcher("add-user.jsp").forward(request, response);
                return;
            }

            // Add the user to the database
            userDAO.addUser(newUser);
            // Redirect to success page or back to the form
            request.setAttribute("success", "User added successfully");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Error adding user");
            request.getRequestDispatcher("add-user.jsp").forward(request, response);
        }
    }
}
