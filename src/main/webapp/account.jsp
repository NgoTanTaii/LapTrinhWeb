<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tài khoản của tôi</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<head>
    <style>
        body {
            background-color: #f4f4f9;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .account-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #007bff;
        }

        .account-options {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .logout-btn {
            background-color: #dc3545;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        .logout-btn h3 {
            margin: 0;
            font-size: 18px;
            font-weight: bold;
        }

        .btn i {
            margin-right: 8px;
        }

        .account-container a {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .account-container .count-text {
            font-size: 14px;
            font-weight: bold;
            margin-left: 8px;
        }

        /* Thêm hiệu ứng khi hover vào các liên kết */
        .account-options a:hover {
            opacity: 0.8;
        }

        /* Thêm style cho các nút */
        .account-container .btn:focus {
            outline: none;
        }

        /* Thêm hiệu ứng hover cho logout */
        .logout-btn {
            margin-top: 20px;
        }

    </style>
</head>

<body>
<%
    // Lấy userId từ session
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
        response.sendRedirect("login.jsp");
        return;
    }
    PropertyDAO propertyDao = new PropertyDAO();
    List<Property1> properties = propertyDao.getPropertiesByUserId(userId);
    int numProperties = properties.size();
%>

<div class="account-container">
    <h1>Tài khoản của tôi</h1>

    <div class="account-options">
        <a href="notify-for-post.jsp?userId=<%= userId %>" class="btn">
            <i class="fas fa-bell"></i> Thông báo về bất động sản
        </a>

        <a href="user-posts.jsp?userId=<%= userId %>" class="btn">
            Quản lý bất động sản đã đăng
            <span class="count-text">(<%= numProperties %> bất động sản)</span>
        </a>

        <a href="view-userOder.jsp?userId=<%= userId %>" class="btn">Xem những bất động sản đã hẹn</a>

        <a href="change-password.jsp" class="btn">Đổi mật khẩu</a>

        <a href="welcome" class="btn">Quay trở lại trang chính</a>

        <!-- Nút đăng xuất -->
        <a href="javascript:void(0)" id="logoutButton" class="btn logout-btn"
           onclick="document.getElementById('logoutForm').submit();">
            <h3>Đăng xuất</h3>
        </a>

        <!-- Hidden Form to Logout -->
        <form id="logoutForm" action="logout" method="POST" style="display: none;">
            <button type="submit" style="display: none;"></button> <!-- This button will not be visible -->
        </form>
    </div>
</div>

</body>
</html>
