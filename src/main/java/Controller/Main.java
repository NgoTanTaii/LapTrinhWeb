package Controller;

import DBcontext.Database;
import Entity.Property1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Property1> properties = new ArrayList<>();

        String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status = 2";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String title = rs.getString("title");
                double price = rs.getDouble("price");
                double area = rs.getDouble("area");
                String address = rs.getString("address");
                String imageUrl = rs.getString("image_url");

                // Kiểm tra và in ra các giá trị
                System.out.println("Title: " + title);
                System.out.println("Price: " + price);
                System.out.println("Area: " + area);
                System.out.println("Address: " + address);
                System.out.println("Image URL: " + imageUrl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
