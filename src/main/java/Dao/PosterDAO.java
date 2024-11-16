package Dao;

import DBcontext.Database;
import Entity.Poster;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PosterDAO {

    // Phương thức để lấy kết nối cơ sở dữ liệu
    private Connection getConnection() throws SQLException {
        return Database.getConnection();
    }


    public Poster getPosterByPropertyId(int propertyId) {
        Poster poster = null;
        String query = "SELECT p.image_url,p.poster_id, p.name, p.email, p.phone " +
                "FROM posters p " +
                "JOIN properties pr ON p.poster_id = pr.poster_id " +
                "WHERE pr.property_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Initialize the Poster object with data from the ResultSet
                poster = new Poster(

                        rs.getInt("poster_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("image_url")
                );

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poster;
    }

//    public static void main(String[] args) {
//        System.out.println(new PosterDAO().getPosterByPropertyId(5));
//    }
}
