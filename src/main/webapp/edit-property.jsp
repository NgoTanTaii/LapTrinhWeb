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
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .cancel-link {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #007BFF;
            text-decoration: none;
        }

        .cancel-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Chỉnh sửa Bất Động Sản</h2>
    <form action="EditPropertyServlet" method="POST">
        <!-- Hidden fields to pass property ID and action type -->
        <input type="hidden" name="property_id" value="<%= property.getId() %>">
        <input type="hidden" name="action" value="update">

        <label for="title">Tên:</label>
        <input type="text" id="title" name="title" value="<%= property.getTitle() %>" required>

        <label for="price">Giá (tỷ VNĐ):</label>
        <input type="number" id="price" name="price" value="<%= property.getPrice() %>" step="0.01" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" value="<%= property.getAddress() %>" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" id="area" name="area" value="<%= property.getArea() %>" required>

        <label for="imageUrl">URL Hình Ảnh:</label>
        <input type="text" id="imageUrl" name="imageUrl" value="<%= property.getImageUrl() %>" required>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required><%= property.getDescription() %></textarea>

        <label for="type">Loại sản phẩm:</label>
        <input type="text" id="type" name="type" value="<%= property.getType() %>" required>

        <label for="status">Trạng thái:</label>
        <input type="text" id="status" name="status" value="<%= property.getStatus() %>" required>

        <button type="submit">Cập nhật Bất Động Sản</button>
    </form>
    <a href="home-manager" class="cancel-link">Hủy</a>
</div>

</body>
</html>
