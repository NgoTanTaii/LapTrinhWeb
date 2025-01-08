<%@ page import="Controller.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Người Dùng Mới</title>
    <style>

        /* Các kiểu CSS cho form */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 20px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #45a049;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
        .back-link a:hover {
             text-decoration: underline;

        }

        /* Thêm kiểu cho các thông báo */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Thêm Người Dùng Mới</h2>

    <!-- Thông báo lỗi hoặc thành công nếu có -->
    <%
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");

        if (error != null) {
    %>
    <div class="alert alert-danger"><%= error %></div>
    <%
    } else if (success != null) {
    %>
    <div class="alert alert-success"><%= success %></div>
    <%
        }
    %>

    <form action="addUser" method="POST">
        <input type="hidden" name="action" value="create">

        <label for="username">Tên Người Dùng:</label>
        <input type="text" id="username" name="username" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Mật Khẩu:</label>
        <input type="password" id="password" name="password" required>

        <label for="role">Vai Trò:</label>
        <select name="role" id="role">
            <option value="user">Người Dùng</option>
            <option value="admin">Quản Trị</option>
        </select>

        <label for="status">Trạng Thái:</label>
        <select name="status" id="status">
            <option value="active">Hoạt Động</option>
            <option value="inactive">Không Hoạt Động</option>
        </select>

        <button type="submit" class="submit-button">Thêm Người Dùng</button>
    </form>

    <div class="back-link">
        <a href="users">Quay lại trang Quản trị</a>
    </div>
</div>

</body>
</html>
