<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Entity.Order" %>
<%@ page import="Entity.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="Dao.OrderUserDao" %>

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

    <%-- Kiểm tra quyền người dùng và đăng nhập --%>
    <%
        String role = (String) session.getAttribute("role");  // Lấy quyền người dùng từ session (ví dụ: "admin" hoặc "user")
        Integer loggedInUserId = (Integer) session.getAttribute("userId");  // Lấy userId từ session nếu người dùng đã đăng nhập

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (loggedInUserId == null) {
            response.sendRedirect("login.jsp");  // Nếu chưa đăng nhập, chuyển đến trang đăng nhập
            return;
        }

        // Lấy orderId từ URL
        String orderIdParam = request.getParameter("orderId");
        int orderId = 0;
        try {
            orderId = Integer.parseInt(orderIdParam);  // Lấy orderId từ URL nếu có
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?errorMessage=Lỗi mã đơn hàng.");  // Nếu không hợp lệ, chuyển đến trang lỗi
            return;
        }

        // Khai báo đối tượng Order và danh sách OrderItem
        Order order = null;
        List<OrderItem> orderItems = null;

        // Chỉ admin mới có thể chỉnh sửa URL, người dùng bình thường chỉ có thể xem đơn hàng của chính mình
        if (role != null && (role.equals("admin") || loggedInUserId != null)) {
            OrderUserDao orderUserDao = new OrderUserDao();
            order = orderUserDao.getOrderById(orderId);  // Lấy đơn hàng theo orderId
            orderItems = orderUserDao.getOrderItemsByOrderId(orderId);  // Lấy các mục trong đơn hàng
        }

        // Nếu không tìm thấy đơn hàng, chuyển đến trang lỗi
        if (order == null) {
            response.sendRedirect("error.jsp?errorMessage=Đơn hàng không tồn tại.");  // Nếu không tìm thấy đơn hàng
            return;
        }

        // Chỉ admin hoặc chủ đơn hàng mới có thể xem chi tiết đơn hàng này
        if (!(role.equals("admin") || loggedInUserId.equals(order.getUserId()))) {
            response.sendRedirect("access-denied.jsp");  // Nếu không có quyền truy cập
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
            <th class="px-4 py-2">Tên bất động sản</th>
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
        <%-- Chỉ admin mới có thể sửa đơn hàng --%>
        <% if (role.equals("admin") || loggedInUserId.equals(order.getUserId())) { %>
        <a href="updateOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-green-600">Cập nhật đơn hàng</a>
        <% } %>
    </div>
</div>
</body>
</html>
