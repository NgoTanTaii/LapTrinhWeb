package Controller;

import DBcontext.Database;
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

@WebServlet("/forrent")
public class ForRentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Property1> properties = new ArrayList<>();

        // Câu lệnh SQL để lấy các bất động sản có trạng thái là 2 (cho thuê)
        String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status = 2";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String title = rs.getString("title");
                double price = rs.getDouble("price");
                double area = rs.getDouble("area");
                String address = rs.getString("address");
                String imageUrl = rs.getString("image_url");

                // Tạo đối tượng Property1 và thêm vào danh sách
                Property1 property = new Property1(title, price, area, address, imageUrl);
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể lấy dữ liệu từ cơ sở dữ liệu.");
        }

        // Gán danh sách bất động sản vào request để hiển thị trên JSP
        request.setAttribute("properties1", properties);
        request.getRequestDispatcher("property-for-rent.jsp").forward(request, response);
    }
}
