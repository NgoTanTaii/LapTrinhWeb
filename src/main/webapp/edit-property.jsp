<%@ page import="Entity.Property1" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String propertyId = request.getParameter("property_id");
    if (propertyId == null || propertyId.isEmpty()) {
        out.print("ID bất động sản không hợp lệ.");
        return;
    }

    PropertyDAO propertyDAO = new PropertyDAO();
    Property1 property = propertyDAO.getPropertyById(Integer.parseInt(propertyId));

    if (property == null) {
        out.print("Không tìm thấy bất động sản.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Bất Động Sản</title>
    <style>
        /* CSS styling giữ nguyên như bạn đã tạo */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        form {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #007BFF;
        }
    </style>
    <script>
        function toggleImageInput(type) {
            document.getElementById('fileInput').style.display = type === 'file' ? 'block' : 'none';
            document.getElementById('urlInput').style.display = type === 'url' ? 'block' : 'none';
        }
    </script>
</head>
<body>
<h2>Chỉnh sửa Bất Động Sản</h2>
<form action="properties" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="property_id" value="<%= property.getId() %>">

    <label for="title">Tên:</label>
    <input type="text" id="title" name="title" value="<%= property.getTitle() %>" required><br>

    <label for="price">Giá (tỷ VNĐ):</label>
    <input type="number" id="price" name="price" value="<%= property.getPrice() %>" step="0.01" required><br>

    <label for="address">Địa chỉ:</label>
    <input type="text" id="address" name="address" value="<%= property.getAddress() %>" required><br>

    <label for="area">Diện tích (m²):</label>
    <input type="number" id="area" name="area" value="<%= property.getArea() %>" required><br>

    <label>Cập nhật Hình Ảnh:</label>
    <label>
        <input type="radio" name="imageOption" value="file" onclick="toggleImageInput('file')" checked> Upload File
    </label>
    <label>
        <input type="radio" name="imageOption" value="url" onclick="toggleImageInput('url')"> Nhập URL
    </label>

    <div id="fileInput">
        <label for="imageFile">Chọn File Hình Ảnh:</label>
        <input type="file" id="imageFile" name="imageFile" accept=".jpg, .jpeg, .png">
    </div>

    <div id="urlInput" style="display: none;">
        <label for="imageUrl">URL Hình Ảnh:</label>
        <input type="text" id="imageUrl" name="imageUrl" value="<%= property.getImageUrl() %>">
    </div>

    <input type="hidden" name="action" value="update">
    <button type="submit">Cập nhật Bất Động Sản</button>
</form>
<a href="home-manager">Hủy</a>
</body>
</html>
