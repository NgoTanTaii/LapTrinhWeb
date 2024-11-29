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

    <%-- Lấy danh sách đơn hàng từ thuộc tính yêu cầu --%>
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
    %>

    <%-- Nếu có đơn hàng --%>
    <%
        if (orders != null && !orders.isEmpty()) {
            for (Order order : orders) {
    %>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Mã đơn hàng</th>
            <th class="px-4 py-2">Khách hàng</th>
            <th class="px-4 py-2">Hành động</th>
        </tr>
        </thead>
        <tbody>

        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %></td>
            <td class="px-4 py-2"><%= order.getUserId() %></td>
            <td class="px-4 py-2">
                <a href="order-detail?orderId=<%= order.getOrderId() %>" class="text-blue-600">Xem</a> |
                <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-green-600">Sửa</a>
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
