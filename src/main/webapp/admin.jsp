<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.CommentDAO" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Dao.PropertyBystatusDAO" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<%
    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }
    CommentDAO commentDAO = new CommentDAO();
    PropertyDAO productDAO = new PropertyDAO();
    int totalComments = commentDAO.getTotalComments();
    int totalProducts = productDAO.getTotalProducts();
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
            <li><a href="home-manager">Quản lý bất động sản</a></li>
            <li><a href="top5-new-property.jsp">Quản lý top 5 bds mới</a></li>
            <li><a href="home-unavailable">Phê duyệt bất động sản</a></li>
            <li><a href="top5-posters.jsp">Quản lý top 5 người đăng</a></li>
            <%--            <li><a href="top-employee-manager.jsp">Quản lý top 5 nhân viên</a></li>--%>
            <li><a href="orders">Quản lý đơn đặt bất động sản</a></li>
            <li><a href="comments-manager.jsp">Quản lý bình luận</a></li>
            <li><a href="appointment-manager">Quản lý lịch hẹn</a></li>


        </ul>
    </div>
    <%
        PropertyBystatusDAO propertyDAO = new PropertyBystatusDAO();
    %>

    <div class="main-content">
        <div class="dashboard-header">
            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Tổng bất động sản</h3>
                <p><%= totalProducts %>
                </p>
            </div>

            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Bất động sản - bán</h3>
                <p><%= propertyDAO.countPropertiesByStatus("1") %>
                </p> <!-- Số lượng sản phẩm có sẵn -->
            </div>
            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Bất động sản - cho thuê</h3>
                <p><%= propertyDAO.countPropertiesByStatus("2") %>
                </p> <!-- Số lượng sản phẩm đã bán -->
            </div>
            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Dự án</h3>
                <p><%= propertyDAO.countPropertiesByStatus("3") %>
                </p> <!-- Số lượng sản phẩm hết hàng -->
            </div>


            <div class="dashboard-item">
                <h3><i class="fas fa-comments"></i> Tổng bình luận</h3>
                <p><%= totalComments %>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
