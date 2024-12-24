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
            background-color: #f2f2f2; /* Màu nền nhẹ nhàng */
            color: #333; /* Màu chữ tối */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Chiếm hết chiều cao màn hình */
        }

        .register-form-container {
            max-width: 500px;
            margin: auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: gainsboro;
        }

        .register-form {
            display: flex;
            flex-direction: column;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            width: 80%;
            margin: auto;
        }

        .register-form h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: #444; /* Màu chữ cho tiêu đề */
        }

        .register-form label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #555; /* Màu chữ nhãn */
        }

        .register-form input {
            width: 90%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            background-color: #f9f9f9;
            transition: border-color 0.3s ease;
        }

        .register-form input:focus {
            border-color: #ff5722; /* Đổi màu viền khi focus */
            outline: none;
        }

        .btn.submit-btn {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn.submit-btn:hover {
            background-color: #e64a19; /* Màu nền khi hover */
        }

        p {

            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            color: #666;
        }

        p a {
            color: red;
            text-decoration: none;
            font-weight: bold;
        }

        p a:hover {
            text-decoration: underline; /* Gạch chân khi hover */
        }

        /* Thông báo lỗi */
        .error-message {
            color: red;
            text-align: center;
            font-size: 14px;
            margin-top: 15px;
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
        <p class="error-message"><%= errorMessage %>
        </p>
        <%
            }
        %>

        <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
    </div>
</div>

</body>
</html>
