<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Kiểm tra nếu người dùng không có session hoặc không phải admin
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
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
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="#">Doanh thu thứ</a></li>
            <li><a href="#">Doanh thu tháng</a></li>
            <li><a href="#">Hóa đơn</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>

            <!-- Thêm đường dẫn đến trang Quản lý sản phẩm -->
            <li><a href="products">Quản lý sản phẩm</a></li>
            <li><a href="#">Top 10 sản phẩm</a></li>
            <li><a href="#">Top 5 khách hàng</a></li>
            <li><a href="product-display.jsp">Quản lý nhà cung cấp</a></li>
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
