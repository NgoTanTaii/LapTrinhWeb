package Controller;

import Dao.UserDAO; // Assuming you have a UserDAO to handle database operations
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet("/loginWithGoogle")
public class LoginWithGoogleServlet extends HttpServlet {
    private static final String CLIENT_ID = "161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com";
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idTokenString = request.getParameter("credential");

        if (idTokenString == null || idTokenString.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID token.");
            return;
        }

        GoogleIdTokenVerifier verifier;
        try {
            verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(), JSON_FACTORY)
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();
        } catch (GeneralSecurityException e) {
            throw new ServletException("Failed to set up token verifier", e);
        }

        try {
            // Verify the ID token
            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();

                // Get user details from Google
                String googleUserId = payload.getSubject();  // Google user ID (unique to the user)
                String email = payload.getEmail();
                String name = (String) payload.get("name");

                // Kiểm tra xem googleUserId có phải là chuỗi rỗng không
                if (googleUserId == null || googleUserId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Google user ID.");
                    return;
                }

                // Check if the user already exists in the database by googleUserId
                UserDAO userDAO = new UserDAO();
                if (userDAO.checkUserExists(googleUserId)) {
                    // User exists, just log them in
                    request.getSession().setAttribute("username", name);
                    request.getSession().setAttribute("email", email);
                    response.sendRedirect("welcome"); // Redirect to the welcome page
                } else {
                    // User does not exist, so create a new user
                    String password = ""; // You can set a default password here
                    String token = null; // Set token to null for new users
                    String status = "active"; // Default status for new users
                    String role = "user"; // Default role for new users

                    // Add new user to the database with google_id
                    String userId = "";
                    userDAO.addUser(userId, name, password, email, token, status, role);

                    // Store user info in session after adding to the database
                    request.getSession().setAttribute("username", name);
                    request.getSession().setAttribute("email", email);

                    // Redirect to the welcome page
                    response.sendRedirect("welcome");
                }
            } else {
                // Invalid ID token, return error
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid ID token.");
            }
        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
            throw new ServletException("Error verifying ID token", e);
        }
    }
}
