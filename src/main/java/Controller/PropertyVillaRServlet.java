package Controller;

import Dao.PropertyDAO;
import Entity.Property;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
    @WebServlet("/villaR")
    public class PropertyVillaRServlet extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            List<Property> propertyList ;
            PropertyDAO dao = new PropertyDAO();
            try {
                propertyList = dao.getListPropertiesType("villaR");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }


            // Truyền dữ liệu vào request để hiển thị trong JSP
            request.setAttribute("properties", propertyList);


            // Chuyển tiếp tới trang home.jsp để hiển thị
            request.getRequestDispatcher("villa-rental.jsp").forward(request, response);

        }}

