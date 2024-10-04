<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="login-form-container">
    <div class="login-form">

        <h2>Đăng nhập</h2>

        <!-- Form xử lý đăng nhập -->
        <form action="login" method="post">
            <label for="username">Tên đăng nhập:</label>
            <!-- Hiển thị lại giá trị username nếu có lỗi -->
            <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="btn submit-btn">Đăng nhập</button>
        </form>

        <!-- Thông báo lỗi nếu có -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p style="color: red; text-align: center;"><%= errorMessage %></p>
        <%
            }
        %>

        <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
        <p>Quên mật khẩu? <a href="forgot-password.jsp">Lấy lại mật khẩu</a></p>
    </div>
</div>

</body>
</html>
