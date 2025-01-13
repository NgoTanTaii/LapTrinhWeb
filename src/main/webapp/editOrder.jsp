<%@ page import="Entity.Order" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBcontext.Database" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">

    <%-- Lấy thông tin đơn hàng từ database theo orderId --%>
    <%
        // Lấy orderId từ tham số trên URL
        String orderIdStr = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdStr);
        // Kết nối cơ sở dữ liệu để lấy thông tin đơn hàng
        Order order = null;
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT order_id, user_id, order_date,username FROM orders WHERE order_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, orderId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int userId = rs.getInt("user_id");
                        String username = rs.getString("username");

                        Date orderDate = rs.getDate("order_date");
                        order = new Order(orderId, orderDate, username, userId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (order == null) {
    %>
    <p class="text-red-500">Đơn hàng không tồn tại.</p>
    <a href="orders" class="text-blue-600">Quay lại danh sách đơn hàng</a>
    <%
            return;
        }
    %>

    <h1 class="text-2xl font-bold mb-5">Chỉnh sửa Đơn hàng - Mã đơn hàng: <%= order.getOrderId() %> -Tên khách
        hàng: <%= order.getUserName() %>
    </h1>

    <%-- Form chỉnh sửa đơn hàng --%>
    <form action="updateOrder" method="post" class="bg-white p-5 shadow-md rounded">
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

        <div class="mb-4">
            <label for="userId" class="block font-semibold">Mã khách hàng</label>
            <input type="text" id="userId" name="userId" value="<%= order.getUserId() %>"
                   class="border px-4 py-2 rounded w-full" required>
        </div>

        <div class="mb-4">
            <label for="orderDate" class="block font-semibold">Ngày đặt hàng</label>
            <input type="date" id="orderDate" name="orderDate"
                   value="<%= order.getOrderDate().toString().substring(0, 10) %>"
                   class="border px-4 py-2 rounded w-full" required>
        </div>

        <div class="mb-4">
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">Cập nhật đơn hàng</button>
        </div>

        <div class="mb-4">
            <a href="orders" class="text-blue-600">Quay lại danh sách đơn hàng</a>
        </div>
    </form>
</div>
</body>
</html>
