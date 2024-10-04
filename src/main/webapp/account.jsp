<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tài khoản của tôi</title>
<link rel="stylesheet" href="css/style.css">

<head>
    <style>

        body {
            font-family: Arial, sans-serif; /* Chọn phông chữ cho trang */
            display: flex; /* Sử dụng flexbox để căn giữa */
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
            height: 100vh; /* Chiều cao toàn bộ viewport */
            margin: 0; /* Loại bỏ margin mặc định */
            text-align: center; /* Căn giữa nội dung văn bản */
        }

        .account-options {
            display: flex; /* Sử dụng flexbox để sắp xếp các nút */
            flex-direction: column; /* Sắp xếp theo cột */
            gap: 20px; /* Khoảng cách giữa các nút */
        }

        .btn {
            background-color: #007bff; /* Màu nền nút */
            color: white; /* Màu chữ nút */
            padding: 10px 20px; /* Khoảng cách bên trong nút */
            border: none; /* Loại bỏ viền */
            border-radius: 5px; /* Bo tròn các góc */
            cursor: pointer; /* Hiển thị con trỏ khi hover */
            text-decoration: none; /* Không gạch chân */
            font-size: 18px; /* Kích thước chữ */
        }

        .btn:hover {
            background-color: #0056b3; /* Màu nền khi hover */
        }
    </style>
</head>


<body>

<div class="account-options">
    <a href="change-password" class="btn">Đổi mật khẩu</a>
   
    <a href="update-address.jsp" class="btn">Cập nhật địa chỉ</a>
    <a href="welcome" class="btn">Quay trở lại trang chính</a> <!-- Nút quay lại trang chính -->
    <a href="login.jsp" class="btn">Đăng xuất</a>

</div>

</body>
</html>
