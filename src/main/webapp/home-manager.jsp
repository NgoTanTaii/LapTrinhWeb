<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bất Động Sản</title>
    <link rel="stylesheet" href="css/admin.css"> <!-- Thêm link đến CSS -->
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="users.jsp">Quản lý tài khoản</a></li>
            <li><a href="properties.jsp">Quản lý bất động sản</a></li>
            <li><a href="#">Top 10 bất động sản</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h2>Danh sách bất động sản</h2>

        <table class="property-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Địa chỉ</th>
                <th>Diện tích (m²)</th>
                <th>Hình ảnh</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Lấy danh sách bất động sản từ servlet
                List<Property1> properties = (List<Property1>) request.getAttribute("properties");

                if (properties != null && !properties.isEmpty()) {
                    for (Property1 property : properties) {
            %>
            <tr>
                <form action="properties" method="POST">
                    <td><%= property.getId() %></td>
                    <td><input type="text" name="title" value="<%= property.getTitle() %>" readonly></td>
                    <td><input type="text" name="price" value="<%= property.getPrice() %>" readonly> VND</td>
                    <td><input type="text" name="address" value="<%= property.getAddress() %>" readonly></td>
                    <td><%= property.getArea() %> m²</td>
                    <td>
                        <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                             alt="Image" width="100">
                    </td>
                    <td>
                        <a href="edit-property.jsp?id=<%= property.getId() %>">Sửa</a> |
                        <button type="submit" name="action" value="delete"
                                onclick="return confirm('Bạn có chắc chắn muốn xóa bất động sản này không?')">Xóa
                        </button>
                    </td>
                </form>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7" style="text-align: center;">Không có bất động sản nào.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
