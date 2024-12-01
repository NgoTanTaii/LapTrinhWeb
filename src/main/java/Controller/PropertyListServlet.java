package Controller;

import DBcontext.Database;
import Entity.PropertyProject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Project")
public class PropertyListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PropertyProject> properties = new ArrayList<>();
        int projectCount = 0;  // Khai báo biến lưu số lượng dự án

        // Kết nối và truy vấn dữ liệu
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement()) {

            // Truy vấn lấy danh sách các dự án với status = 3
            ResultSet rs = stmt.executeQuery("SELECT * FROM properties WHERE status=3");
            while (rs.next()) {
                PropertyProject property = new PropertyProject();
                property.setId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setPrice(rs.getDouble("price"));
                property.setArea(rs.getDouble("area"));
                property.setImageUrl(rs.getString("image_url"));
                property.setAddress(rs.getString("address"));

                // Kiểm tra và gán mô tả nếu có
                String description = rs.getString("description");
                if (description != null && !description.isEmpty()) {
                    property.setDescription(description);
                }

                properties.add(property);  // Thêm bất động sản vào danh sách
            }

            // Truy vấn lấy số lượng các dự án với status = 3
            ResultSet countRs = stmt.executeQuery("SELECT COUNT(*) FROM properties WHERE status=3");
            if (countRs.next()) {
                projectCount = countRs.getInt(1);  // Lấy số lượng từ kết quả truy vấn
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Truyền cả danh sách và số lượng vào request
        request.setAttribute("projects", properties);
        request.setAttribute("projectCount", projectCount);

        // Chuyển hướng tới JSP để hiển thị dữ liệu
        request.getRequestDispatcher("project.jsp").forward(request, response);
    }
}
