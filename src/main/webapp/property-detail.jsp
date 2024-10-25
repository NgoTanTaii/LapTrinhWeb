<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
                <h1><a href="homes">
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
    <link rel="stylesheet" href="css/property-detail.css">
</head>
<body>
<div class="container" style="max-width:80% ">
    <div class="property-detail">
        <h2><%= property.getTitle() %>
        </h2>


        <img id="mainImage" class="main-image"
             src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
             alt="<%= property.getTitle() %>">

        <div class="thumbnails">

            <div class="thumbnail"
                 onclick="changeMainImage('<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>')">
                <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                     alt="Thumbnail">
            </div>

            <%
                if (thumbnailUrls != null && !thumbnailUrls.isEmpty()) {
                    int displayedCount = Math.min(thumbnailUrls.size(), 20); // Giảm số lượng thumbnail còn lại xuống 4
                    for (int i = 0; i < displayedCount; i++) {
                        String thumbnailUrl = thumbnailUrls.get(i);
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

    <style>
        .container {
            max-width: 800px; /* Đặt chiều rộng tối đa cho container */
            margin: 0 auto; /* Center container */
        }

        .property-detail {
            position: relative;
            overflow: hidden; /* Ẩn phần vượt ra ngoài */
            margin-bottom: 20px; /* Khoảng cách giữa property-detail và sản phẩm liên quan */
        }

        .main-image {
            max-width: 100%; /* Đảm bảo hình ảnh không bị tràn ra ngoài */
            height: auto; /* Giữ tỉ lệ hình ảnh */
        }

        .thumbnails {
            display: flex; /* Sử dụng flexbox để hiển thị ngang */
            overflow-x: auto; /* Cho phép cuộn ngang */
            margin-top: 10px; /* Khoảng cách giữa hình ảnh lớn và thumbnails */
        }

        .thumbnail {
            flex: 0 0 auto; /* Không cho phép thumbnail co lại */
            width: 100px; /* Chiều rộng của mỗi thumbnail */
            margin-right: 10px; /* Khoảng cách giữa các thumbnail */
            cursor: pointer;
        }

        .thumbnail img {
            width: 100%; /* Đảm bảo hình ảnh phù hợp với thumbnail */
        }

        .related-properties {
            margin-top: 20px;
        }

        .related-properties-container {
            display: flex;
            overflow-x: auto; /* Cho phép cuộn ngang cho sản phẩm liên quan */
            height: 300px; /* Chiều cao cố định cho sản phẩm liên quan */
        }

        .related-property {
            flex: 0 0 auto; /* Không cho phép co lại */
            width: 200px; /* Chiều rộng của mỗi sản phẩm liên quan */
            margin-right: 10px;
            text-align: center;
        }

        .related-property img {
            max-width: 100%;
            height: auto; /* Giữ tỉ lệ hình ảnh */
        }
    </style>

    <script>
        function changeMainImage(url) {
            document.getElementById('mainImage').src = url; // Thay đổi hình ảnh chính
        }

        const thumbnailsContainer = document.querySelector('.thumbnails');
        thumbnailsContainer.addEventListener('scroll', function () {

        });
    </script>

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
<div class="related-properties" style="width:63%">
    <h3>Các sản phẩm liên quan</h3>
    <div class="related-properties-container" id="relatedProductsContainer">
        <div class="related-property">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 1">
            <h4>Sản phẩm 1</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 1.5 tỷ</span>
                <span>Diện tích: 100m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 2">
            <h4>Sản phẩm 2</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2 tỷ</span>
                <span>Diện tích: 120m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 3">
            <h4>Sản phẩm 3</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2.5 tỷ</span>
                <span>Diện tích: 150m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 4">
            <h4>Sản phẩm 4</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 3 tỷ</span>
                <span>Diện tích: 200m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 5">
            <h4>Sản phẩm 5</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 1.8 tỷ</span>
                <span>Diện tích: 90m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 6">
            <h4>Sản phẩm 6</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2.2 tỷ</span>
                <span>Diện tích: 110m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 6">
            <h4>Sản phẩm 6</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2.2 tỷ</span>
                <span>Diện tích: 130m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="more-products">
            <button id="scrollLeftBtn"> <</button>
            <button id="scrollRightBtn">️ ></button>
        </div>
    </div>
</div>

<div class="related-properties" style="width:63%">
    <h3>Các sản phẩm liên quan</h3>
    <div class="related-properties-container" id="relatedProductsContainer">
        <div class="related-property">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 1">
            <h4>Sản phẩm 1</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 1.5 tỷ</span>
                <span>Diện tích: 100m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 2">
            <h4>Sản phẩm 2</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2 tỷ</span>
                <span>Diện tích: 120m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 3">
            <h4>Sản phẩm 3</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2.5 tỷ</span>
                <span>Diện tích: 150m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 4">
            <h4>Sản phẩm 4</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 3 tỷ</span>
                <span>Diện tích: 200m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 5">
            <h4>Sản phẩm 5</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 1.8 tỷ</span>
                <span>Diện tích: 90m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 6">
            <h4>Sản phẩm 6</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2.2 tỷ</span>
                <span>Diện tích: 110m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="related-property hidden">
            <img src="jpg/HCM.jpg" alt="Sản phẩm 6">
            <h4>Sản phẩm 6</h4>
            <p style="display: flex; justify-content: space-between; color: red;">
                <span>Giá: 2.2 tỷ</span>
                <span>Diện tích: 130m²</span>
            </p>
            <p style="display: flex; align-items: center;">
                <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                     style="width: 16px; height: 16px; margin-right: 5px;">
                Địa chỉ: HCM
            </p>
        </div>
        <div class="more-products">
            <button id="scrollLeftBtn"> <</button>
            <button id="scrollRightBtn">️ ></button>
        </div>
    </div>
</div>

<script>
    const container = document.getElementById('relatedProductsContainer');

    document.getElementById('scrollLeftBtn').addEventListener('click', function () {
        container.scrollBy({
            top: 0,
            left: -200, // Cuộn 200px sang trái
            behavior: 'smooth'
        });
    });

    document.getElementById('scrollRightBtn').addEventListener('click', function () {
        container.scrollBy({
            top: 0,
            left: 200, // Cuộn 200px sang phải
            behavior: 'smooth'
        });
    });

</script>

<style>
    .related-properties {
        margin-top: 10px; /* Giảm khoảng cách giữa các phần */
        padding-left: 135px; /* Khoảng cách với lề trái */
        position: relative; /* Để định vị các nút */

    }


    .related-properties-container {
        display: flex;
        overflow-x: auto; /* Ẩn thanh cuộn mặc định */
        height: 250px; /* Chiều cao cố định cho sản phẩm liên quan */
        padding-bottom: 10px; /* Khoảng cách cho nút cuộn */


    }

    .related-properties-container::-webkit-scrollbar {
        height: 0px; /* Chiều cao của thanh cuộn */
    }

    .related-property {
        flex: 0 0 auto; /* Không cho phép co lại */
        width: 200px; /* Chiều rộng của mỗi sản phẩm liên quan */
        margin-right: 10px;
        text-align: left;
        overflow: visible; /* Cho phép hình ảnh hiển thị bên ngoài */
        border: 1px solid gainsboro;
        border-radius: 10px;
        position: relative; /* Để z-index có hiệu lực */
        transition: transform 0.3s; /* Thêm hiệu ứng chuyển tiếp */
    }

    .related-property:hover {
        transform: translateY(-5px); /* Nổi lên trên 5px */
        z-index: 15; /* Đưa sản phẩm lên trên cùng để không bị che khuất */
    }


    .related-property img {
        width: 100%; /* Đảm bảo hình ảnh phù hợp với kích thước chứa */
        height: auto; /* Tự động điều chỉnh chiều cao */
        border: 2px solid transparent; /* Border mặc định là trong suốt */
        border-radius: 10px; /* Bo tròn góc cho hình ảnh */
        transition: border-color 0.3s; /* Hiệu ứng chuyển tiếp cho border */
    }

    .more-products {
        position: absolute; /* Định vị tuyệt đối */
        top: 0; /* Căn lên cùng với tiêu đề */
        right: 0; /* Căn bên phải */
        padding-bottom: 5px;
    }

    #scrollLeftBtn, #scrollRightBtn {
        background-color: whitesmoke; /* Màu nền cho nút */
        color: black; /* Màu chữ */
        border: none; /* Không có đường viền */
        padding: 5px; /* Khoảng cách bên trong */
        cursor: pointer; /* Con trỏ khi di chuột qua */
        border-radius: 5px; /* Bo tròn góc */
        font-size: 14px; /* Kích thước chữ */
        margin-left: 5px; /* Khoảng cách giữa các nút */
    }

    #scrollLeftBtn:hover, #scrollRightBtn:hover {
        background-color: wheat; /* Màu nền khi di chuột qua */
    }
