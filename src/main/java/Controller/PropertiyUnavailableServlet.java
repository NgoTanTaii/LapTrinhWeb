package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/home-unavailable")
public class PropertiyUnavailableServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PropertyDAO propertyDAO = new PropertyDAO();
        List<Property1> unavailableProperties = null;
        try {
            unavailableProperties = propertyDAO.getPropertyUnavailable();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("properties", unavailableProperties);
        request.getRequestDispatcher("home-unavailable.jsp").forward(request, response);

    }

}
