package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/createOrder")
public class CreateOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user ID and order date from request
        int userId = Integer.parseInt(request.getParameter("userId"));
        String orderDateStr = request.getParameter("orderDate");

        // Convert the order date to MySQL-compatible format (yyyy-MM-dd HH:mm:ss)
        String formattedOrderDate = formatOrderDate(orderDateStr);

        // Prepare database connection
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Database.getConnection();

            // SQL query to insert order data
            String insertOrderSQL = "INSERT INTO orders (user_id, property_id, title, price, area, address, order_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertOrderSQL);

            // Use a set to track property IDs that have already been processed
            for (int i = 0; i < request.getParameterValues("propertyId").length; i++) {
                // Get property details for each product
                int propertyId = Integer.parseInt(request.getParameterValues("propertyId")[i]);
                String title = request.getParameterValues("title")[i];
                double price = Double.parseDouble(request.getParameterValues("price")[i]);
                double area = Double.parseDouble(request.getParameterValues("area")[i]);
                String address = request.getParameterValues("address")[i];

                // Avoid inserting multiple orders for the same property_id (if a property appears multiple times)
                stmt.setInt(1, userId);
                stmt.setInt(2, propertyId);
                stmt.setString(3, title);
                stmt.setDouble(4, price);
                stmt.setDouble(5, area);
                stmt.setString(6, address);
                stmt.setString(7, formattedOrderDate);

                // Execute the SQL statement to insert the order
                stmt.executeUpdate();
            }

            // Redirect to checkout page after successful order insertion
            response.sendRedirect("checkout.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to error page if something goes wrong
        } finally {
            // Ensure the connection and statement are closed
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String formatOrderDate(String orderDateStr) {
        try {
            // Define the input date format (assuming it's like 'Thu Nov 28 22:44:37 GMT+07:00 2024')
            SimpleDateFormat inputFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");

            // Parse the input date string to a Date object
            Date date = inputFormat.parse(orderDateStr);

            // Define the output format for MySQL (yyyy-MM-dd HH:mm:ss)
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            // Return the formatted date as a string
            return outputFormat.format(date);
        } catch (Exception e) {
            e.printStackTrace();
            return null; // In case of error, return null or handle as needed
        }
    }
}
