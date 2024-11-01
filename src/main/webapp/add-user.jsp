<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Người Dùng Mới</title>
    <style>
        /* CSS styles as previously defined */
    </style>
</head>
<body>

<div class="container">
    <h2>Thêm Người Dùng Mới</h2>


    <form action="AddUserServlet" method="POST">
        <input type="hidden" name="action" value="create">
        <label for="username">Tên Người Dùng:</label>
        <input type="text" id="username" name="username" required>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="password">Mật Khẩu:</label>
        <input type="password" id="password" name="password" required>
        <label for="role">Vai Trò:</label>
        <select id="role" name="role" required>
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select>
        <label for="status">Trạng Thái:</label>
        <select id="status" name="status" required>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
        </select>
        <button type="submit">Thêm Người Dùng</button>
    </form>

    <a href="users" class="cancel-link">Hủy</a>
</div>

</body>
</html>
