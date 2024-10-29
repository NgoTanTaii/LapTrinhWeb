package Controller;

import Entity.Property1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/addProduct") // Đặt URL mapping cho servlet
@MultipartConfig // Cần cho việc tải lên tệp
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String priceStr = request.getParameter("price");
        String address = request.getParameter("address");
        String areaStr = request.getParameter("area");
        Part filePart = request.getPart("image");
        String description = request.getParameter("description");

        // Kiểm tra và xử lý giá trị null
        if (title == null || title.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                areaStr == null || areaStr.trim().isEmpty() ||
                description == null || description.trim().isEmpty()) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin sản phẩm.");
            return;
        }

        double price = Double.parseDouble(priceStr);
        double area = Double.parseDouble(areaStr);

        // Lưu hình ảnh
        String imageUrl = "path/to/save/" + filePart.getSubmittedFileName();
        File file = new File(imageUrl);
        filePart.write(file.getAbsolutePath());

        // Tạo đối tượng Property và lưu vào danh sách
        Property1 newProperty = new Property1(title, price, address, area, imageUrl, description);
        List<Property1> properties = (List<Property1>) getServletContext().getAttribute("properties");
        if (properties == null) {
            properties = new ArrayList<>();
        }
        properties.add(newProperty);
        getServletContext().setAttribute("properties", properties);

        // Chuyển hướng về trang quản lý
        response.sendRedirect("admin.jsp");
    }
}
