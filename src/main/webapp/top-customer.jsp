<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 5 khách hàng</title>
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

        .customer-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .customer-table th, .customer-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .customer-table th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }

        .customer-table tr:hover {
            background-color: #f1f1f1;
        }

        .customer-table td {
            text-align: center;
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
    <div class=" main-content">
        <h2 class="content-header">Top 5 khách hàng</h2>

        <table class="customer-table">
            <thead>
            <tr>
                <th>Vị trí</th>
                <th>Tên khách hàng</th>
                <th>Số lượng mua hàng</th>
                <th>Tổng chi tiêu</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Nguyễn Văn A</td>
                <td>120 sản phẩm</td>
                <td>120.000.000 VND</td>
            </tr>
            <tr>
                <td>2</td>
                <td>Trần Thị B</td>
                <td>100 sản phẩm</td>
                <td>100.000.000 VND</td>
            </tr>
            <tr>
                <td>3</td>
                <td>Lê Văn C</td>
                <td>95 sản phẩm</td>
                <td>95.000.000 VND</td>
            </tr>
            <tr>
                <td>4</td>
                <td>Phạm Thị D</td>
                <td>85 sản phẩm</td>
                <td>85.000.000 VND</td>
            </tr>
            <tr>
                <td>5</td>
                <td>Hoàng Văn E</td>
                <td>80 sản phẩm</td>
                <td>80.000.000 VND</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
