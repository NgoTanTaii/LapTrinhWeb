<%
    Integer userId = (Integer) session.getAttribute("userId"); // Kiểm tra userId trong session
    String username = (String) session.getAttribute("username"); // Kiểm tra username trong session

    if (userId == null || username == null) {
        // Nếu chưa đăng nhập, chuyển hướng đến trang login
        response.sendRedirect("login.jsp?redirect=post-status.jsp");
    }
%>
<script src="path/to/ckfinder/ckfinder.js"></script>
<script>
    CKFinder.setupCKEditor(null, '/uploads/');
</script>

<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Property Details</title>

    <style>
        /* Phần select cho trạng thái */
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

        /* Toàn bộ trang */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        /* Container chính */
        .container {
            width: 60%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* Tiêu đề */
        h2 {
            text-align: center;
            color: #333;
        }

        /* Form */
        form {
            display: flex;
            flex-direction: column;
        }

        form label {
            margin-top: 10px;
            font-weight: bold;
        }

        form input, form textarea, form select {
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form input[type="file"] {
            padding: 5px;
        }

        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Phần thông báo lỗi */
        .error-message {
            color: #f44336;
            font-weight: bold;
            background-color: #fff3f3;
            padding: 10px;
            margin-top: 20px;
            border: 1px solid #f44336;
            border-radius: 4px;
        }

        /* Phần danh sách file đã tải lên */
        .uploaded-files {
            margin-top: 20px;
        }

        .uploaded-files h3 {
            font-size: 18px;
            color: #333;
        }

        .uploaded-files ul {
            list-style-type: none;
            padding: 0;
        }

        .uploaded-files ul li {
            margin-bottom: 10px;
        }

        .uploaded-files img {
            max-width: 300px;
            height: auto;
            border-radius: 4px;
        }

        .uploaded-files a {
            color: #007bff;
            text-decoration: none;
        }

        .uploaded-files a:hover {
            text-decoration: underline;
        }

        /* Phần khi không có file */
        .no-files {
            color: #777;
            font-style: italic;
            margin-top: 20px;
        }

        .exit-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
            margin-top: 20px;
            text-align: center;
        }

        .exit-link:hover {
            background-color: #d32f2f;
        }

        /* Các kiểu mới cho container hình ảnh và nút X */
        .image-container {
            position: relative;
            display: inline-block;
            margin: 10px;
        }

        .image-container img {
            max-width: 200px;
            max-height: 200px;
            display: block;
            border-radius: 4px;
        }

        .remove-image {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(255, 255, 255, 0.7);
            border: none;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            cursor: pointer;
            font-weight: bold;
            color: #333;
            text-align: center;
            line-height: 25px;
        }

        .remove-image:hover {
            background-color: rgba(255, 0, 0, 0.8);
            color: #fff;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Đăng tin</h2>
    <form action="uploadProperty" method="post" enctype="multipart/form-data">
        <label for="title">Tiêu đề:</label>
        <input type="text" name="title" id="title" required>

        <label for="description">Mô tả:</label>
        <textarea name="description" id="description" required></textarea>

        <label for="price">Giá:</label>
        <input type="number" name="price" id="price" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" name="address" id="address" required>

        <label for="type">Loại:</label>
        <select name="type" id="type" required>
            <option value="1">Nhà ở</option>
            <option value="2">Chung cư</option>
            <option value="3">Biệt thự</option>
            <option value="4">Nhà phố</option>
            <option value="5">Căn hộ dịch vụ</option>
            <option value="6">Nhà mặt phố</option>
            <option value="7">Căn hộ cao cấp</option>
            <option value="8">Nhà trọ cho thuê</option> <!-- Sửa value bị trùng -->
        </select>

        <label for="status">Tình trạng:</label>
        <select name="status" id="status" required>
            <option value="1">Nhà đất bán</option>
            <option value="2">Nhà đất cho thuê</option>
            <option value="3">Dự án</option>
        </select>

        <label for="area">Diện tích (m²):</label>
        <input type="number" name="area" id="area" required>

        <input type="hidden" name="poster_id" id="poster_id" value="<%= session.getAttribute("posterId") %>">

        <!-- Hình ảnh chính -->
        <label for="file">Tải lên hình ảnh chính:</label>
        <input type="file" name="file" id="file" required accept="image/*" onchange="previewMainImage(event)">

        <div id="mainImagePreview" style="margin-top: 10px;">
            <!-- Container sẽ chứa hình ảnh chính và nút X -->
            <div class="image-container" id="mainImageContainer" style="display: none;">
                <img id="mainImage" src="" alt="Preview">
                <button type="button" class="remove-image" onclick="removeMainImage()">×</button>
            </div>
        </div>

        <!-- Hình ảnh bổ sung -->
        <label for="additional_images">Tải lên hình ảnh bổ sung (không bắt buộc):</label>
        <input type="file" name="additional_images" id="additional_images" multiple accept="image/*"
               onchange="previewAdditionalImages(event)">

        <div id="additionalImagesPreview" style="margin-top: 10px;">
            <!-- Các hình ảnh bổ sung sẽ hiển thị ở đây -->
        </div>
<%--        <a href="upload-video.jsp" style="text-align: center">Đăng thêm video về  bất--%>
<%--            động sản (chỉ 1)</a>--%>

        <input type="submit" value="Đăng Bất Động Sản">
        <a href="deletePoster" class="exit-link" style="text-align: center" onclick="return confirmExit()">Thoát</a>
    </form>

    <script>
        // Hàm xem trước hình ảnh chính
        function previewMainImage(event) {
            const mainImage = document.getElementById('mainImage');
            const mainImageContainer = document.getElementById('mainImageContainer');
            const fileInput = event.target;

            if (fileInput.files && fileInput.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    mainImage.src = e.target.result;
                    mainImage.style.display = 'block';
                    mainImageContainer.style.display = 'inline-block';
                }
                reader.readAsDataURL(fileInput.files[0]);
            }
        }

        // Hàm xóa hình ảnh chính
        function removeMainImage() {
            const mainImage = document.getElementById('mainImage');
            const mainImageContainer = document.getElementById('mainImageContainer');
            const fileInput = document.getElementById('file');

            mainImage.src = '';
            mainImage.style.display = 'none';
            mainImageContainer.style.display = 'none';
            fileInput.value = ''; // Xóa giá trị của input file
        }

        // Hàm xem trước các hình ảnh bổ sung
        function previewAdditionalImages(event) {
            const additionalImagesPreview = document.getElementById('additionalImagesPreview');
            additionalImagesPreview.innerHTML = ''; // Xóa các hình ảnh hiện có
            const files = event.target.files;

            if (files) {
                Array.from(files).forEach((file, index) => {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        // Tạo container cho từng hình ảnh
                        const imageContainer = document.createElement('div');
                        imageContainer.classList.add('image-container');

                        // Tạo thẻ img
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.alt = `Preview ${index + 1}`;

                        // Tạo nút X
                        const removeButton = document.createElement('button');
                        removeButton.type = 'button';
                        removeButton.classList.add('remove-image');
                        removeButton.innerHTML = '×';
                        removeButton.onclick = function () {
                            removeAdditionalImage(index);
                        }

                        // Thêm img và nút X vào container
                        imageContainer.appendChild(img);
                        imageContainer.appendChild(removeButton);

                        // Thêm container vào phần xem trước
                        additionalImagesPreview.appendChild(imageContainer);
                    }
                    reader.readAsDataURL(file);
                });
            }
        }

        // Hàm xóa hình ảnh bổ sung
        function removeAdditionalImage(index) {
            const additionalImagesInput = document.getElementById('additional_images');
            const dt = new DataTransfer();

            const {files} = additionalImagesInput;
            for (let i = 0; i < files.length; i++) {
                if (i !== index) {
                    dt.items.add(files[i]);
                }
            }
            additionalImagesInput.files = dt.files;
            previewAdditionalImages({target: additionalImagesInput});
        }

        // Hàm xác nhận khi thoát
        function confirmExit() {
            // Hiển thị hộp thoại xác nhận khi người dùng nhấn "Thoát"
            return confirm("Bạn có chắc chắn muốn thoát? Mọi thông tin sẽ bị xóa nếu bạn thoát.");
        }
    </script>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <div class="error-message">
        <%= errorMessage %>
    </div>
    <%
        }
    %>

    <%-- Nếu có file được tải lên, hiển thị các file đó --%>
    <%
        List<String> uploadedFiles = (List<String>) request.getAttribute("uploadedFiles");
        if (uploadedFiles != null && !uploadedFiles.isEmpty()) {
    %>
    <div class="uploaded-files">
        <h3>Danh sách các file đã tải lên:</h3>
        <ul>
            <% for (String file : uploadedFiles) { %>
            <li>
                <%-- Kiểm tra xem file có phải là ảnh hay không --%>
                <%
                    String fileExtension = file.substring(file.lastIndexOf(".") + 1).toLowerCase();
                    if (fileExtension.equals("jpg") || fileExtension.equals("jpeg") || fileExtension.equals("png") || fileExtension.equals("gif")) {
                %>
                <img src="<%= file %>" alt="Uploaded Image">
                <% } else { %>
                <a href="<%= file %>" target="_blank">Download: <%= file %>
                </a>
                <% } %>
            </li>
            <% } %>
        </ul>
    </div>
    <%
    } else {
    %>
    <div class="no-files">
        Không có file nào được tải lên.
    </div>
    <%
        }
    %>

</div>

</body>
</html>
