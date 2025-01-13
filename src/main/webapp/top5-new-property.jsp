<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<%
    // Lấy danh sách 5 sản phẩm mới nhất
    PropertyDAO propertyDao = new PropertyDAO();
    List<Property1> top5NewestProperties = propertyDao.getTop5NewestProperties();

    // Đặt danh sách vào request để hiển thị trên JSP
    request.setAttribute("top5NewestProperties", top5NewestProperties);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 5 Sản Phẩm Mới Nhất</title>

    <!-- Thêm CSS cho DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

    <!-- Thêm JavaScript cho DataTables -->
    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
</head>
<body>
<h2>Top 5 Sản Phẩm Mới Nhất</h2>

<!-- Thêm liên kết quay lại trang admin.jsp -->
<a href="admin.jsp" style="text-decoration: none; font-size: 18px; color: #007bff;margin-bottom: 20px">Quay lại trang Quản trị</a>

<table id="top5NewestPropertiesTable" class="display property-table">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Giá</th>
        <th>Địa chỉ</th>
        <th>Diện tích (m²)</th>
        <th>Ngày tạo</th>
        <th>Hình ảnh</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Property1> properties = (List<Property1>) request.getAttribute("top5NewestProperties");
        if (properties != null && !properties.isEmpty()) {
            for (Property1 property : properties) {
    %>
    <tr>
        <td><%= property.getId() %></td>
        <td><%= property.getTitle() %></td>
        <td><%= property.getPrice() %> tỷ</td>
        <td><%= property.getAddress() %></td>
        <td><%= property.getArea() %> m²</td>
        <td><%= property.getCreatedAt() %></td>
        <td>
            <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>" alt="Image" width="100">

        </td>

    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="7" style="text-align: center;">Không có sản phẩm mới.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Khởi tạo DataTables cho bảng -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#top5NewestPropertiesTable').DataTable();
    });
</script>
</body>
</html>
