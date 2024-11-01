<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
    <style>
        /* Styling the form layout */
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
    </style>
</head>
<body>

<div class="container">
    <h1>Thêm Sản Phẩm Mới</h1>
    <form action="AddPropertyServlet" method="POST">
        <!-- Hidden input to set action type -->
        <input type="hidden" name="action" value="create">

        <label for="title">Tên:</label>
        <input type="text" id="title" name="title" required>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" step="0.01" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" id="area" name="area" required>

        <label for="imageUrl">URL Hình Ảnh:</label>
        <input type="text" id="imageUrl" name="imageUrl" required>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="type">Loại sản phẩm:</label>
        <input type="text" id="type" name="type" required>

        <label for="status">Trạng thái:</label>
        <input type="text" id="status" name="status">

        <button type="submit">Thêm Sản Phẩm</button>
    </form>
</div>

</body>
</html>
