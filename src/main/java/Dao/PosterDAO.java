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

    public boolean addPoster(Poster poster) {
        String query = "INSERT INTO posters (name, email, phone, image_url, user_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, poster.getName());
            stmt.setString(2, poster.getMail());
            stmt.setString(3, poster.getPhone());
            stmt.setString(4, poster.getImgUrl());
            stmt.setInt(5, poster.getUserId());  // Đảm bảo gán đúng user_id

            int rowsAffected = stmt.executeUpdate();

            // Lấy poster_id vừa được tạo
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int posterId = rs.getInt(1);  // Poster ID vừa được tạo
                    poster.setId(posterId);  // Set lại posterId cho đối tượng Poster
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

//    public static void main(String[] args) {
//        PosterDAO posterDAO = new PosterDAO();
//        Poster poster = posterDAO.getPosterByPropertyId(1);
//        System.out.println(poster);
//        Poster poster2 = new Poster("tao","may","123456789","1",2);
//        System.out.println(posterDAO.addPoster(poster));
//    }
}
