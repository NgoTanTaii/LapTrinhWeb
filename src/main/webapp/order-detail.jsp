<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <!-- Header Section -->
    <h1 class="text-2xl font-bold mb-5">Order Details - Order ID: 12345</h1>

    <!-- Order Information -->
    <div class="bg-white p-5 shadow-md rounded mb-5">
        <p><strong>Customer:</strong> John Doe</p>
        <p><strong>Total Price:</strong> $500.00</p>
        <p><strong>Status:</strong>
            <span class="px-2 py-1 rounded-full text-white bg-blue-500">Confirmed</span>
        </p>
        <p><strong>Created At:</strong> 2024-11-18</p>
    </div>

    <!-- Order Items -->
    <h3 class="text-xl font-bold mb-3">Order Items</h3>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Property</th>
            <th class="px-4 py-2">Price</th>
            <th class="px-4 py-2">Quantity</th>
            <th class="px-4 py-2">Total</th>
        </tr>
        </thead>
        <tbody>
        <!-- Item 1 -->
        <tr class="border-t">
            <td class="px-4 py-2">Modern Apartment</td>
            <td class="px-4 py-2">$200.00</td>
            <td class="px-4 py-2">2</td>
            <td class="px-4 py-2">$400.00</td>
        </tr>
        <!-- Item 2 -->
        <tr class="border-t">
            <td class="px-4 py-2">Luxury Villa</td>
            <td class="px-4 py-2">$100.00</td>
            <td class="px-4 py-2">1</td>
            <td class="px-4 py-2">$100.00</td>
        </tr>
        </tbody>
    </table>

    <!-- Action Buttons -->
    <div class="mt-5">
        <a href="orders.jsp" class="text-blue-600">Back to Orders List</a> |
        <a href="updateOrder.jsp?orderId=12345" class="text-green-600">Update Order</a>
    </div>
</div>
</body>
</html>
