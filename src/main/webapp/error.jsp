<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - Hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">

<div class="container mx-auto">
    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
        <h2 class="font-bold text-xl">Lỗi Xảy Ra!</h2>
        <p>
            <%-- Kiểm tra có thông báo lỗi nào được truyền vào không --%>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage == null) {
                    errorMessage = "Có một sự cố xảy ra. Vui lòng thử lại sau.";
                }
            %>
            <%= errorMessage %>
        </p>
    </div>

    <div class="flex justify-center">
        <a href="index.jsp" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Quay lại Trang Chủ</a>
    </div>

</div>

</body>
</html>
