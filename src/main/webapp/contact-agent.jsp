<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/contact-agent.css"/>

    <title>Liên Hệ Tư Vấn Viên</title>
    <style>
        /* Style chung cho form */
        form {
            display: flex;
            flex-direction: column;
            gap: 5px; /* Giảm khoảng cách giữa các trường */
            padding: 15px;
            max-width: 400px;
            margin: 0 auto;
        }

        /* Style cho label */
        form label {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-bottom: 3px; /* Giảm khoảng cách giữa label và input */
        }

        /* Style cho input và textarea */
        form input,
        form textarea {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%; /* Chiếm đầy chiều rộng của form */
            box-sizing: border-box; /* Đảm bảo padding không ảnh hưởng đến chiều rộng */
        }

        /* Style riêng cho textarea (có chiều cao lớn hơn input) */
        form textarea {
            resize: vertical;
            min-height: 80px; /* Đặt chiều cao tối thiểu cho textarea */
        }

        /* Style cho nút Gửi */
        .contact-button {
            padding: 10px;
            font-size: 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        /* Hiệu ứng khi hover vào nút Gửi */
        .contact-button:hover {
            background-color: #2980b9;
        }

        /* Hiệu ứng focus cho các trường nhập liệu */
        form input:focus,
        form textarea:focus {
            border-color: #3498db;
            outline: none;
        }

        /* Đóng modal */
        .close {
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 10px;
            right: 20px;
            color: #aaa;
        }

        .close:hover {
            color: #000;
        }

        /* Hiệu ứng khi mở modal */
        .modal-content {
            padding: 10px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
        }

    </style>
</head>
<body>

<!-- Header -->
<header>
    <h1>Liên Hệ với Tư Vấn Viên</h1>
</header>

<!-- Mở Modal -->
<button onclick="openModal()">Liên Hệ Tư Vấn Viên</button>

<!-- Modal Liên Hệ -->
<div id="contactModal" class="modal">
    <div class="modal-content">

        <span class="close" onclick="closeModal()">&times;</span>
        <h2> Để lại thông tin cá nhân</h2>
        <form method="POST">
            <label for="name">Họ Tên:</label>
            <input type="text" id="name" name="name" required><br><br>

            <label for="phone">Số Điện Thoại:</label>
            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required><br><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>

            <label for="message">Nội Dung:</label><br>
            <textarea id="message" name="message" rows="4" required></textarea><br><br>

            <button type="submit" class="contact-button">Gửi</button>
        </form>
    </div>
</div>
<script src="JS/contact-agent.js" defer></script>

<footer>
    <p>&copy; 2024 Tư Vấn BĐS | Liên hệ: info@bds.com</p>
</footer>
<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    footer {
        margin-top: auto; /* Đẩy footer xuống dưới cùng */
        background-color: #333;

        text-align: center;
        padding: 10px;
    }

</style>
</body>
</html>
