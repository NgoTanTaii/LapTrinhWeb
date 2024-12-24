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
        response.sendRedirect("error.jsp");  // Chuyển hướng nếu không tìm thấy bất động sản
        return;
    }
    String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Bất Động Sản</title>
    <style>
        /* Styles for the form and other elements */
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

        .image-preview {
            max-width: 100%;
            max-height: 200px;
            margin-bottom: 15px;
        }

        .edit-thumbnail-link {
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            display: inline-block;
            margin-top: 10px;
            padding: 5px 10px;
            border: 1px solid #007bff;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .edit-thumbnail-link:hover {
            background-color: #007bff;
            color: white;
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
            margin-bottom: 20px;
        }

        /* Tăng kích thước font cho các option */
        #status option, #type option {
            font-size: 18px; /* Tăng kích thước chữ trong các tùy chọn */
        }

    </style>
</head>
<body>

<div class="container">
    <h2>Chỉnh sửa Bất Động Sản</h2>

    <form action="editProperty" method="POST" enctype="multipart/form-data">
        <%--@declare id="currentimage"--%><%--@declare id="newimage"--%><input type="hidden" name="property_id"
                                                                               value="<%= property.getId() %>">

        <label for="title">Tên:</label>
        <input type="text" id="title" name="title" value="<%= property.getTitle() %>" required>

        <label for="price">Giá (tỷ VNĐ):</label>
        <input type="number" id="price" name="price" value="<%= property.getPrice() %>" step="0.01" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" value="<%= property.getAddress() %>" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" id="area" name="area" value="<%= property.getArea() %>" required>

        <!-- Hiển thị ảnh hiện tại nếu có -->
        <label for="currentImage">Ảnh hiện tại:</label>
        <img src="<%= property.getImageUrl() %>" alt="Current Image" class="image-preview" id="current-image">

        <!-- Hiển thị ảnh mới nếu có lựa chọn -->
        <label for="newImage">Ảnh mới:</label>
        <img id="new-image-preview" class="image-preview" style="display:none;"/>

        <label for="image">Chọn hình ảnh mới:</label>
        <input type="file" id="image" name="image" onchange="previewNewImage(event)">

        <!-- Liên kết chỉnh sửa ảnh nhỏ -->
        <a href="add-thumbnail.jsp?property_id=<%= property.getId() %>" class="edit-thumbnail-link">Chỉnh sửa hình ảnh
            nhỏ</a>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required><%= property.getDescription() %></textarea>

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
        <button type="submit">Cập nhật Bất Động Sản</button>
    </form>
    <a href="javascript:void(0);" class="cancel-link" onclick="goBack()">Hủy</a>

    <% if ("admin".equals(role)) { %>
    <a href="home-manager" class="cancel-link">Về trang quản lý</a>
    <% } %>
    <script>
        function goBack() {
            window.history.back(); // Quay lại trang trước đó
        }

        // Hàm để hiển thị ảnh mới trước khi tải lên
        function previewNewImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                var output = document.getElementById('new-image-preview');
                output.src = reader.result;  // Đặt hình ảnh mới vào thẻ <img>
                output.style.display = "block";  // Hiển thị ảnh mới
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</div>

</body>
</html>
