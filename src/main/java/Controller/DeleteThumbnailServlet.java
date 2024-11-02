package Controller;

import Dao.PropertyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static DBcontext.Database.getConnection;

@WebServlet("/DeleteThumbnailServlet")
public class DeleteThumbnailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int propertyId = Integer.parseInt(request.getParameter("property_id"));
        String thumbnailUrl = request.getParameter("thumbnailUrl");

        PropertyDAO propertyDAO = new PropertyDAO();
        propertyDAO.deleteThumbnail(propertyId, thumbnailUrl); // Delete the specific thumbnail

        response.sendRedirect("add-thumbnail.jsp?property_id=" + propertyId); // Redirect back to the thumbnails page
    }

}