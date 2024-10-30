package Controller;

import DBcontext.DbConnection1;
import Entity.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


//@WebServlet("/welcome")
public class TestMain extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // Kết nối tới cơ sở dữ liệu
            Connection conn = DbConnection1.initializeDatabase();
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


            request.setAttribute("booksmain", books);

            request.getRequestDispatcher("welcome.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


