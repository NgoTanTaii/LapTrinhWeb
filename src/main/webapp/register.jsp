<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="css/register.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; /* Màu nền */
            color: #333; /* Màu chữ */
        }

        .register-form-container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background-color: white; /* Nền trắng cho form */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .register-form h2 {
            text-align: center;
            margin-bottom: 20px;

        }

        .register-form label {
            margin-bottom: 5px;
            color: #555; /* Màu chữ cho nhãn */
        }

        .register-form input {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 280px;
        }

        .btn.submit-btn {
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            background-color: #ff5722; /* Màu nền nút */
            color: white; /* Màu chữ nút */
            border: none; /* Không viền */
            width: 100%; /* Nút rộng 100% */
        }

        .btn.submit-btn:hover {
            background-color: #e64a19; /* Màu nút khi hover */
        }

        p {
            text-align: center;
            margin-top: 15px;
        }


        a:hover {
            text-decoration: underline; /* Gạch chân khi hover */
        }
    </style>
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
