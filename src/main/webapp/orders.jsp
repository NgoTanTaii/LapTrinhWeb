<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <th class="px-4 py-2">Total Price</th>
            <th class="px-4 py-2">Status</th>
            <th class="px-4 py-2">Created At</th>
            <th class="px-4 py-2">Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- MOCK DATA -->
        <tr class="border-t">
            <td class="px-4 py-2">101</td>
            <td class="px-4 py-2">John Doe</td>
            <td class="px-4 py-2">$250,000</td>
            <td class="px-4 py-2">
                <span class="px-2 py-1 rounded-full text-white bg-yellow-500">Pending</span>
            </td>
            <td class="px-4 py-2">2024-11-18</td>
            <td class="px-4 py-2">
                <a href="order-detail.jsp" class="text-blue-600">View</a> |
                <a href="#" class="text-green-600">Edit</a>
            </td>
        </tr>
        <tr class="border-t">
            <td class="px-4 py-2">102</td>
            <td class="px-4 py-2">Jane Smith</td>
            <td class="px-4 py-2">$320,000</td>
            <td class="px-4 py-2">
                <span class="px-2 py-1 rounded-full text-white bg-blue-500">Confirmed</span>
            </td>
            <td class="px-4 py-2">2024-11-17</td>
            <td class="px-4 py-2">
                <a href="#" class="text-blue-600">View</a> |
                <a href="#" class="text-green-600">Edit</a>
            </td>
        </tr>
        <tr class="border-t">
            <td class="px-4 py-2">103</td>
            <td class="px-4 py-2">Alice Johnson</td>
            <td class="px-4 py-2">$180,000</td>
            <td class="px-4 py-2">
                <span class="px-2 py-1 rounded-full text-white bg-green-500">Completed</span>
            </td>
            <td class="px-4 py-2">2024-11-16</td>
            <td class="px-4 py-2">
                <a href="#" class="text-blue-600">View</a> |
                <a href="#" class="text-green-600">Edit</a>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
