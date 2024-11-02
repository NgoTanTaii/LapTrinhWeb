<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="java.util.List" %>
<%
    String propertyIdParam = request.getParameter("property_id");
    int propertyId = Integer.parseInt(propertyIdParam);

    PropertyDAO propertyDAO = new PropertyDAO();
    List<String> thumbnailUrls = propertyDAO.getThumbnailUrls(propertyId); // Retrieve current thumbnails
%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Thumbnails cho Bất Động Sản</title>
    <style>
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .thumbnail {
            width: 100px;
            margin: 5px;
        }
        .thumbnail img {
            width: 100%;
            height: auto;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Quản lý Thumbnails cho Bất Động Sản ID: <%= propertyId %></h2>

    <!-- Form to add a new thumbnail URL -->
    <form action="AddThumbnailServlet" method="POST">
        <input type="hidden" name="property_id" value="<%= propertyId %>">
        <label>Thêm URL Hình Ảnh Nhỏ:</label>
        <input type="text" name="thumbnailUrl" placeholder="Nhập URL hình ảnh" required>
        <button type="submit">Thêm Thumbnail</button>
    </form>

    <h3>Danh sách Hình Ảnh Nhỏ</h3>
    <div class="thumbnails">
        <% if (thumbnailUrls != null && !thumbnailUrls.isEmpty()) { %>
        <% for (String thumbnailUrl : thumbnailUrls) { %>
        <div class="thumbnail">
            <img src="<%= thumbnailUrl %>" alt="Thumbnail">
            <form action="DeleteThumbnailServlet" method="POST">
                <input type="hidden" name="property_id" value="<%= propertyId %>">
                <input type="hidden" name="thumbnailUrl" value="<%= thumbnailUrl %>">
                <button type="submit">Xóa</button>
            </form>
        </div>
        <% } %>
        <% } else { %>
        <p>Không có hình ảnh nhỏ nào.</p>
        <% } %>
    </div>


    <a href="home-manager">Quay lại Quản lý Bất Động Sản</a>
</div>

</body>
</html>
