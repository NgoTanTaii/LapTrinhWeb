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

@WebServlet("/propertyforsale")
public class PropertyforsaleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Property1> properties = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/webbds"; // Thay thế với tên cơ sở dữ liệu của bạn
        String dbUser = "root";
        String dbPassword = "";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
            String sql = "SELECT title, price, area, address, image_url FROM properties WHERE status = 'for sale'";
            PreparedStatement stmt = conn.prepareStatement(sql);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String title = rs.getString("title");
                    String price = rs.getString("price");
                    String area = rs.getString("area");
                    String address = rs.getString("address");
                    String imageUrl = rs.getString("image_url");

                    // Tạo đối tượng Property1 và thêm vào danh sách
                    Property1 property = new Property1(title, price, area, address, imageUrl);
                    properties.add(property);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý lỗi (có thể thêm logic hiển thị thông báo lỗi cho người dùng)
        }

        // Truyền danh sách properties sang JSP
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("property-for-sale.jsp").forward(request, response);
    }
}
