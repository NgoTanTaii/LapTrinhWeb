<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="css/register.css">
</head>
<body>

<div class="register-form-container">
    <div class="register-form">

        <h2>Đăng ký</h2>

        <form action="register" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="btn submit-btn">Đăng ký</button>
        </form>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p style="color: red; text-align: center;"><%= errorMessage %></p>
        <%
            }
        %>

        <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
    </div>
</div>

</body>
</html>
