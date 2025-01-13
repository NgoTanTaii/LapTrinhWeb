<%@ page import="Entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>Đơn hàng đã xử lý</title>

    <!-- Thêm CSS của DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">

    <!-- Thêm jQuery (DataTables phụ thuộc vào jQuery) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Thêm JavaScript của DataTables -->
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
</head>
<body>

<h1>Đơn hàng đã xử lý</h1>

<%
    // Lấy dữ liệu từ request
    List<Order> processedOrders = (List<Order>) request.getAttribute("processedOrders");

    // Kiểm tra xem có đơn hàng nào không
    if (processedOrders != null && !processedOrders.isEmpty()) {
%>

<!-- Bảng dữ liệu, thêm class 'dataTable' cho DataTables -->
<table id="ordersTable" class="display dataTable" border="1">
    <thead>
    <tr>
        <th>Mã đơn hàng</th>
        <th>Mã người dùng</th>
        <th>Ngày đặt hàng</th>
        <th>Tên người dùng</th>
<%--        <th>Trạng thái</th>--%>
    </tr>
    </thead>
    <tbody>
    <%
        // Duyệt qua danh sách đơn hàng
        for (Order order : processedOrders) {
    %>
    <tr>
        <td><%= order.getOrderId() %></td>
        <td><%= order.getUserId() %></td>
        <td><%= order.getOrderDate() %></td>
        <td><%= order.getUserName() %></td>
<%--        <td><%= order.getStatus() %></td>--%>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<%
} else {
%>
<p>Không có đơn hàng đã xử lý.</p>
<%
    }
%>

<script>
    // Khởi tạo DataTable cho bảng có id 'ordersTable'
    $(document).ready(function() {
        $('#ordersTable').DataTable();
    });
</script>

</body>
</html>
