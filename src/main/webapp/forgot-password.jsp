<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lấy lại mật khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4; /* Màu nền trang */
            color: #333; /* Màu chữ */
        }

        .forgot-container {
            max-width: 450px;
            margin: auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            width: 55%; /* Đặt chiều rộng cho form nhỏ */
            border: 2px solid #ccc; /* Đường viền lớn hơn */
            padding: 30px;
            border-radius: 8px;
            background-color: white; /* Nền trắng cho form */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin: auto; /* Căn giữa form nhỏ */
        }

        h2 {
            margin-bottom: 20px;
            text-align: center; /* Canh giữa tiêu đề */
        }

        input[type="text"], input[type="email"] {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="submit"] {

            background-color: red;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s; /* Hiệu ứng chuyển màu */
            width: 100%; /* Nút rộng 95% */
            margin: 15px auto 0; /* Căn giữa nút và khoảng cách bên trên */
            display: block; /* Để căn giữa */
        }

        input[type="submit"]:hover {
            background-color: #e64a19; /* Màu khi hover */
        }

        .error-message {
            color: red; /* Màu chữ thông báo lỗi */
            margin-top: 10px;
            text-align: center; /* Canh giữa thông báo lỗi */
        }

        .login-link {
            text-align: center; /* Canh giữa link */
            margin-top: 15px; /* Khoảng cách trên */
        }
    </style>

</head>
<body>
<div class="forgot-container">
    <div class="form-container">
        <h2>Lấy lại mật khẩu</h2>
        <form action="ForgotPasswordServlet" method="post">
            <input type="text" name="username" placeholder="Nhập tên tài khoản" required>
            <input type="email" name="email" placeholder="Nhập email của bạn" required>
            <input type="submit" value="Gửi yêu cầu">
        </form>
        <!-- Thông báo lỗi nếu có -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p class="error-message"><%= errorMessage %>
        </p>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
