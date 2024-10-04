<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doanh thu theo thứ</title>
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

        .dashboard-header {
            display: flex;
            justify-content: space-between;
        }

        .dashboard-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 30%;
        }

        .dashboard-item h3 {
            font-size: 18px;
            color: #333;
        }

        .dashboard-item p {
            font-size: 24px;
            color: #007bff;
        }

        /* Chart styles */
        .chart-container {
            width: 300px;
            height: 300px;
            margin: 50px auto;
            position: relative;
        }

        .pie-chart {
            width: 100%;
            height: 100%;
            background: conic-gradient(
                    rgba(255, 99, 132, 0.8) 0% 16.67%, /* Thứ 2 - 16.67% */ rgba(54, 162, 235, 0.8) 16.67% 33.33%, /* Thứ 3 - 16.67% */ rgba(255, 206, 86, 0.8) 33.33% 50%, /* Thứ 4 - 16.67% */ rgba(75, 192, 192, 0.8) 50% 66.67%, /* Thứ 5 - 16.67% */ rgba(153, 102, 255, 0.8) 66.67% 83.33%, /* Thứ 6 - 16.67% */ rgba(255, 159, 64, 0.8) 83.33% 100% /* Thứ 7 + CN */
            );
            border-radius: 50%;
        }

        .legend {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .legend-item {
            display: flex;
            align-items: center;
        }

        .legend-color {
            width: 20px;
            height: 20px;
            margin-right: 8px;
        }

        .thursday {
            background-color: rgba(255, 99, 132, 0.8);
        }

        .tuesday {
            background-color: rgba(54, 162, 235, 0.8);
        }

        .wednesday {
            background-color: rgba(255, 206, 86, 0.8);
        }

        .thursday {
            background-color: rgba(75, 192, 192, 0.8);
        }

        .friday {
            background-color: rgba(153, 102, 255, 0.8);
        }

        .saturday {
            background-color: rgba(255, 159, 64, 0.8);
        }

    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="">Main Dashboard</a></li>
            <li><a href="">Doanh thu thứ</a></li>
            <li><a href="">Doanh thu tháng</a></li>
            <li><a href="#">Hóa đơn</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="#">Quản lý sản phẩm</a></li>
            <li><a href="#">Top 10 sản phẩm</a></li>
            <li><a href="#">Top 5 khách hàng</a></li>

            <li><a href="#">Quản lý nhà cung cấp</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h2 style="text-align: center;">Doanh thu theo thứ trong tuần</h2>

        <div class="chart-container">
            <div class="pie-chart"></div>
        </div>

        <div class="legend">
            <div class="legend-item">
                <div class="legend-color thursday"></div>
                <span>Thứ 2</span>
            </div>
            <div class="legend-item">
                <div class="legend-color tuesday"></div>
                <span>Thứ 3</span>
            </div>
            <div class="legend-item">
                <div class="legend-color wednesday"></div>
                <span>Thứ 4</span>
            </div>
            <div class="legend-item">
                <div class="legend-color thursday"></div>
                <span>Thứ 5</span>
            </div>
            <div class="legend-item">
                <div class="legend-color friday"></div>
                <span>Thứ 6</span>
            </div>
            <div class="legend-item">
                <div class="legend-color saturday"></div>
                <span>Thứ 7 + CN</span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
