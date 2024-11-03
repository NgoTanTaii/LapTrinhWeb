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
        }

        .error-container {
            text-align: center;
        }

        .error-code {
            font-size: 96px;
            font-weight: bold;
            color: #FF6347;
        }

        .error-message {
            font-size: 24px;
            margin: 10px 0;
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
</div>
</body>
</html>
