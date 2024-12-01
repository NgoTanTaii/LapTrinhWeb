<%@ page import="Entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        .bell-icon {
            font-size: 24px;
            color: #4b5563; /* Màu mặc định của chuông */
            cursor: pointer;
            transition: color 0.3s, transform 0.2s, box-shadow 0.3s;
            margin-left: 50px; /* Khoảng cách bên ngoài chuông */
        }

        .bell-icon:hover {
            color: #4CAF50; /* Màu khi hover */
            transform: scale(1.2); /* Phóng to biểu tượng khi hover */
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.3); /* Thêm bóng đổ khi hover */
        }

        .bell-icon:active {
            color: #FF5722; /* Màu khi click */
            transform: scale(0.95); /* Thu nhỏ khi click */
        }

        .bell-icon:focus {
            outline: none; /* Tắt viền khi nhấn chuột vào chuông */
        }
    </style>
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Quản lý Đơn hàng</h1>

    <%-- Kiểm tra quyền admin --%>
    <%
        String role = (String) session.getAttribute("role");  // Lấy thông tin phân quyền từ session (ví dụ: "admin" hoặc "user")

        if (role == null || !role.equals("admin")) {  // Nếu không phải admin
            response.sendRedirect("access-denied.jsp");  // Chuyển hướng đến trang access-denied.jsp
            return;
        }
    %>

    <%-- Nút quay lại trang admin --%>
    <div class="mb-5">
        <a href="admin.jsp" class="text-blue-600">Quay lại trang quản trị</a>  <!-- Nút quay lại trang admin -->
    </div>
    <div class="mb-5">
        <a href="processed-order" class="text-red-600">Xem đơn hàng đã xác nhận</a>
        <!-- Nút quay lại trang admin -->
    </div>
    <%-- Lấy danh sách đơn hàng từ thuộc tính yêu cầu --%>
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
    %>

    <%-- Nếu có đơn hàng --%>
    <%
        if (orders != null && !orders.isEmpty()) {
    %>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Mã đơn hàng</th>
            <th class="px-4 py-2">Tên khách hàng</th>
            <th class="px-4 py-2">Mã khách hàng</th>
            <th class="px-4 py-2">Hành động</th>
            <th class="px-4 py-2">Xác nhận</th> <!-- Cột xác nhận -->
        </tr>
        </thead>
        <tbody>

        <%
            for (Order order : orders) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %></td>
            <td class="px-4 py-2"><%= order.getUserName() %></td>
            <td class="px-4 py-2"><%= order.getUserId() %></td>
            <td class="px-4 py-2 action-cell">
                <a href="order-detail?orderId=<%= order.getOrderId() %>" class="text-blue-600">Xem</a> |
                <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-green-600">Sửa</a>
            </td>
            <td class="px-4 py-2">
                <%-- Nút xác nhận đơn hàng --%>
                <a href="confirmOrder?orderId=<%= order.getOrderId() %>" class="text-yellow-600">Xác nhận</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%-- Nếu không có đơn hàng --%>
    <%
    } else {
    %>
    <p class="text-center text-red-500">Không có đơn hàng nào.</p>
    <%
        }
    %>

</div>

</body>
</html>
