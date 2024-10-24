<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@ page import="Dao.PropertyDAO" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bất Động Sản</title>
    <style>
        /* CSS Styles here (you can keep the existing styles) */
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
        }

        .property-table th {
            background-color: #4CAF50;
            color: white;
        }

        .property-table img {
            max-width: 100px;
            height: auto;
            border-radius: 5px;
        }

        .edit-form {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
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
</head>
<body>
<div class="container">

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

        <div class="pagination">
            <%
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");
                String searchQuery = request.getParameter("searchQuery");

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
                    <a href="edit-property.jsp?property_id=<%= property.getId() %>">Sửa</a>|
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
</body>

</html>
