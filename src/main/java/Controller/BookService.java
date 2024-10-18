package Controller;

import DBcontext.Database;
import DBcontext.DbConnection;
import Entity.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookService {
    // Phương thức tìm kiếm sách theo tên
    public List<Book> searchBooksByName(String query) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM book WHERE title LIKE ?"; // Câu truy vấn SQL

        try (Connection conn = DbConnection.initializeDatabase();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%"); // Tìm kiếm bất kỳ vị trí nào
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setImageUrl(rs.getString("imgUrl"));
                book.setPrice(rs.getDouble("price"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return books;
    }
}