</style>

<div class="footer">
    <div class="footer-top">

        <h1><a href="homes">
            <span class="color1">HOME</span>
            <span class="color2">LANDER</span>
        </a></h1>
        <span class="footer-item"><i class="fas fa-phone"></i> Hotline: 0123 456 789</span>
        <span class="footer-item"><i class="fas fa-envelope"></i> Hỗ trợ: support@batdongsan.com</span>
        <span class="footer-item"><i class="fas fa-headset"></i> Chăm sóc: 0987 654 321</span>
    </div>

    <div class="footer-content">
        <!-- Thông tin công ty -->
        <div class="company-info">
            <h3>Công ty Bất Động Sản</h3>
            <p>Địa chỉ: 123 Đường ABC, Quận 1, TP.HCM</p>
            <p>Điện thoại: 0123 456 789</p>
        </div>

        <!-- Liên kết nhanh -->
        <div class="quick-links">
            <h3>Liên kết nhanh</h3>
            <ul>
                <li><a href="#">Trang chủ</a></li>
                <li><a href="#">Dự án</a></li>
                <li><a href="#">Tin tức</a></li>
                <li><a href="#">Liên hệ</a></li>
            </ul>
        </div>

        <!-- Mạng xã hội -->
        <div class="social-media">
            <h3>Mạng xã hội</h3>
            <a href="https://www.facebook.com/khoa.ngo.562114/" class="social-icon"><i class="fab fa-facebook"></i>
                Facebook</a>
            <a href="https://www.instagram.com/khoa5462/" class="social-icon"><i class="fab fa-instagram"></i>
                Instagram</a>
            <a href="https://mail.google.com/mail/u/0/?hl=vi#inbox" class="social-icon"><i
                    class="fas fa-envelope"></i>
                Mail</a>
        </div>

        <!-- Form nhập email -->
        <div class="newsletter">
            <h3>Đăng ký nhận tin tức mới nhất</h3>
            <form action="#" method="POST">
                <input type="email" name="email" placeholder="Nhập email của bạn" required>
                <button type="submit">Đăng ký</button>
            </form>
        </div>
    </div>

    <div class="footer-bottom">
        <p>&copy; 2024 Công ty Bất Động Sản. Mọi quyền lợi thuộc về công ty.</p>
    </div>


</div>
</body>

</html>

<%
    }
%>
