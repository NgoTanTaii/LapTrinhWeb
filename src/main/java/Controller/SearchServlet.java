//package Controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//
//@WebServlet("/SearchServlet")
//public class SearchServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Get search parameters from the form
//        String searchText = request.getParameter("search");
//        String minPrice = request.getParameter("min-price");
//        String maxPrice = request.getParameter("max-price");
//        String minArea = request.getParameter("min-area");
//        String maxArea = request.getParameter("max-area");
//
//        // Process the parameters (e.g., validate and format)
//        // For now, just print them to the console for debugging
//        System.out.println("Search Text: " + searchText);
//        System.out.println("Min Price: " + minPrice);
//        System.out.println("Max Price: " + maxPrice);
//        System.out.println("Min Area: " + minArea);
//        System.out.println("Max Area: " + maxArea);
//
//        // Here, you can query your database with these parameters
//
//        // Set attributes to forward them to the JSP page for displaying results
//        request.setAttribute("searchText", searchText);
//        request.setAttribute("minPrice", minPrice);
//        request.setAttribute("maxPrice", maxPrice);
//        request.setAttribute("minArea", minArea);
//        request.setAttribute("maxArea", maxArea);
//
//        // Forward to JSP page to display the results
//        request.getRequestDispatcher("search-results.jsp").forward(request, response);
//    }
//}
