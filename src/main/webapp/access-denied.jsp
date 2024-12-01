<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>404 - Trang không tồn tại</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f8f8f8;
            color: #333;
            text-align: center;
        }

        .error-container {
            max-width: 600px;
            width: 100%;
            padding: 40px;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            transition: transform 0.3s ease-in-out;
        }

        .error-container:hover {
            transform: scale(1.05);
        }

        .error-code {
            font-size: 96px;
            font-weight: bold;
            color: #FF6347;
            margin-bottom: 10px;
        }

        .error-message {
            font-size: 24px;
            margin: 10px 0;
            font-weight: 600;
        }

        .error-description {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }

        .back-home {
            display: inline-block;
            padding: 12px 24px;
            font-size: 16px;
            color: white;
            background-color: #4CAF50;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .back-home:hover {
            background-color: #45a049;
        }

        .alert-box {
            margin-top: 20px;
            padding: 15px;
            background-color: #ffeb3b;
            color: #333;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-code">404</div>
    <div class="error-message">Trang không tồn tại</div>
    <div class="error-description">
        Xin lỗi, trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.
    </div>
    <a href="welcome" class="back-home">Quay lại trang chủ</a>
    <div class="alert-box" id="alert-box">
        <p>Hãy chắc chắn rằng URL bạn nhập là chính xác, hoặc thử tìm lại bằng cách quay lại trang chủ.</p>
    </div>
</div>

<script>
    // Hiển thị thông báo cảnh báo
    window.onload = function() {
        setTimeout(function() {
            var alertBox = document.getElementById('alert-box');
            alertBox.style.display = 'none';
        }, 8000);  // Ẩn cảnh báo sau 8 giây
    };
</script>
</body>
</html>
