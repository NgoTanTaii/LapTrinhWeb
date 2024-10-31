package Controller;

import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Main2 {

    public static void main(String[] args) {
        List<Property1> properties = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/webbds";
        String dbUser = "root";
        String dbPassword = "";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status = 'for sale'";
            PreparedStatement stmt = conn.prepareStatement(sql);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String title = rs.getString("title");
                    double price = rs.getDouble("price");
                    double area = rs.getDouble("area");
                    String address = rs.getString("address");
                    String imageUrl = rs.getString("image_url");

                    // Debugging output to check data retrieved from ResultSet
                    System.out.println("Title from DB: " + title);
                    System.out.println("Price from DB: " + price);
                    System.out.println("Area from DB: " + area);
                    System.out.println("Address from DB: " + address);
                    System.out.println("Image URL from DB: " + imageUrl);

                    // Create Property1 object
                    Property1 property = new Property1(title, price, area, address, imageUrl);
                    properties.add(property);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Print out the properties list to verify data retrieval
        for (Property1 property : properties) {
            System.out.println("Title: " + property.getTitle());
            System.out.println("Price: " + property.getPrice());
            System.out.println("Area: " + property.getArea());
            System.out.println("Address: " + property.getAddress());
            System.out.println("Image URL: " + property.getImageUrl());
            System.out.println("---------------------------");
        }
    }
}
