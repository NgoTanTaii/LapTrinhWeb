<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="css/change-password.css">


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
        <button type="submit">Đổi Mật Khẩu</button>
    </form>
    <a href="account.jsp" style="display: block; text-align: center; margin-top: 10px;">Quay lại trang tài khoản</a>
</div>
</body>
</html>
