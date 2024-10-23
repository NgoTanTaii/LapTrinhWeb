package Controller;

import DBcontext.DbConnection1;
import Entity.Property;
import DBcontext.DbConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Property> properties = new ArrayList<>();

        try {
            // Kết nối tới cơ sở dữ liệu
            Connection conn = DbConnection1.initializeDatabase();  // Kết nối đến database
            Statement stmt = conn.createStatement();

            // Truy vấn dữ liệu từ bảng Properties
            String query = "SELECT property_id,title, address, price, area, image_url FROM properties";
            ResultSet rs = stmt.executeQuery(query);

            // Lấy dữ liệu từ ResultSet và thêm vào danh sách properties
            while (rs.next()) {
                Property property = new Property(
                        rs.getInt(
                                "property_id"),
                        rs.getString("title"),
                        rs.getString("address"),
                        rs.getDouble("price"),
                        rs.getDouble("area"),
                        rs.getString("image_url")
                );
                properties.add(property);
            }

            // Đóng kết nối
            rs.close();
            stmt.close();
            conn.close();

            // Truyền dữ liệu vào request để hiển thị trong JSP
            request.setAttribute("properties", properties);

            // Chuyển tiếp tới trang home.jsp để hiển thị
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}