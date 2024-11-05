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

    // Phương thức lấy thông tin người đăng dựa trên id
    public Poster getPosterById(int id) {
        Poster poster = null;
        String query = "SELECT * FROM posters WHERE poster_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Khởi tạo đối tượng Poster từ dữ liệu trong ResultSet
                poster = new Poster(
                        rs.getInt("poster_id"),
                        rs.getString("name"),
                        rs.getString("mail"),
                        rs.getString("phone")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poster;
    }
}
