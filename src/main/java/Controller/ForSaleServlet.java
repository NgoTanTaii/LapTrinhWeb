package Controller;

import DBcontext.Database;
import Dao.PropertyBystatusDAO;
import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/forsale")
public class ForSaleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Property1> properties = new ArrayList<>();

        try (Connection conn = Database.getConnection()) { // Sử dụng phương thức getConnection() từ lớp Database
            String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status = 1";
            PreparedStatement stmt = conn.prepareStatement(sql);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy thông tin từ ResultSet
                    String title = rs.getString("title");
                    double price = rs.getDouble("price");
                    double area = rs.getDouble("area");
                    String address = rs.getString("address");
                    String imageUrl = rs.getString("image_url");

                    // Tạo đối tượng Property1 với các thuộc tính lấy từ cơ sở dữ liệu
                    Property1 property = new Property1();
                    property.setTitle(title);
                    property.setPrice(price);
                    property.setArea(area);
                    property.setAddress(address);
                    property.setImageUrl(imageUrl);

                    properties.add(property);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể lấy dữ liệu từ cơ sở dữ liệu.");
        }

        // Gán danh sách properties cho request attribute để truyền đến JSP
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("property-for-sale.jsp").forward(request, response);
    }
}
