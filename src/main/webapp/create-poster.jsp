<%
    Integer userId = (Integer) request.getSession().getAttribute("userId");
    if (userId == null) {
        // Nếu chưa đăng nhập, chuyển hướng đến trang login
        response.sendRedirect("login.jsp?redirect=createPoster.jsp");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo bài đăng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="email"],
        input[type="file"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-align: center;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
        }

        .file-upload {
            position: relative;
            overflow: hidden;
        }

        input[type="file"] {
            cursor: pointer;
        }

        .preview-container {
            margin-top: 20px;
            text-align: center;
        }

        .preview-container img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 8px;
            margin-top: 10px;
        }

        .delete-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>

<div class="container">
    <h2> Thông tin người đăng</h2>
    <form action="createPoster" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label for="name">Tên người đăng:</label>
            <input type="text" id="name" name="name" placeholder="Nhập tên của bạn" required>
        </div>

        <div class="form-group">
            <label for="mail">Email liên hệ:</label>
            <input type="email" id="mail" name="mail" placeholder="Nhập mail liên hệ" required>
        </div>

        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
        </div>

        <div class="form-group">
            <label for="image_url">Hình ảnh nguời đăng:</label>
            <input type="file" id="image_url" name="image_url" accept="image/*" required>
        </div>

        <!-- Xem trước hình ảnh -->
        <div class="preview-container" id="preview-container" style="display: none;">
            <img id="image-preview" src="" alt="Hình ảnh xem trước">
            <button type="button" class="delete-btn" id="delete-image">Xóa</button>
        </div>

        <input type="submit" value="Tiếp tục">
    </form>
</div>

<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>

<script>
    const imageInput = document.getElementById('image_url');
    const previewContainer = document.getElementById('preview-container');
    const imagePreview = document.getElementById('image-preview');
    const deleteBtn = document.getElementById('delete-image');

    // Xử lý xem trước hình ảnh
    imageInput.addEventListener('change', function(event) {
        const file = event.target.files[0];

        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                previewContainer.style.display = 'block'; // Hiển thị khu vực xem trước
            };
            reader.readAsDataURL(file);
        }
    });

    // Xử lý xóa hình ảnh
    deleteBtn.addEventListener('click', function() {
        imageInput.value = ''; // Xóa giá trị input file
        previewContainer.style.display = 'none'; // Ẩn khu vực xem trước
    });
</script>

</body>
</html>
