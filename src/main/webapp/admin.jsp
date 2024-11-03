<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%

    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">

    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="home-manager">Quản lý sản phẩm</a></li>
            <li><a href="top-property.jsp">Quản lý sản phẩm bán chạy</a></li>
            <li><a href="home-manager.jsp">Quản lý nhà phân phối</a></li>
            <li><a href="top-user-manager.jsp">Quản lý top 5 khách</a></li>
            <li><a href="top-employee-manager.jsp">Quản lý top 5 nhân viên</a></li>
            <li><a href="booking-manager.jsp">Quản lý đơn đặt hàng</a></li>


        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="dashboard-header">
            <div class="dashboard-item">
                <h3>Total Products</h3>
                <p>30</p>
            </div>
            <div class="dashboard-item">
                <h3>Total Sales</h3>
                <p>$21292.0</p>
            </div>
            <div class="dashboard-item">
                <h3>Total Comments</h3>
                <p>6</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
