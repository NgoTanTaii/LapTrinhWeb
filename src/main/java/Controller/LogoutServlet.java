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

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            HttpSession session = request.getSession(false);

            if (session != null) {
                // Remove cartId and userId from the session
                session.removeAttribute("cartId");
                session.removeAttribute("userId");

                // Invalidate the session
                session.invalidate();
            }

            // Redirect to the home page or login page
            response.sendRedirect("homes");
        }
}
