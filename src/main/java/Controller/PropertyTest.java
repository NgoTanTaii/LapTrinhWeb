package Controller;

import DBcontext.Database;
import Entity.Property1;

import java.sql.*;

public class PropertyTest {

    public static void insertProperty(Property1 property) {
        String sql = "INSERT INTO properties (title, description, price, address, type, status, area, poster_id, image_url) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, property.getTitle());
            stmt.setString(2, property.getDescription());
            stmt.setDouble(3, property.getPrice());
            stmt.setString(4, property.getAddress());
            stmt.setString(5, property.getType());
            stmt.setString(6, property.getStatus());
            stmt.setDouble(7, property.getArea());
            stmt.setInt(8, property.getPosterId());
            stmt.setString(9, property.getImageUrl());

            stmt.executeUpdate();
            System.out.println("Property inserted successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
