package Controller;


import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "EditPropertyServlet", value = "/EditPropertyServlet")
public class EditPropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() {
        propertyDAO = new PropertyDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve property details from the request
        int propertyId = Integer.parseInt(request.getParameter("property_id"));
        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));
        String address = request.getParameter("address");
        double area = Double.parseDouble(request.getParameter("area"));
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String type = request.getParameter("type");
        String status = request.getParameter("status");

        // Create a Property1 object with the updated details
        Property1 property = new Property1();
        property.setId(propertyId);
        property.setTitle(title);
        property.setPrice(price);
        property.setAddress(address);
        property.setArea(area);
        property.setImageUrl(imageUrl);
        property.setDescription(description);
        property.setType(type);
        property.setStatus(status);

        // Update the property in the database
        propertyDAO.updateProperty(property);

        // Redirect to the home manager page or any success page
        response.sendRedirect("home-manager");
    }
}