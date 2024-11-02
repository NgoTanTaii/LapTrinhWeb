package Controller;

import Entity.PropertyProject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Project")
public class PropertyListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PropertyProject> properties = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webbds", "root", "123456");
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM properties")) {

            while (rs.next()) {
                PropertyProject property = new PropertyProject();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setAddress(rs.getString("address"));

                // Kiểm tra và gán mô tả nếu có
                String description = rs.getString("description");
                if (description != null && !description.isEmpty()) {
                    property.setDescription(description);
                }

                properties.add(property);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("projects", properties);
        request.getRequestDispatcher("project.jsp").forward(request, response);
    }
}
