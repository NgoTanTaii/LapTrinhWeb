package Controller;

import Entity.PropertyProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<PropertyProject> properties = getProperties();

        // In ra danh sách các dự án bất động sản
        if (properties.isEmpty()) {
            System.out.println("Không có dự án nào trong cơ sở dữ liệu.");
        } else {
            for (PropertyProject property : properties) {
                System.out.println("ID: " + property.getId());
                System.out.println("Title: " + property.getTitle());
                System.out.println("Price: " + property.getPrice() + " tỷ");
                System.out.println("Area: " + property.getArea() + " m²");
                System.out.println("Address: " + property.getAddress());
                System.out.println("Image URL: " + property.getImageUrl());
                System.out.println("------------------------");
            }
        }
    }

    // Phương thức để kết nối và lấy danh sách dự án từ cơ sở dữ liệu
    public static List<PropertyProject> getProperties() {
        List<PropertyProject> properties = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/webbds";
        String user = "root";
        String password = "";

        try (Connection conn = DriverManager.getConnection(url, user, password);
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
                properties.add(property);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return properties;
    }
}
