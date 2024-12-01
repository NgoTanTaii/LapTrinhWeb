//package Controller;
//
//import Dao.PropertyCityDAO;
//import Entity.Property1;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet("/filterProperties")
//public class PropertyFilterServlet extends HttpServlet {
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String priceRange = request.getParameter("priceRange");
//        String areaRange = request.getParameter("areaRange");
//
//        PropertyCityDAO propertyDAO = new PropertyCityDAO();
//        List<Property1> properties = new ArrayList<>();
//
//        // Lọc theo khoảng giá nếu có
//        if (priceRange != null && !priceRange.isEmpty()) {
//            properties = propertyDAO.filterPropertiesByPrice(priceRange);
//        }
//        // Lọc theo diện tích nếu có
//        else if (areaRange != null && !areaRange.isEmpty()) {
//            properties = propertyDAO.filterPropertiesByArea(areaRange);
//        }
//        // Trả về HTML động
//        StringBuilder propertiesHtml = new StringBuilder();
//
//        if (properties != null && !properties.isEmpty()) {
//            for (Property1 property : properties) {
//                propertiesHtml.append("<div class='property-container' data-price='")
//                        .append(property.getPrice()).append("' data-area='").append(property.getArea()).append("'>")
//                        .append("<img src='").append(property.getImageUrl()).append("' alt='Hình ảnh bất động sản' class='property-image'>")
//                        .append("<div class='property-details'>")
//                        .append("<h2 class='property-title'><i class='fas fa-building'></i>").append(property.getTitle()).append("</h2>")
//                        .append("<p class='property-price'><i class='fas fa-dollar-sign'></i>").append(property.getPrice()).append(" tỷ</p>")
//                        .append("<p class='property-area'><i class='fas fa-ruler-combined'></i>").append(property.getArea()).append(" m²</p>")
//                        .append("<p class='property-address'><i class='fas fa-map-marker-alt'></i>").append(property.getAddress()).append("</p>")
//                        .append("<p class='property-description'><i class='fas fa-info-circle'></i>").append(property.getDescription()).append("</p>")
//                        .append("</div></div>");
//            }
//        } else {
//            propertiesHtml.append("<p>Không có bất động sản nào phù hợp với tiêu chí lọc.</p>");
//        }
//
//        // Trả về HTML hoặc JSON
//        response.setContentType("application/json");
//        response.getWriter().write("{\"propertiesHtml\": \"" + propertiesHtml.toString() + "\"}");
//    }
//}
