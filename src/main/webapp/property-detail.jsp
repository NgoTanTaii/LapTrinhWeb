<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>

<%
    String propertyId = request.getParameter("id");
    PropertyDAO propertyDAO = new PropertyDAO();
    Property1 property = propertyDAO.getPropertyById(propertyId);

    // Fetch thumbnails from the property_images table
    List<String> thumbnailUrls = propertyDAO.getThumbnailUrls(propertyId);

    if (property == null) {
        out.println("<h2>Property not found</h2>");
    } else {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Property Details</title>
    <link rel="stylesheet" href="css/bds.css">
    <style>
        .thumbnail {
            display: inline-block;
            margin: 5px;
            cursor: pointer;
        }

        .thumbnail img {
            width: 100px; /* Thumbnail size */
            height: auto;
        }

        .main-image {
            width: 500px; /* Main image size */
            height: auto;
        }

        .thumbnails {
            margin-top: 10px;
            text-align: left; /* Align thumbnails to the left */
        }
    </style>
    <script>
        function changeMainImage(src) {
            document.getElementById('mainImage').src = src;
        }
    </script>
</head>
<body>
<div class="property-detail">
    <h2><%= property.getTitle() %>
    </h2>
    <img id="mainImage" class="main-image"
         src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
         alt="<%= property.getTitle() %>">

    <div class="thumbnails">

        <%
            if (thumbnailUrls != null && !thumbnailUrls.isEmpty()) {
                for (String thumbnailUrl : thumbnailUrls) {
        %>
        <div class="thumbnail" onclick="changeMainImage('<%= thumbnailUrl %>')">
            <img src="<%= thumbnailUrl %>" alt="Thumbnail">
        </div>
        <%
            }
        } else {
        %>

        <%
            }
        %>
    </div>

    <p>Địa chỉ: <%= property.getAddress() %>
    </p>
    <p>Giá: <%= property.getPrice() %> tỷ</p>
    <p>Diện tích: <%= property.getArea() %> m²</p>
    <p>Mô tả: <%= property.getDescription() %>
    </p>
</div>
</body>
</html>

<%
    }
%>
