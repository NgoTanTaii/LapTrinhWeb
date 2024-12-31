<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên Hệ Tư Vấn Viên</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }

        /* Header */
        header {
            text-align: center;
            margin-bottom: 30px;
        }

        header h1 {
            font-size: 36px;
            color: #3498db;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); /* Background tối */
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 40px;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        /* Close Button */
        .close {
            color: #aaa;
            font-size: 30px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 15px;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #333;
        }

        /* Modal Title */
        .modal-content h2 {
            text-align: center;
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        /* Form Inputs */
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        input[type="text"]:focus, input[type="email"]:focus, textarea:focus {
            border-color: #3498db;
            outline: none;
        }

        /* Submit Button */
        button[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: #2980b9;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: white;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        footer p {
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .modal-content {
                padding: 20px;
                width: 90%;
            }
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
        <h2>Liên Hệ với Tư Vấn Viên</h2>
        <form method="POST">
            <label for="name">Họ Tên:</label>
            <input type="text" id="name" name="name" required><br><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>
            <label for="message">Nội Dung:</label><br>
            <textarea id="message" name="message" rows="4" required></textarea><br><br>
            <button type="submit" class="contact-button">Gửi</button>
        </form>
    </div>
</div>

<!-- Footer -->
<footer>
    <p>&copy; 2024 Tư Vấn BĐS | Liên hệ: info@bds.com</p>
</footer>

<script>
    // Mở modal
    function openModal() {
        document.getElementById("contactModal").style.display = "block";
    }

    // Đóng modal
    function closeModal() {
        document.getElementById("contactModal").style.display = "none";
    }

    // Đảm bảo rằng người dùng có thể đóng modal khi bấm ra ngoài
    window.onclick = function(event) {
        if (event.target == document.getElementById("contactModal")) {
            closeModal();
        }
    }
</script>

</body>
</html>
