package Controller;

import DBcontext.DbConnection;
import DBcontext.DbConnection1;
import Entity.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Test extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Kết nối tới cơ sở dữ liệu
            Connection conn = DbConnection.initializeDatabase();
            Statement stmt = conn.createStatement();

            // Truy vấn dữ liệu
            String query = "SELECT * FROM book";
            ResultSet rs = stmt.executeQuery(query);

            // Tạo danh sách để lưu dữ liệu từ ResultSet
            List<Book> books = new ArrayList<>();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setGenre(rs.getString("genre"));
                book.setTitle(rs.getString("title"));
                book.setPrice(rs.getDouble("price"));
                book.setImageUrl(rs.getString("imgUrl"));

                books.add(book);
            }

            // Đóng kết nối
            rs.close();
            stmt.close();
            conn.close();


            request.setAttribute("books", books);

            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
