<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doanh thu theo tháng</title>
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

        /* Chart container */
        .chart-container {
            width: 80%;
            margin: 50px auto;
        }

        .bar-chart {
            display: flex;
            flex-direction: column;
            justify-content: space-around; /* Căn đều các tháng */
            height: 100%;
        }

        .bar {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .bar-label {
            width: 15%;
            text-align: right;
            padding-right: 10px;
            font-weight: bold;
        }

        .bar-fill {
            height: 30px;
            background-color: #007bff;
            border-radius: 5px;
            text-align: right;
            color: #fff;
            padding-right: 10px;
            line-height: 30px;
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
            <li><a href="">Hóa đơn</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="#">Quản lý sản phẩm</a></li>
            <li><a href="#">Top 10 sản phẩm</a></li>
            <li><a href="#">Top 5 khách hàng</a></li>

            <li><a href="#">Quản lý nhà cung cấp</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h2 style="text-align: center;">Doanh thu theo tháng</h2>

        <div class="chart-container">
            <!-- Biểu đồ cột ngang -->
            <div class="bar-chart">
                <div class="bar">
                    <div class="bar-label">Tháng 1</div>
                    <div class="bar-fill" style="width: 70%;">7.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 2</div>
                    <div class="bar-fill" style="width: 50%;">5.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 3</div>
                    <div class="bar-fill" style="width: 30%;">9.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 4</div>
                    <div class="bar-fill" style="width: 60%;">6.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 5</div>
                    <div class="bar-fill" style="width: 40%;">4.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 6</div>
                    <div class="bar-fill" style="width: 50%;">8.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 7</div>
                    <div class="bar-fill" style="width: 75%;">7.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 8</div>
                    <div class="bar-fill" style="width: 70%;">8.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 9</div>
                    <div class="bar-fill" style="width: 55%;">5.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 10</div>
                    <div class="bar-fill" style="width: 65%;">6.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 11</div>
                    <div class="bar-fill" style="width: 50%;">9.000.000 VND</div>
                </div>
                <div class="bar">
                    <div class="bar-label">Tháng 12</div>
                    <div class="bar-fill" style="width: 10%;">1.000.000 VND</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
