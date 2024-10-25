<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>

<header class="header">
    <div class="header-top" style="width: 100%; position: sticky; top: 0; z-index: 1000;">
        <div class="header-left">

            <div class="contact-item">
                <img src="jpg/phone-call.png" class="icon">
                <span>0123 456 789</span>
            </div>
            <div class="contact-item">
                <img src="jpg/email.png" class="icon">
                <span>info@company.com</span>
            </div>
            <div class="contact-item">

                <img src="jpg/location.png" class="icon">
                <span>123 Đường ABC, Quận XYZ, TP.HCM</span>
            </div>

        </div>
        <div class="header-right" style="margin-top: 10px">

            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>

        </div>


    </div>
    <div class="menu">
        <div class="header-bottom" style="height:60px;margin-top: 0">

            <div class="store-name">
                <h1><a href="">
                    <span class="color1">HOME</span>
                    <span class="color2">LANDER</span> <!-- Đổi từ VINA BOOK sang VINA BĐS -->
                </a></h1>
            </div>


            <nav>
                <ul>
                    <li><a href="#nhadatban">Nhà Đất Bán</a></li>
                    <li><a href="#nhadatchochue">Nhà Đất Cho Thuê</a></li>
                    <li><a href="#duan">Dự Án</a></li>
                    <li><a href="#tintuc">Tin Tức</a></li>
                    <li><a href="#wikibds">Wiki BĐS</a></li>
                </ul>
            </nav>


            <div class="contact-info">
                <img src="jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>

        </div>
    </div>


    </div>
</header>
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
<div class="container">
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


    <div class="sender-info">
        <h3>Thông tin người đăng</h3>
        <div class="sender-image">
            <img src="jpg/hinh-nen-gai-xinh.jpg" alt="Người đăng" class="sender-avatar">
        </div>
        <div class="info-box">

            <span id="sender-name">Nguyễn Văn A</span>
        </div>
        <div class="info-box">
            <span class="icon" style="margin-bottom: 12px;">✉️</span>
            <span id="sender-email">nguyenvana@example.com</span>
        </div>
        <div class="info-box">
            <span class="icon" style="margin-bottom: 12px;">📱</span>
            <span id="sender-zalo">https://zalo.me/123456789</span>
        </div>
    </div>

</div>


<style>
    .container {
        display: flex;
        justify-content: center; /* Căn giữa container */
        width: 70%; /* Chiếm khoảng 70% chiều rộng của trang */
        max-width: 1200px; /* Chiều rộng tối đa */
        padding-top: 10px;
        gap: 20px; /* Khoảng cách giữa các thẻ */
        margin: 0 auto; /* Căn giữa container trong trang */
    }

    .property-detail, .sender-info {
        width: 48%; /* Kích thước của từng phần */
        margin: 0 10px; /* Tạo khoảng cách đều giữa hai phần */
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        text-align: left; /* Căn giữa nội dung */
    }

    .property-detail {
        flex: 3; /* Thẻ lớn chiếm 3 phần */
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        text-align: center; /* Căn giữa nội dung */
    }

    .sender-info {
        flex: 1; /* Thẻ nhỏ chiếm 1 phần */
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        text-align: center; /* Căn giữa nội dung */
    }


    .info-box {
        display: flex; /* Sử dụng flexbox để căn giữa biểu tượng và nội dung */
        align-items: center; /* Căn giữa theo chiều dọc */
        justify-content: center; /* Căn giữa theo chiều ngang */
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
        margin: 10px 0; /* Tạo khoảng cách giữa các ô */
        background-color: #f9f9f9; /* Màu nền nhẹ */
    }

    .icon {
        margin-right: 10px; /* Khoảng cách giữa biểu tượng và văn bản */
        font-size: 20px; /* Kích thước biểu tượng */
    }

    .sender-image {
        margin-bottom: 15px;
    }

    .sender-avatar {
        width: 60px; /* Kích thước của avatar */
        height: 60px;
        border-radius: 50%; /* Bo tròn hình ảnh */
        border: 2px solid #ccc; /* Viền cho hình ảnh */
    }
</style>
</body>
</html>

<%
    }
%>
