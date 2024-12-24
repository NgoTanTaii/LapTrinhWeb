package Controller;

import DBcontext.Database;
import Entity.Property;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/welcome")
public class PropertyWelcomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Property> properties = new ArrayList<>();

        try {
            // Kết nối tới cơ sở dữ liệu
            Connection conn = Database.getConnection();  // Kết nối đến database
            Statement stmt = conn.createStatement();

            // Truy vấn dữ liệu từ bảng Properties
            String query = "SELECT property_id,title, address, price, area, image_url,status,available FROM properties";
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
                        rs.getString("image_url"),
                        rs.getString("status"),
                        rs.getInt("available")
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
            request.getRequestDispatcher("welcome.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}