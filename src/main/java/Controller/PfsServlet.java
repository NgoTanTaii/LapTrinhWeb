package Controller;

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
public class PfsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Property1> properties = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/webbds?useUnicode=true&characterEncoding=UTF-8"; // Thay thế với URL cơ sở dữ liệu của bạn
        String dbUser = "root";
        String dbPassword = "";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status = 'sold'";
            PreparedStatement stmt = conn.prepareStatement(sql);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String title = rs.getString("title");
                    double price = rs.getDouble("price"); // Nếu giá trị không tồn tại, sẽ mặc định là 0.0
                    double area = rs.getDouble("area");   // Tương tự cho area
                    String address = rs.getString("address");
                    String imageUrl = rs.getString("image_url");

                    Property1 property = new Property1(title, price, area, address, imageUrl);
                    properties.add(property);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể lấy dữ liệu từ cơ sở dữ liệu.");
        }

        request.setAttribute("properties", properties);
        request.getRequestDispatcher("property-for-sale.jsp").forward(request, response);
    }
}
