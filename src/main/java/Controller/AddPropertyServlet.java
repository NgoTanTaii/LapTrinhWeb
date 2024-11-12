package Controller;


import Dao.PropertyDAO;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

@WebServlet(name = "AddPropertyServlet", value = "/AddPropertyServlet")
public class AddPropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() {
        propertyDAO = new PropertyDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            createProperty(request);
            response.sendRedirect("home-manager");
        }
    }

    private void createProperty(HttpServletRequest request) {
        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));
        String address = request.getParameter("address");
        double area = Double.parseDouble(request.getParameter("area"));
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String type = request.getParameter("type");
        String status = request.getParameter("status");

        Property1 property = new Property1();
        property.setTitle(title);
        property.setPrice(price);
        property.setAddress(address);
        property.setArea(area);
        property.setImageUrl(imageUrl);
        property.setDescription(description);
        property.setType(type);
        property.setStatus(status);
//      logged in


        propertyDAO.createProperty(property);
        // chuwa log
//        HttpSession session = request.getSession();
//        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
//        if (cart == null) {
//            cart = new ArrayList<>();
//            session.setAttribute("cart", cart);
//        }
//        cart.add(item);
    }
}