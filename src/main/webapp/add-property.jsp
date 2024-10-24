<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm sản phẩm mới</title>
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
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }

        textarea {
            height: 100px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Thêm sản phẩm mới</h1>
    <form action="addProduct" method="POST" enctype="multipart/form-data">

        <label for="property_id">Property ID:</label>
        <input type="text" id="property_id" name="property_id" required>

        <label for="title">Tên:</label>
        <input type="text" id="title" name="title" required>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" id="area" name="area" required>

        <label for="image">Hình ảnh:</label>
        <input type="file" id="image" name="image" accept=".jpg, .jpeg, .png" required>
        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required></textarea>
        <label for="type">Loại sản phẩm:</label>
        <input type="text" id="type" name="type">

        <label for="status">Trạng thái:</label>
        <input type="text" id="status" name="status">

        <label for="agent_id">ID đại lý:</label>
        <input type="number" id="agent_id" name="agent_id">

        <button type="submit">Thêm sản phẩm</button>
    </form>
</div>

</body>
</html>
