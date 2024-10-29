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
    <style>
        .bottom-banner {
            width: 56%; /* Kích thước của banner */
            margin-left: 135px; /* Canh giữa và tạo khoảng cách */
            margin-top: 50px;
        }

        .bottom-banner img {
            width: 63%; /* Chiều rộng đầy đủ */
            border-radius: 5px; /* Bo góc cho banner */
            padding-right: 50px;
        }

        .property-features {
            margin-top: 30px;
            width: 52%; /* Kích thước của banner */
            margin-left: 135px; /* Canh giữa và tạo khoảng cách */

            padding: 15px; /* Padding cho phần đặc điểm */
            border: 1px solid #ccc; /* Viền cho phần đặc điểm */
            border-radius: 5px; /* Bo góc cho phần đặc điểm */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Đổ bóng cho phần đặc điểm */
        }

        .features-container {
            display: flex; /* Sử dụng Flexbox để chia cột */
            justify-content: space-between; /* Tạo khoảng cách đều giữa các cột */
        }

        .features-column {
            width: 48%; /* Chiều rộng của mỗi cột */
        }

        .feature-item {
            display: flex; /* Sử dụng Flexbox cho mỗi mục */
            align-items: center; /* Căn giữa theo chiều dọc */
            margin-bottom: 10px; /* Khoảng cách giữa các mục */
            padding: 5px 0; /* Thêm padding trên và dưới để căn chỉnh */
        }

        .feature-icon {
            font-size: 24px; /* Kích thước biểu tượng */
            margin-right: 20px; /* Khoảng cách giữa biểu tượng và nội dung */

            flex-shrink: 0; /* Đảm bảo biểu tượng không bị co lại */
        }

        /* Đảm bảo nội dung trong các mục được căn chỉnh đều */
        .feature-item span {
            display: flex; /* Sử dụng Flexbox cho span */
            justify-content: space-between; /* Căn đều giữa label và giá trị */
            width: 100%; /* Đảm bảo chiều rộng đầy đủ */
        }

        .property-features h3 {
            margin-bottom: 10px; /* Khoảng cách dưới tiêu đề */
        }

        .property-features ul {
            list-style-type: none; /* Xóa dấu chấm đầu dòng */
            padding: 0; /* Xóa padding mặc định */
        }

        .property-features li {
            margin-bottom: 8px; /* Khoảng cách giữa các mục trong danh sách */
            display: flex; /* Hiển thị các mục dưới dạng dòng */
        }

        .property-features strong {
            margin-right: 10px; /* Khoảng cách giữa tiêu đề và giá trị */
            color: #333; /* Màu sắc cho tiêu đề */
        }

        .feature-icon {
            font-size: 24px; /* Điều chỉnh kích thước biểu tượng */
            margin-right: 10px; /* Khoảng cách giữa biểu tượng và nội dung */

        }

        .map-container {
            width: 52%;
            margin-left: 135px;
            border: 1px solid #ccc; /* Đường viền cho phần bản đồ */
            border-radius: 5px; /* Bo góc cho phần bản đồ */
            overflow: hidden; /* Ẩn đi các phần viền ra ngoài */
            margin-top: 30px;
        }

        .map-container h3 {
            padding: 10px; /* Khoảng cách cho tiêu đề bản đồ */
            background-color: #f8f8f8; /* Nền cho tiêu đề */
            width: 100%;
            margin: 0; /* Không có khoảng cách bên ngoài */
            border-bottom: 1px solid #ccc; /* Đường viền dưới cho tiêu đề */
        }

        .additional-info {
            margin-top: 50px;
            width: 52%;
            border: 1px solid #ccc; /* Đường viền cho phần thông tin bổ sung */
            border-radius: 5px; /* Bo góc cho phần thông tin bổ sung */
            margin-left: 135px; /* Khoảng cách trên và dưới */
            padding: 15px; /* Khoảng cách bên trong */
            background-color: #f9f9f9; /* Màu nền cho phần thông tin bổ sung */
        }

        .additional-info h3 {
            margin: 0 0 10px 0; /* Khoảng cách dưới tiêu đề */
            font-size: 1.2em; /* Kích thước chữ tiêu đề */
        }

        .info-container {
            display: flex; /* Sử dụng flexbox để xếp hàng dọc */
            flex-direction: row; /* Xếp hàng theo chiều dọc */
        }

        .info-item {
            display: flex; /* Sử dụng flexbox để căn chỉnh icon và text */
            align-items: center; /* Căn giữa theo chiều dọc */
            margin-bottom: 10px; /* Khoảng cách giữa các mục thông tin */
            font-size: 0.9em; /* Kích thước chữ nhỏ hơn */
        }

        .info-icon {
            margin-right: 10px; /* Khoảng cách giữa icon và text */
            color: #007bff; /* Màu sắc cho các icon */
        }

        .copyright {
            width: 52%;
            margin-left: 135px;
            margin-top: 40px; /* Khoảng cách trên cho phần bản quyền */
            padding: 10px; /* Padding bên trong */
            text-align: center; /* Căn giữa nội dung */
            font-size: 0.8em; /* Kích thước chữ nhỏ hơn */
            color: #555; /* Màu chữ */
            border-top: 1px solid #ccc; /* Đường viền trên */
            background-color: #f9f9f9; /* Màu nền nhẹ cho phần bản quyền */
        }
    </style>
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

