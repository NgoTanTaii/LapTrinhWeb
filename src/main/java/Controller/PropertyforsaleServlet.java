package Controller;

import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/forsale")
public class PropertyforsaleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Property1> properties = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/webbds"; // Replace with your database URL
        String dbUser = "root";
        String dbPassword = "";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String sql = "SELECT * FROM properties WHERE status = 'for sale'";

            PreparedStatement stmt = conn.prepareStatement(sql);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    String title = rs.getString("title");
                    double price = rs.getDouble("price");  // Using getDouble for double type
                    double area = rs.getDouble("area");    // Using getDouble for double type
                    String address = rs.getString("address");
                    String imageUrl = rs.getString("image_url");

                    Property1 property = new Property1(title, price, area, address, imageUrl);
                    properties.add(property);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to retrieve properties from database.");
        }

        // Send the properties list to JSP
        request.setAttribute("properties1", properties);
        request.getRequestDispatcher("property-for-sale.jsp").forward(request, response);
    }
}
