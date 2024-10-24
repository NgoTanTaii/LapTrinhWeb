package Controller;

import Dao.PropertyDAO;
import Entity.Property1;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UpdatePropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        propertyDAO = new PropertyDAO(); // Khởi tạo propertyDAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int propertyId = Integer.parseInt(request.getParameter("property_id"));
            Property1 property = propertyDAO.getPropertyById(String.valueOf(propertyId));

            request.setAttribute("properties", property);
            request.getRequestDispatcher("edit-property.jsp").forward(request, response);
        } catch (NumberFormatException | NullPointerException e) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("property_id"));
            String title = request.getParameter("title");
            double price = Double.parseDouble(request.getParameter("price"));
            String address = request.getParameter("address");
            double area = Double.parseDouble(request.getParameter("area"));
            String imageUrl = request.getParameter("imageUrl");

            Property1 property = new Property1(id, title, price, address, area, imageUrl);
            propertyDAO.updateProperty(property); // Assuming this method exists
            response.sendRedirect("home-manager"); // Redirect after update
        }


    }
}