<div class="bottom-banner">
    <img src="jpg/bank-loan-offer-banner-web.jpg" alt="Banner quảng cáo" style="width: 100%; border-radius: 5px;">
</div>

<!-- Đặc điểm bất động sản -->

<div class="map-container">
    <h3>Bản đồ vị trí bất động sản</h3>
    <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.3602677852815!2d-122.4009425846817!3d37.79281677975801!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8085808cbd76b6bb%3A0xf1390594e40361b1!2sSalesforce%20Tower!5e0!3m2!1sen!2sus!4v1614694698710!5m2!1sen!2sus"
            width="100%"
            height="200"
            style="border:5px;"
            allowfullscreen=""
            loading="lazy"></iframe>
</div>


<div class="additional-info">
    <h3>Thông tin bổ sung</h3>
    <div class="info-container">
        <div class="info-item">
            <i class="fas fa-calendar-alt info-icon"></i>
            <span><strong>Ngày đăng:</strong> 22/10/2024</span>
        </div>
        <div class="info-item">
            <i class="fas fa-calendar-times info-icon"></i>
            <span><strong>Ngày hết hạn:</strong> 01/11/2024</span>
        </div>
        <div class="info-item">
            <i class="fas fa-info-circle info-icon"></i>
            <span><strong>Loại tin:</strong> Tin thường</span>
        </div>
        <div class="info-item">
            <i class="fas fa-hashtag info-icon"></i>
            <span><strong>Mã tin:</strong> 41288902</span>
        </div>
    </div>
</div>



<div class="related-properties" style="width:63%">
    <h3>Các sản phẩm liên quan</h3>
    <div class="related-properties-container" id="relatedProductsContainer">
        <div class="related-property">
            <img src="jpg/HCM.jpg" ; alt="Sản phẩm 1">
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
            <p style="display: flex; align-items: center;text-align: left">
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

        <div class="more-products">
            <button id="scrollLeftBtn"> <</button>
            <button id="scrollRightBtn">️ ></button>
        </div>
    </div>
</div>


<div class="copyright">
    <p>© Mọi quyền thuộc về Homelander. Mọi thông tin liên quan vui lòng liên hệ với chúng tôi.</p>
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
        padding: 10px;
        width: 100%; /* Đảm bảo hình ảnh phù hợp với kích thước chứa */
        height: auto; /* Tự động điều chỉnh chiều cao */
        border: 2px solid transparent; /* Border mặc định là trong suốt */
        border-radius: 20px; /* Bo tròn góc cho hình ảnh */
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
