<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tài khoản của tôi</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }

        .account-options {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 18px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .logout-btn {
            background-color: #dc3545; /* Màu đỏ cho nút đăng xuất */
        }

        .logout-btn:hover {
            background-color: #c82333; /* Màu đỏ đậm khi hover */
        }

        .logout-btn h3 {
            margin: 0;
            font-size: 18px;
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

<div class="account-options">
    <a href="notify-for-post.jsp?userId=<%= userId %>" class="btn">
        <i class="fas fa-bell"></i> Thông báo về bds
    </a>

    <a href="user-posts.jsp?userId=<%= userId %>" class="btn">Quản lý bất động sản đã đăng (<%= numProperties %>  bds) </a>

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

</body>
</html>
