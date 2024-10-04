package Dao;

import Entity.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookDAO {
    private Connection connection;

    public BookDAO(Connection connection) {
        this.connection = connection;
    }

    // Phương thức lấy sách theo ID
    public Book getBookById(int id) {
        Book book = null;
        String query = "SELECT * FROM book WHERE id = ?"; // Thay đổi tên bảng và cột nếu cần
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                // Khởi tạo đối tượng Book từ dữ liệu truy vấn
                book = new Book();
                book.setId(resultSet.getInt("id"));
                book.setGenre(resultSet.getString("genre"));
                book.setTitle(resultSet.getString("title"));
                book.setImageUrl(resultSet.getString("imgUrl"));
                book.setPrice(resultSet.getDouble("price"));
                book.setDescription(resultSet.getString("descritp"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi ở đây
        }
        return book; // Trả về đối tượng Book hoặc null nếu không tìm thấy
    }
}
