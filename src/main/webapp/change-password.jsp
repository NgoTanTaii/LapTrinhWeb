<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="css/change-password.css">

<style>
    /* Đặt kiểu nền và kiểu chữ cho toàn bộ trang */
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    /* Kiểu dáng cho container form */
    .form-container {
        background-color: #fff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        text-align: center;
    }

    /* Tiêu đề form */
    h2 {
        font-size: 24px;
        color: #333;
        margin-bottom: 20px;
    }

    /* Định dạng cho các trường input */
    input[type="password"] {
        width: 100%;
        padding: 12px;
        margin: 8px 0;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 16px;
    }

    /* Định dạng cho nút submit */
    button[type="submit"] {
        width: 100%;
        padding: 12px;
        background-color: red;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    /* Hiệu ứng hover cho nút submit */
    button[type="submit"]:hover {
        background-color: darkred;
    }

    /* Kiểu cho các thông báo lỗi và thành công */
    .error-message, .success-message {
        font-size: 14px;
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 4px;
        text-align: center;
    }

    .error-message {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .success-message {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    /* Liên kết quay lại */
    a {
        color: #007bff;
        text-decoration: none;
        font-size: 14px;
    }

    a:hover {
        text-decoration: underline;
    }

</style>
</head>
<body>
<div class="form-container">
    <h2>Đổi Mật Khẩu</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) request.getAttribute("successMessage");
        if (errorMessage != null) {
    %>
    <div class="error-message"><%= errorMessage %></div>
    <%
    } else if (successMessage != null) {
    %>
    <div class="success-message"><%= successMessage %></div>
    <%
        }
    %>

    <form action="change-password" method="post">
        <input type="password" name="oldPassword" placeholder="Mật khẩu cũ" required>
        <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
        <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu mới" required>
        <button style="margin-top: 20px" type="submit">Đổi Mật Khẩu</button>
    </form>
    <a href="account.jsp" style="display: block; text-align: center; margin-top: 10px;">Quay lại trang tài khoản</a>
</div>
</body>
</html>
