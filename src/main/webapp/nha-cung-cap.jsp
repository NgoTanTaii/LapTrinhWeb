<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhà cung cấp</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        /* Sidebar styles */
        .sidebar {
            width: 250px;
            background-color: #ffffff;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            padding-top: 20px;
        }

        .sidebar ul {
            list-style-type: none;
        }

        .sidebar ul li {
            padding: 15px 20px;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            display: block;
        }

        .sidebar ul li a:hover {
            background-color: #f0f0f0;
            color: #000;
            border-left: 4px solid #007bff;
        }

        /* Main content styles */
        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #f4f4f4;
        }

        .content-header {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .supplier-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .supplier-table th, .supplier-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .supplier-table th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }

        .supplier-table tr:hover {
            background-color: #f1f1f1;
        }

        .supplier-table td a {
            color: #007bff;
            text-decoration: none;
        }

        .supplier-table td a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="#">Main Dashboard</a></li>
            <li><a href="">Doanh thu thứ</a></li>
            <li><a href="">Doanh thu tháng</a></li>
            <li><a href="#">Hóa đơn</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="">Quản lý sản phẩm</a></li>
            <li><a href="">Top 10 sản phẩm</a></li>
            <li><a href="">Top 5 khách hàng</a></li>
            <li><a href="#">Top 5 nhân viên</a></li>
            <li><a href="">Quản lý nhà cung cấp</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h2 class="content-header">Quản lý nhà cung cấp</h2>

        <table class="supplier-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên nhà cung cấp</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Công ty ABC</td>
                <td>123 Đường A, TP HCM</td>
                <td>0912345678</td>
                <td>
                    <a href="edit-supplier.jsp?id=1">Sửa</a> |
                    <a href="delete-supplier.jsp?id=1" onclick="return confirm('Bạn có chắc chắn muốn xóa nhà cung cấp này không?')">Xóa</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Công ty XYZ</td>
                <td>456 Đường B, Hà Nội</td>
                <td>0987654321</td>
                <td>
                    <a href="edit-supplier.jsp?id=2">Sửa</a> |
                    <a href="delete-supplier.jsp?id=2" onclick="return confirm('Bạn có chắc chắn muốn xóa nhà cung cấp này không?')">Xóa</a>
                </td>
            </tr>
            <!-- Thêm các nhà cung cấp khác tại đây -->
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
