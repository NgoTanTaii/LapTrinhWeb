package Dao;

import DBcontext.Database;
import Entity.Video;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VideoDAO {

    // Phương thức lấy URL video dựa trên propertyId
    public String getVideoUrlByPropertyId(String propertyId) {
        String videoUrl = null;
        String sql = "SELECT video_url FROM property_videos WHERE property_id = ?";

        // Sử dụng try-with-resources để tự động đóng kết nối và tài nguyên
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, propertyId); // Đặt giá trị cho propertyId
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    videoUrl = rs.getString("video_url");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Xử lý lỗi, có thể log hoặc hiển thị thông báo cho người dùng
        }

        return videoUrl;
    }

    // Phương thức lấy tất cả video từ bảng property_videos
    public List<Video> getAllVideos() {
        List<Video> videos = new ArrayList<>();
        String sql = "SELECT * FROM property_videos";

        // Sử dụng try-with-resources để tự động đóng kết nối và tài nguyên
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Video video = new Video();
                video.setPropertyId(rs.getInt("property_id"));
                video.setVideoUrl(rs.getString("video_url"));
                videos.add(video);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Xử lý lỗi
        }

        return videos;
    }

    // Phương thức lưu hoặc cập nhật video dựa trên propertyId sử dụng toán tử 3 ngôi
    public void saveOrUpdateVideo(int propertyId, String videoUrl) {
        String existingUrl = getVideoUrlByPropertyId(String.valueOf(propertyId));

        // Sử dụng toán tử 3 ngôi để quyết định chèn hay cập nhật
        if (existingUrl == null) {
            insertVideo(propertyId, videoUrl);
        } else {
            updateVideo(propertyId, videoUrl);
        }
    }

    // Phương thức chèn video mới
    private void insertVideo(int propertyId, String videoUrl) {
        String sql = "INSERT INTO property_videos (property_id, video_url) VALUES (?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, propertyId);
            ps.setString(2, videoUrl);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();  // Xử lý lỗi
        }
    }

    // Phương thức cập nhật video hiện có
    private void updateVideo(int propertyId, String videoUrl) {
        String sql = "UPDATE property_videos SET video_url = ? WHERE property_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, videoUrl);
            ps.setInt(2, propertyId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();  // Xử lý lỗi
        }
    }
}