<%@ page import="Entity.Order" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Order Management</h1>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Order ID</th>
            <th class="px-4 py-2">Customer</th>
            <th class="px-4 py-2">Property</th>
            <th class="px-4 py-2">Price</th>
            <th class="px-4 py-2">Area</th>
            <th class="px-4 py-2">Address</th>
            <th class="px-4 py-2">Order Date</th>
            <th class="px-4 py-2">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Retrieve the list of orders from the request attribute
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null) {
                for (Order order : orders) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %></td>
            <td class="px-4 py-2"><%= order.getUserId() %></td>
            <td class="px-4 py-2"><%= order.getPropertyId() %></td>
            <td class="px-4 py-2"><%= order.getPrice() %></td>
            <td class="px-4 py-2"><%= order.getArea() %></td>
            <td class="px-4 py-2"><%= order.getAddress() %></td>
            <td class="px-4 py-2"><%= order.getOrderDate() %></td>
            <td class="px-4 py-2">
                <a href="order-detail.jsp?orderId=<%= order.getOrderId() %>" class="text-blue-600">View</a> |
                <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-green-600">Edit</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="8" class="text-center px-4 py-2">No orders found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
