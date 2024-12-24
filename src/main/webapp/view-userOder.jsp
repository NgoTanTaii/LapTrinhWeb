<%@ page import="Dao.OrderUserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Order" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Quản lý Đơn hàng</h1>

    <%-- Kiểm tra quyền người dùng --%>
    <%
        // Lấy thông tin phân quyền từ session
        String role = (String) session.getAttribute("role");  // Giả sử 'role' chứa thông tin về quyền người dùng
        int loggedInUserId = (Integer) session.getAttribute("userId");  // Lấy userId từ session

        // Nếu người dùng không phải là admin và đang truy cập dữ liệu của người khác
        String userIdParam = request.getParameter("userId");
        int userId = 0;

        // Lấy userId từ URL
        if (userIdParam != null && !userIdParam.isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam);  // Chuyển tham số thành int
            } catch (NumberFormatException e) {
                // Nếu không thể chuyển sang int, sử dụng giá trị mặc định là 0
                userId = 0;
            }
        }

        // Nếu người dùng không phải là admin và cố gắng truy cập userId khác với userId của chính họ
        if (role == null || (!role.equals("admin") && loggedInUserId != userId)) {
            response.sendRedirect("access-denied.jsp");  // Chuyển hướng đến trang access-denied.jsp
            return;  // Dừng việc xử lý tiếp theo
        }
    %>

    <%-- Nút quay lại trang admin --%>
    <div class="mb-5">
        <a href="admin.jsp" class="text-blue-600">Quay lại trang quản trị</a>
    </div>

    <%-- Truy vấn và lấy danh sách đơn hàng từ DAO --%>
    <%
        // Truy vấn danh sách đơn hàng
        OrderUserDao orderUserDao = new OrderUserDao();
        List<Order> orders = orderUserDao.getOrdersByUserId(userId);  // Lấy danh sách đơn hàng theo userId

        if (orders != null && !orders.isEmpty()) {
    %>

    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Mã đơn hàng</th>
            <th class="px-4 py-2">Tên khách hàng</th>
            <th class="px-4 py-2">Mã khách hàng</th>
            <th class="px-4 py-2">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%-- Hiển thị từng đơn hàng --%>
        <%
            for (Order order : orders) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %></td>
            <td class="px-4 py-2"><%= order.getUserName() %></td>
            <td class="px-4 py-2"><%= order.getUserId() %></td>
            <td class="px-4 py-2">
                <a href="order-detail?orderId=<%= order.getOrderId() %>" class="text-blue-600">Xem</a>
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
    <p class="text-center text-red-500">Không có đơn hàng nào cho người dùng này.</p>
    <%
        }
    %>

</div>

</body>
</html>
