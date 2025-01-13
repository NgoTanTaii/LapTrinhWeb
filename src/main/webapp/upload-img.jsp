<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Ảnh</title>
    <!-- Thêm CKEditor 5 -->
    <script src="https://cdn.ckeditor.com/ckeditor5/38.1.0/classic/ckeditor.js"></script>
</head>
<body>
<h2>Quản Lý Ảnh</h2>

<!-- Trình Soạn Thảo Văn Bản -->
<h3>Trình Soạn Thảo Văn Bản</h3>
<textarea id="editor"></textarea>

<script>
    ClassicEditor
        .create(document.querySelector('#editor'), {
            toolbar: [
                'imageUpload', '|', 'bold', 'italic', 'link',
                'bulletedList', 'numberedList', 'blockQuote',
                'undo', 'redo'
            ],
            simpleUpload: {
                uploadUrl: '<c:url value="/uploadImage" />', // URL xử lý upload ảnh phía server
                headers: {
                    'X-CSRF-TOKEN': 'CSRF-Token' // Thêm header nếu cần bảo mật
                }
            }
        })
        .catch(error => {
            console.error(error);
        });
</script>

</body>
</html>
