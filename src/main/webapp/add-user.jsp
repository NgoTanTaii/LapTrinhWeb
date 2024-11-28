<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Người Dùng Mới</title>
    <style>
        .message {
            font-weight: bold;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .error {
            color: red;
            background-color: #f8d7da;
            border: 1px solid red;
        }
        .success {
            color: green;
            background-color: #d4edda;
            border: 1px solid green;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Thêm Người Dùng Mới</h2>

    <!-- Display error or success messages -->
    <div>
        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");

            if (error != null) {
                out.print("<div class='message error'>");
                if ("UserAlreadyExists".equals(error)) {
                    out.print("Người dùng đã tồn tại!");
                } else if ("Username cannot be null".equals(error)) {
                    out.print("Tên người dùng không được để trống!");
                } else if ("ErrorAddingUser".equals(error)) {
                    out.print("Có lỗi khi thêm người dùng. Vui lòng thử lại.");
                }
                out.print("</div>");
            }

            if (success != null && "UserAddedSuccessfully".equals(success)) {
                out.print("<div class='message success'>Người dùng đã được thêm thành công!</div>");
            }
        %>
    </div>

    <!-- User form -->
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
