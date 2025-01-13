<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Ảnh và File</title>
    <!-- CKFinder JavaScript -->
    <script src="../ckfinder.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #4CAF50;
        }
        .container {
            margin-bottom: 30px;
        }
        .file-preview {
            margin-top: 20px;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #f9f9f9;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .file-preview img {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<h2>Quản Lý Ảnh và File</h2>

<!-- Chọn và Xem Ảnh -->
<div class="container">
    <h3>Quản Lý Ảnh</h3>
    <form>
        <input type="text" id="imageUrl" placeholder="Đường dẫn ảnh..." style="width: 300px;" readonly />
        <button type="button" onclick="openImageManager()">Chọn Ảnh</button>
    </form>
    <div id="imagePreview" class="file-preview" style="display: none;">
        <img src="" alt="Ảnh Đã Chọn" id="imageElement" />
        <p id="imageInfo"></p>
    </div>
</div>

<hr />

<!-- Chọn và Xem File -->
<div class="container">
    <h3>Quản Lý File</h3>
    <form>
        <input type="text" id="fileUrl" placeholder="Đường dẫn file..." style="width: 300px;" readonly />
        <button type="button" onclick="openFileManager()">Chọn File</button>
    </form>
    <div id="filePreview" class="file-preview" style="display: none;">
        <p id="fileInfo"></p>
    </div>
</div>

<script>
    // Hàm mở CKFinder để chọn ảnh
    function openImageManager() {
        CKFinder.popup({
            chooseFiles: true,
            onInit: function(finder) {
                finder.on('files:choose', function(evt) {
                    var file = evt.data.files.first();
                    var imageUrl = file.getUrl();
                    document.getElementById('imageUrl').value = imageUrl;

                    // Hiển thị ảnh
                    var preview = document.getElementById('imagePreview');
                    var imgElement = document.getElementById('imageElement');
                    var infoElement = document.getElementById('imageInfo');
                    imgElement.src = imageUrl;
                    infoElement.textContent = `Tên: ${file.get('name')} | Kích thước: ${file.get('size')} bytes`;
                    preview.style.display = 'flex';
                });
            }
        });
    }

    // Hàm mở CKFinder để chọn file
    function openFileManager() {
        CKFinder.popup({
            chooseFiles: true,
            onInit: function(finder) {
                finder.on('files:choose', function(evt) {
                    var file = evt.data.files.first();
                    var fileUrl = file.getUrl();
                    document.getElementById('fileUrl').value = fileUrl;

                    // Hiển thị thông tin file
                    var preview = document.getElementById('filePreview');
                    var infoElement = document.getElementById('fileInfo');
                    infoElement.textContent = `Tên: ${file.get('name')} | Kích thước: ${file.get('size')} bytes | Định dạng: ${file.get('extension')}`;
                    preview.style.display = 'block';
                });
            }
        });
    }
</script>
</body>
</html>
