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
//@WebServlet("/filter")
//public class PropertyFilterServlet extends HttpServlet {
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String priceRange = request.getParameter("priceRange");
//        String areaRange = request.getParameter("areaRange");
//
//        PropertyCityDAO propertyDAO = new PropertyCityDAO();
//
//        // Gọi phương thức DAO để lọc bất động sản theo các khoảng giá và diện tích
//        List<Property1> filteredProperties = propertyDAO.filterProperties(priceRange, areaRange);
//
//        // Truyền dữ liệu đã lọc vào request
//        request.setAttribute("properties", filteredProperties);
//
//        // Chuyển tiếp đến JSP để hiển thị kết quả
//        RequestDispatcher dispatcher = request.getRequestDispatcher("property-list.jsp");
//        dispatcher.forward(request, response);
//    }
//}
//
