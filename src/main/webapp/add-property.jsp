<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        textarea {
            height: 100px;
            resize: vertical;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        button:hover {
            background-color: #45a049;
        }

        .image-container {
            position: relative;
            display: inline-block;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .image-container img {
            max-width: 100px;
            max-height: 100px;
            display: block;
            border-radius: 5px;
        }

        .remove-button {
            position: absolute;
            top: 5px;
            right: 5px;
            background: red;
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            cursor: pointer;
            font-size: 14px;
            line-height: 16px;
            text-align: center;

        }

        #status, #type {
            font-size: 18px; /* Tăng kích thước chữ */
            padding: 10px; /* Tăng không gian bên trong */
            width: 100%; /* Để select chiếm hết chiều rộng của phần tử cha */
            height: 40px; /* Tăng chiều cao của select */
            border: 1px solid #ccc; /* Đường viền */
            border-radius: 4px; /* Bo tròn các góc */
            background-color: #f8f8f8; /* Màu nền */
            margin-top: 5px;
        }

        /* Tăng kích thước font cho các option */
        #status option, #type option {
            font-size: 18px; /* Tăng kích thước chữ trong các tùy chọn */
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Thêm Sản Phẩm Mới</h1>
    <form action="addProperty" method="POST" enctype="multipart/form-data">
        <label for="title">Tên:</label>
        <input type="text" id="title" name="title" required>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" step="0.01" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" id="area" name="area" required>

        <label for="file">Chọn hình ảnh chính:</label>
        <input type="file" id="file" name="file" accept="image/*" required onchange="previewMainImage(event)">
        <div id="mainImageContainer" class="image-container" style="display: none;">
            <img id="mainImage" src="#" alt="Preview Image">
            <button class="remove-button" onclick="removeMainImage(event)">X</button>
        </div>

        <label for="additional_images">Chọn hình ảnh bổ sung:</label>
        <input type="file" id="additional_images" name="additional_images" accept="image/*" multiple
               onchange="previewAdditionalImages(event)">
        <div id="additionalImagesPreview"></div>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="type">Loại:</label>
        <select name="type" id="type" required>
            <option>Nhà ở</option>
            <option>Chung cư</option>
            <option>Biệt thự</option>
            <option>Nhà phố</option>
            <option>Căn hộ dịch vụ</option>
            <option>Nhà mặt phố</option>
            <option>Căn hộ cao cấp</option>
            <option>Nhà trọ cho thuê</option> <!-- Sửa value bị trùng -->
        </select>

        <label for="status">Tình trạng:</label>
        <select name="status" id="status" required>
            <option value="1">Nhà đất bán</option>
            <option value="2">Nhà đất cho thuê</option>
            <option value="3">Dự án</option>
        </select>


        <button type="submit">Thêm Sản Phẩm</button>
    </form>

    <script>
        // Xem trước hình ảnh chính
        function previewMainImage(event) {
            const file = event.target.files[0];
            const reader = new FileReader();
            reader.onload = function (e) {
                const mainImage = document.getElementById('mainImage');
                const container = document.getElementById('mainImageContainer');
                mainImage.src = e.target.result;
                container.style.display = 'inline-block';
            };
            if (file) reader.readAsDataURL(file);
        }

        function removeMainImage(event) {
            event.preventDefault();
            const container = document.getElementById('mainImageContainer');
            const mainImage = document.getElementById('mainImage');
            mainImage.src = "#";
            container.style.display = 'none';
            document.getElementById('file').value = ""; // Clear file input
        }

        // Xem trước các hình ảnh bổ sung
        function previewAdditionalImages(event) {
            const files = event.target.files;
            const previewContainer = document.getElementById('additionalImagesPreview');
            previewContainer.innerHTML = ""; // Xóa nội dung cũ

            Array.from(files).forEach((file, index) => {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const container = document.createElement('div');
                    container.classList.add('image-container');

                    const img = document.createElement('img');
                    img.src = e.target.result;

                    const removeButton = document.createElement('button');
                    removeButton.classList.add('remove-button');
                    removeButton.textContent = "X";
                    removeButton.onclick = function (ev) {
                        ev.preventDefault();
                        container.remove();
                    };

                    container.appendChild(img);
                    container.appendChild(removeButton);
                    previewContainer.appendChild(container);
                };
                if (file) reader.readAsDataURL(file);
            });
        }
    </script>
</div>

</body>
</html>
