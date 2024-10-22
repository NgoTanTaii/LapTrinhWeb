package Controller;

import DBcontext.DbConnection1;
import Entity.Property1; // Import lớp Property1

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home-manager")
public class HomeManagerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null ||
                (!"admin".equals(session.getAttribute("role")) && !"manager".equals(session.getAttribute("role")))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DbConnection1.initializeDatabase();
            Statement stmt;
            ResultSet rs;

            String query = "SELECT * FROM properties";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery(query);
            List<Property1> propertyList = new ArrayList<>();

            while (rs.next()) {
                Property1 pros = new Property1();
                pros.setId(rs.getInt("property_id"));
                pros.setTitle(rs.getString("title"));
                pros.setPrice(rs.getDouble("price"));
                pros.setAddress(rs.getString("address"));
                pros.setArea(rs.getDouble("area"));
                pros.setImageUrl(rs.getString("image_url"));
                pros.setStatus(rs.getString("status"));

                propertyList.add(pros);

            }
            if (propertyList.isEmpty()) {
                System.out.println("Không có sản phẩm nào được xuất ra.");
            } else {
                System.out.println("Sản phẩm đã được xuất ra: " + propertyList.size() + " sản phẩm.");
            }

            rs.close();
            stmt.close();
            conn.close();


            request.setAttribute("properties", propertyList);
            request.getRequestDispatcher("home-manager.jsp").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();

        }
    }


}
