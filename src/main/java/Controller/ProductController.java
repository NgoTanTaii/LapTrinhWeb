package Controller;

import Entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra phiên người dùng (session)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role) && !"manager".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Product> productList = new ArrayList<>();
        String url = "jdbc:mysql://localhost:3306/mysql?useUnicode=true&characterEncoding=UTF-8";
        String user = "root";
        String password = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Truy vấn danh sách sản phẩm
            String query = "SELECT id, product_name, price, quantity, image_url_1, image_url_2 FROM products";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Lặp qua kết quả và tạo danh sách sản phẩm
            while (rs.next()) {
                int id = rs.getInt("id");
                String productName = rs.getString("product_name");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String imageUrl1 = rs.getString("image_url_1");
                String imageUrl2 = rs.getString("image_url_2");

                Product product = new Product(id, productName, price, quantity, imageUrl1, imageUrl2);
                productList.add(product);
            }

            request.setAttribute("productList", productList);
            request.getRequestDispatcher("product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
