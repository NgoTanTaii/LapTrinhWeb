<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 10 sản phẩm</title>
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

        .top-products-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .top-products-table th, .top-products-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .top-products-table th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }

        .top-products-table tr:hover {
            background-color: #f1f1f1;
        }

        .top-products-table td {
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
            <li><a href="doanh-thu-theo-thu.jsp">Doanh thu thứ</a></li>
            <li><a href="doanh-thu-theo-thang.jsp">Doanh thu tháng</a></li>
            <li><a href="#">Hóa đơn</a></li>
            <li><a href="user.jsp">Quản lý tài khoản</a></li>
            <li><a href="quan-ly-san-pham.jsp">Quản lý sản phẩm</a></li>
            <li><a href="top-10-san-pham.jsp">Top 10 sản phẩm</a></li>
            <li><a href="#">Top 5 khách hàng</a></li>
            <li><a href="#">Top 5 nhân viên</a></li>
            <li><a href="#">Quản lý nhà cung cấp</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h2 class="content-header">Top 10 sản phẩm</h2>

        <table class="top-products-table">
            <thead>
            <tr>
                <th>Vị trí</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng bán ra</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Sản phẩm 1</td>
                <td>1.000.000 VND</td>
                <td>500</td>
            </tr>
            <tr>
                <td>2</td>
                <td>Sản phẩm 2</td>
                <td>900.000 VND</td>
                <td>450</td>
            </tr>
            <tr>
                <td>3</td>
                <td>Sản phẩm 3</td>
                <td>850.000 VND</td>
                <td>420</td>
            </tr>
            <tr>
                <td>4</td>
                <td>Sản phẩm 4</td>
                <td>800.000 VND</td>
                <td>390</td>
            </tr>
            <tr>
                <td>5</td>
                <td>Sản phẩm 5</td>
                <td>750.000 VND</td>
                <td>360</td>
            </tr>
            <tr>
                <td>6</td>
                <td>Sản phẩm 6</td>
                <td>700.000 VND</td>
                <td>330</td>
            </tr>
            <tr>
                <td>7</td>
                <td>Sản phẩm 7</td>
                <td>650.000 VND</td>
                <td>310</td>
            </tr>
            <tr>
                <td>8</td>
                <td>Sản phẩm 8</td>
                <td>600.000 VND</td>
                <td>290</td>
            </tr>
            <tr>
                <td>9</td>
                <td>Sản phẩm 9</td>
                <td>550.000 VND</td>
                <td>270</td>
            </tr>
            <tr>
                <td>10</td>
                <td>Sản phẩm 10</td>
                <td>500.000 VND</td>
                <td>250</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
