package Controller;

import Dao.PropertyCityDAO;
import Entity.Property1;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class PropertyCityServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String city = request.getParameter("city");

        if (city != null && !city.isEmpty()) {
            PropertyCityDAO dao = new PropertyCityDAO();
            try {
                List<Property1> properties = dao.getPropertiesByCity(city);
                request.setAttribute("properties", properties);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/property-HCM.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tên thành phố");
        }
    }
}
