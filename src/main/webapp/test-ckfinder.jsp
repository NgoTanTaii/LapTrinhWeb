<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CKFinder Test</title>

    <!-- CKFinder JS -->
    <script type="text/javascript" src="C://Users\Linh Luu\Downloads\ckfinder_php_3.7.0\ckfinder\ckfinder.js"></script>

    <script type="text/javascript">
        function openCKFinder() {
            var finder = CKFinder.replace('editor'); // ID của textarea
        }
    </script>
</head>
<body>
<h2>CKFinder Test</h2>

<form action="upload" method="POST" enctype="multipart/form-data">
    <label for="editor">Chọn tệp:</label><br>
    <textarea id="editor" name="editor" rows="10" cols="50"></textarea><br>
    <button type="button" onclick="openCKFinder()">Mở CKFinder</button>
    <br>
    <input type="submit" value="Upload"/>
</form>
</body>
</html>
