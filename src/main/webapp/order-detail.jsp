<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Entity.Order" %>
<%@ page import="Entity.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

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

    <h1 class="text-2xl font-bold mb-5">Chi tiết Đơn hàng - Mã đơn hàng: <%= request.getAttribute("order") != null ? ((Order) request.getAttribute("order")).getOrderId() : "N/A" %> </h1>

    <%-- Display Order Info --%>
    <div class="bg-white p-5 shadow-md rounded mb-5">
        <p><strong>Mã khách hàng:</strong> <%= request.getAttribute("order") != null ? ((Order) request.getAttribute("order")).getUserId() : "N/A" %></p>
        <p><strong>Ngày đặt hàng:</strong> <%= request.getAttribute("order") != null ? ((Order) request.getAttribute("order")).getOrderDate() : "N/A" %></p>
    </div>

    <%-- Display Order Items --%>
    <h3 class="text-xl font-bold mb-3">Chi tiết các mục trong đơn hàng</h3>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Tên bất động sản</th>
            <th class="px-4 py-2">Giá</th>
            <th class="px-4 py-2">Số lượng</th>
            <th class="px-4 py-2">Trạng thái</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Get the orderItems list passed from the servlet
            List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
            DecimalFormat df = new DecimalFormat("#,###.00");  // Formatting for price
            if (orderItems != null && !orderItems.isEmpty()) {
                for (OrderItem item : orderItems) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= item.getTitle() %></td>
            <td class="px-4 py-2"><%= df.format(item.getPrice()) %> tỷ</td>
            <td class="px-4 py-2"><%= item.getQuantity() %></td>
            <td class="px-4 py-2">
                <%
                    String status = item.getStatus();
                    if ("pending".equals(status)) {
                        out.print("Đang chờ");
                    } else if ("processed".equals(status)) {
                        out.print("Đã xác nhận");
                    } else if ("cancel".equals(status)) {
                        out.print("Hủy");
                    } else {
                        out.print("Chưa xác định");
                    }
                %>
            </td>
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

    <%-- Button to go back to orders list --%>
    <div class="mt-5">
        <a href="orders" class="text-blue-600">Quay lại danh sách đơn hàng</a>
    </div>

</div>
</body>
</html>
