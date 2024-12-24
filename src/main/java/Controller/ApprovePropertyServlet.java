package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/approveProperty")
public class ApprovePropertyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyId = request.getParameter("property_id");

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        if (propertyId != null) {
            try (Connection conn = Database.getConnection()) {
                String sql = "UPDATE properties SET available = 1 WHERE property_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(propertyId));
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("error");
            }
        } else {
            response.getWriter().write("error");
        }
    }
}


