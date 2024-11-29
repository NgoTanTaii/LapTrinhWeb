<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Entity.Order" %>
<%@ page import="Entity.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>  <!-- Import DecimalFormat để định dạng tiền tệ -->

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">

    <%
        String role = (String) session.getAttribute("role");  // Lấy thông tin phân quyền từ session (ví dụ: "admin" hoặc "user")

        if (role == null || !role.equals("admin")) {  // Nếu không phải admin
            response.sendRedirect("access-denied.jsp");  // Chuyển hướng đến trang access-denied.jsp
            return;
        }
    %>
    <%-- Lấy đối tượng đơn hàng và danh sách mục đơn hàng từ request --%>
    <%
        Order order = (Order) request.getAttribute("order");
        List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");

        if (order == null) {
    %>
    <p class="text-red-500">Đơn hàng không tồn tại.</p>
    <%
            return;
        }
    %>

    <%-- Hiển thị thông tin đơn hàng --%>
    <h1 class="text-2xl font-bold mb-5">Chi tiết Đơn hàng - Mã đơn hàng: <%= order.getOrderId() %></h1>

    <div class="bg-white p-5 shadow-md rounded mb-5">
        <p><strong>Mã khách hàng:</strong> <%= order.getUserId() %></p>
        <p><strong>Ngày đặt hàng:</strong> <%= order.getOrderDate() %></p>
    </div>

    <%-- Hiển thị các mục trong đơn hàng --%>
    <h3 class="text-xl font-bold mb-3">Chi tiết các mục trong đơn hàng</h3>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Mã đơn hàng</th>
            <th class="px-4 py-2">Tên bất động sản </th>
            <th class="px-4 py-2">Giá</th>
            <th class="px-4 py-2">Số lượng</th>
        </tr>
        </thead>
        <tbody>
        <%
            DecimalFormat df = new DecimalFormat("#,###.00");  // Khởi tạo DecimalFormat để định dạng tiền tệ
            if (orderItems != null && !orderItems.isEmpty()) {
                for (OrderItem item : orderItems) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= item.getPropertyId() %></td>
            <td class="px-4 py-2"><%= item.getTitle() %></td>
            <td class="px-4 py-2"><%= df.format(item.getPrice()) %> tỷ</td>  <!-- Định dạng giá -->
            <td class="px-4 py-2"><%= item.getQuantity() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" class="text-center px-4 py-2">Không có mục nào trong đơn hàng này.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <%-- Các nút hành động để quay lại danh sách đơn hàng hoặc cập nhật đơn hàng --%>
    <div class="mt-5">
        <a href="orders" class="text-blue-600">Quay lại danh sách đơn hàng</a> |
        <a href="updateOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-green-600">Cập nhật đơn hàng</a>
    </div>
</div>
</body>
</html>
