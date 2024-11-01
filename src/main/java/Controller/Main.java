package Controller;

import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Property1> properties = new ArrayList<>();

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/webbds?useUnicode=true&characterEncoding=UTF-8";
        String dbUser = "root";
        String dbPassword = "";

        // Database query and data retrieval
        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status =''";
            PreparedStatement ps = conn.prepareStatement(sql);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    String title = rs.getString("title");
                    double price = rs.getDouble("price");
                    double area = rs.getDouble("area");
                    String address = rs.getString("address");
                    String imageUrl = rs.getString("image_url");

                    // Create a new Property1 object and add it to the list
                    Property1 property = new Property1(title, price, area, address, imageUrl);
                    properties.add(property);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Could not retrieve data from the database.");
        }

        // Print out the retrieved properties
        if (properties.isEmpty()) {
            System.out.println("No sold properties found.");
        } else {
            System.out.println("Sold Properties:");
            for (Property1 property : properties) {
                System.out.println("Title: " + property.getTitle());
                System.out.println("Price: " + property.getPrice() + " billion VND");
                System.out.println("Area: " + property.getArea() + " m²");
                System.out.println("Address: " + property.getAddress());
                System.out.println("Image URL: " + property.getImageUrl());
                System.out.println("-------------");
            }
        }
    }
}
