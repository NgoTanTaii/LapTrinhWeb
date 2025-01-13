<%@ page import="java.util.List" %>
<%@ page import="Entity.Appointment" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Lịch Hẹn</title>

    <!-- Thêm các thư viện để sử dụng DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
</head>
<body>

<h2>Danh sách Lịch Hẹn</h2>
<div class="back-link" style="margin-bottom: 20px">
    <a href="admin.jsp">Quay lại trang Quản trị</a>
</div>

<!-- Tạo form để gửi trạng thái "Đã Liên Lạc" -->
<form action="updateContactedStatus" method="post">
    <!-- Bảng hiển thị lịch hẹn với DataTables -->
    <table id="appointmentsTable" class="display">
        <thead>
        <tr>
            <th>ID</th>
            <%--            <th>Order ID</th>--%>
            <th>Địa Chỉ</th>
            <th>Số Điện Thoại</th>
            <th>Tên Tài Khoản</th>
            <th>Ngày Hẹn</th>
            <th>Giờ Hẹn</th>
            <th>Ngày Tạo</th>
            <th>Số Bất Động Sản</th>
            <th>Đã Liên Lạc</th>  <!-- Cột mới: Đã Liên Lạc -->
        </tr>
        </thead>
        <tbody>
        <!-- Lấy dữ liệu appointments từ request -->
        <%
            List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
            if (appointments != null) {
                for (Appointment appointment : appointments) {
        %>
        <tr>
            <td><%= appointment.getId() %>
            </td>
            <%--            <td><%= appointment.getOrderId() %></td>--%>
            <td><%= appointment.getAddress() %>
            </td>
            <td><%= appointment.getPhone() %>
            </td>
            <td><%= appointment.getUsername() %>
            </td>
            <td><%= appointment.getAppointmentDate() %>
            </td>
            <td><%= appointment.getAppointmentTime() %>
            </td>

            <td><%= appointment.getCreatedAt() %>
            </td>
            <td><%= appointment.getPropertyCount() %>
            </td>

            <!-- Cột checkbox Đã Liên Lạc -->
            <td>
                <input type="checkbox" name="contacted_<%= appointment.getId() %>" value="1"
                    <%= appointment.getContacted() == 1 ? "checked" : "" %>
                >
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="10">Không có lịch hẹn nào.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Nút để submit form -->
    <button type="submit">Cập nhật Đã Liên Lạc</button>
</form>

<!-- Thêm thư viện DataTables -->
<script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" charset="utf8"
        src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        $('#appointmentsTable').DataTable(); // Kích hoạt DataTables trên bảng
    });
</script>

</body>
</html>
