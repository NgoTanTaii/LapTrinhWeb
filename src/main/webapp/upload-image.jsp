<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm Hình Ảnh</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Thêm CSS nếu cần -->
</head>
<body>
<h2>Thêm Hình Ảnh</h2>


<h2>Tải lên ảnh cho tài sản</h2>
<form action="UploadServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="property_id" value="1"> <!-- Thay bằng ID thật -->
    <input type="file" name="image" accept="image/png, image/jpeg" required>
    <button type="submit">Tải lên ảnh</button>
</form>

</body>
</html>