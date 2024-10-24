<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bất Động Sản</title>

</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="#">Quản lý bất động sản</a></li>
            <li><a href="#">Top 10 bất động sản</a></li>
        </ul>
    </div>


    <!-- Main content -->
    <div class="main-content">
        <h2>Danh sách bất động sản</h2>
        <%--        <div class="add-product">--%>
        <%--            <h3>Thêm sản phẩm mới</h3>--%>
        <%--            <a href="add-property.jsp?title=&price=&address=&area=&imageUrl=" class="add-button">Thêm</a>--%>

        <%--        </div>--%>
        <div class="pagination">
            <%
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");
                String searchQuery = request.getParameter("searchQuery"); // Ví dụ về tham số tìm kiếm

                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
                        out.print("<span class='current-page'>" + i + "</span>");
                    } else {
                        out.print("<a href='home-manager?page=" + i + (searchQuery != null ? "&searchQuery=" + searchQuery : "") + "'>" + i + "</a>");
                    }
                }
            %>
        </div>

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
                List<Property1> properties = (List<Property1>) request.getAttribute("properties");

                if (properties != null && !properties.isEmpty()) {
                    for (Property1 property : properties) {
            %>
            <tr>
                <td><%= property.getId() %>
                </td>
                <td><%= property.getTitle() %>
                </td>
                <td><%= property.getPrice() %> tỷ</td>
                <td><%= property.getAddress() %>
                </td>
                <td><%= property.getArea() %> m²</td>
                <td>
                    <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                         alt="Image" width="100">
                </td>
                <td>
                    <a href="edit-property.jsp?id=<%= property.getId() %>">Sửa</a> |
                    <form action="properties" method="POST" style="display:inline;">
                        <input type="hidden" name="id" value="<%= property.getId() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit"
                                onclick="return confirm('Bạn có chắc chắn muốn xóa bất động sản này không?')">Xóa
                        </button>
                    </form>
                </td>

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
<style>

    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        display: flex;
        max-width: 1200px;
        margin: auto;
    }

    .sidebar {
        width: 200px;
        background-color: #333;
        color: white;
        padding: 20px;
        border-radius: 5px 0 0 5px;
    }

    .sidebar ul {
        list-style: none;
        padding: 0;
    }

    .sidebar ul li {
        margin-bottom: 15px;
    }

    .sidebar ul li a {
        color: white;
        text-decoration: none;
        font-size: 16px;
    }

    .sidebar ul li a:hover {
        text-decoration: underline;
    }

    .main-content {
        flex: 1;
        background: white;
        padding: 20px;
        border-radius: 0 5px 5px 0;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }

    .property-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .property-table th, .property-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        height: 80px; /* Chiều cao cố định */
        overflow: hidden; /* Ẩn nội dung thừa */
        text-overflow: ellipsis; /* Hiện dấu "..." nếu nội dung quá dài */
        white-space: normal; /* Cho phép xuống dòng */
    }

    .property-table th {
        background-color: #4CAF50;
        color: white;
        width: 150px; /* Chiều rộng cố định cho cột */

    }

    .property-table td {
        width: 150px; /* Chiều rộng cố định cho cột */
        overflow: auto; /* Cho phép cuộn nếu nội dung quá dài */
        max-height: 80px; /* Giới hạn chiều cao tối đa */
    }


    .property-table tr {
        height: 80px;

    }

    .property-table tr :hover {
        background-color: #f1f1f1;
    }

    .property-table img {
        max-width: 100px;
        height: auto;
        border-radius: 5px;
    }

    .property-table .action-buttons a,
    .property-table form button {
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 8px 12px;
        text-decoration: none;
        cursor: pointer;
    }

    .property-table .action-buttons a:hover,
    .property-table form button:hover {
        background-color: #0056b3;
    }

    .property-table form {
        display: inline;
    }

    .pagination {
        text-align: center;
        margin-top: 20px;
    }

    .pagination a,
    .pagination .current-page {
        margin: 0 5px;
        padding: 8px 12px;
        text-decoration: none;
        color: #007BFF;
        border: 1px solid #007BFF;
        border-radius: 5px;
    }

    .pagination a:hover {
        background-color: #007BFF;
        color: white;
    }

    .current-page {
        background-color: #007BFF;
        color: white;
        border: none;
    }

</style>
</body>
</html>
