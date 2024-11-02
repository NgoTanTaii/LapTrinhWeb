package Controller;

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
            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();
                String userId = payload.getSubject();
                String email = payload.getEmail();
                String name = (String) payload.get("name");

                // Lưu thông tin người dùng vào session
                request.getSession().setAttribute("user", name);

                // Chuyển hướng đến trang welcome sau khi đăng nhập thành công
                response.sendRedirect("http://localhost:8080/untitled4/welcome");

            } else {
                System.out.println("Invalid ID token.");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid ID token.");
            }
        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
            throw new ServletException("Error verifying ID token", e);
        }
    }
}
