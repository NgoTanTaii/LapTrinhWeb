<%

    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bất Động Sản</title>

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <style>
        /* CSS giữ nguyên như bạn đã tạo */
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
            text-align: left;
            color: #333;
            margin-bottom: 20px;
        }

        .add-button {
            padding: 10px 20px;

            background-color: #4CAF50;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;

            margin-left: 700px;

        }

        a {
            text-align: right;
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
    </style>
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
        <a href="add-property.jsp" class="add-button">Thêm bất động sản mới</a>

        <!-- Property Table -->
        <table id="propertyTable" class="display property-table">
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
                    <a href="view-property.jsp?property_id=<%= property.getId() %>">Xem</a> |
                    <a href="edit-property.jsp?property_id=<%= property.getId() %>">Sửa</a> |
                    <a href="add-thumbnail.jsp?property_id=<%= property.getId() %>">Thumbnails</a> |
                    <form action="properties" method="POST" style="display: inline;">
                        <input type="hidden" name="id" value="<%= property.getId() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa bất động sản này không?')">Xóa</button>
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

<!-- jQuery and DataTables JavaScript -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#propertyTable').DataTable({
            "pageLength": 10,
            "language": {
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ mục",
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "Sau",
                    "previous": "Trước"
                },
                "zeroRecords": "Không tìm thấy kết quả phù hợp",
                "infoEmpty": "Không có dữ liệu",
                "infoFiltered": "(lọc từ _MAX_ mục)"
            }
        });
    });
</script>
</body>
</html>
