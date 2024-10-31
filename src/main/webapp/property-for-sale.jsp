<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/property-for-sale.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Title</title>
    <style>
        /* CSS ở đây */
        body {
            font-family: Arial, sans-serif;

        }

        .container1 {
            padding: 15px;
            margin-bottom: 30px;
            border: 1px solid black;
            width: 60%;
            border-radius: 5px;
            margin-top: 30px;
            margin-left: 135px;
            display: flex; /* Sử dụng flexbox cho cấu trúc */
            justify-content: space-between; /* Để căn giữa các phần tử */
            gap: 20px; /* Khoảng cách giữa phần nội dung và phần lọc */
        }

        .left-content {
            flex: 2; /* Chiếm 2 phần không gian */
        }

        .filter-container {
            position: absolute; /* Đặt nó tuyệt đối trong body */
            top: 440px; /* Khoảng cách từ trên xuống */
            right: 120px; /* Khoảng cách từ bên phải */
            width: 200px; /* Chiều rộng cho phần lọc */
            background-color: #f9f9f9; /* Màu nền cho phần lọc */
            padding: 15px; /* Padding cho phần lọc */
            border-radius: 10px; /* Bo góc cho phần lọc */

        }

        .price-options {
            list-style-type: none; /* Loại bỏ dấu đầu dòng */
            padding: 0; /* Xóa padding */
            margin: 10px 0; /* Margin cho danh sách */
        }

        .price-options li {
            margin-bottom: 5px; /* Khoảng cách giữa các mục */
            padding: 3px; /* Thêm padding cho mỗi mục */
            cursor: pointer; /* Chỉ con trỏ thành hình bàn tay */
            transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu */
        }

        .price-options li:hover {
            color: silver;
        }


        /* Thêm một lớp để hiển thị giá đã chọn (nếu cần) */
        .selected {
            background-color: #d4edda; /* Màu nền cho tùy chọn đã chọn */
        }

        .filter-group {
            display: flex; /* Hiển thị các nút lọc theo hàng ngang */
            gap: 10px; /* Khoảng cách giữa các nút lọc */
            margin-bottom: 20px; /* Khoảng cách dưới cùng cho nhóm nút lọc */
        }

        .filter-btn {

            padding: 10px 15px; /* Padding cho các nút lọc */
            background-color: #f0f0f0; /* Màu nền cho các nút lọc */
            border: none; /* Không có đường viền */
            cursor: pointer; /* Con trỏ chuột khi hover vào nút */
            display: flex; /* Hiển thị các nút theo hàng ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        .filter-btn i {
            margin-right: 5px; /* Khoảng cách bên phải cho biểu tượng */
        }

        .form-group {
            margin-bottom: 15px; /* Khoảng cách dưới cùng cho nhóm nhập liệu */
        }

        .filter-container1 {
            position: absolute; /* Đặt nó tuyệt đối trong body */
            top: 990px; /* Khoảng cách từ trên xuống */
            right: 120px; /* Khoảng cách từ bên phải */
            width: 200px; /* Chiều rộng cho phần lọc */
            background-color: #f9f9f9; /* Màu nền cho phần lọc */
            padding: 15px; /* Padding cho phần lọc */
            border-radius: 10px; /* Bo góc cho phần lọc */
        }

        label {
            display: block; /* Hiển thị label như một khối */
            margin-bottom: 5px; /* Khoảng cách dưới cùng cho label */
        }

        select {
            width: 100%; /* Đặt chiều rộng của select là 100% */
            padding: 8px; /* Padding cho select */
        }


    </style>
</head>
<body>
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
            <a href="post-status.jsp" class="btn"><h3>Đăng tin</h3></a>
        </div>
        <a href="#" class="floating-cart" id="floating-cart" onclick="toggleMiniCart()"
           style="border: 1px solid #ccc; border-radius:100%;">
            <img src="jpg/heart%20(1).png" style="width: 30px; height: 30px;"
                 alt="Giỏ hàng" class="cart-icon">
            <div class="item-count">0</div>
            <div class="mini-cart">
                <h4>Bất động sản đã lưu</h4>
                <ul id="cart-items"></ul>
                <button id="go-to-cart" onclick="goToCart()">Xem bất động sản đã lưu</button>
            </div>
        </a>
    </div>

    <div class="menu">
        <div class="header-bottom" style="height:60px;margin-top: 0">
            <div class="store-name">
                <h1><a href="homes">
                    <span class="color1">HOME</span>
                    <span class="color2">LANDER</span>
                </a></h1>
            </div>
            <nav>
                <ul>
                    <li><a href="property-for-sale.jsp">Nhà Đất Bán</a></li>
                    <li><a href="property-for-rent.jsp">Nhà Đất Cho Thuê</a></li>
                    <li><a href="project.jsp">Dự Án</a></li>
                    <li><a href="news.jsp">Tin Tức</a></li>
                    <li><a href="wiki.jsp">Wiki BĐS</a></li>
                </ul>
            </nav>
            <div class="contact-info">
                <img src="jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>
        </div>
    </div>
</header>
<div class="slideshow-container">
    <div class="mySlides fade">
        <img src="jpg/1.webp" alt="Banner 1">
    </div>
    <div class="mySlides fade">
        <img src="jpg/1.webp" alt="Banner 2">
    </div>
</div>
<div class="search-container">
    <form class="search-form">
        <input type="text" placeholder="Tìm kiếm..." name="search" required>

        <fieldset class="price-group">
            <legend>Giá <span class="arrow-down">▼</span></legend>
            <div class="price-dropdown hidden">
                <label for="min-price">Giá tối thiểu (tỷ):</label>
                <input type="number" id="min-price" name="min-price" placeholder="Nhập giá tối thiểu">

                <label for="max-price">Giá tối đa (tỷ):</label>
                <input type="number" id="max-price" name="max-price" placeholder="Nhập giá tối đa">
            </div>
        </fieldset>

        <fieldset class="area-group">
            <legend>Diện Tích <span class="arrow-down">▼</span></legend>
            <div class="area-dropdown hidden">
                <label for="min-area">Diện tích tối thiểu (m²):</label>
                <input type="number" id="min-area" name="min-area" placeholder="Nhập diện tích tối thiểu">

                <label for="max-area">Diện tích tối đa (m²):</label>
                <input type="number" id="max-area" name="max-area" placeholder="Nhập diện tích tối đa">
            </div>
        </fieldset>
        <button type="submit">Tìm Kiếm</button>
    </form>
</div>
<script src="JS/script.js"></script>


<div class="container1">
    <div class="left-content">
        <p class="breadcrumbs">Bán / Tất cả BĐS trên toàn quốc</p>
        <h1>Mua bán nhà đất trên toàn quốc</h1>
        <p>Hiện có <strong>181.125</strong> bất động sản.</p>
    </div>
</div>

</div>
<div class="main">
    <%
        List<Property1> properties = (List<Property1>) request.getAttribute("properties");

        if (properties != null && !properties.isEmpty()) {
    %>
    <div class="property-list">
        <%
            for (Property1 property : properties) {
        %>
        <div class="container1">
            <div class="property-container">
                <img src=" jpg/DaNang.jpg"
                     alt="Hình ảnh bất động sản" class="property-image">
                <div class="property-details">
                    <h2 class="property-title"><%= property.getTitle() %></h2>
                    <p class="property-price">Giá: <%= property.getPrice() != 0.0 ? property.getPrice() + " Tỷ" : "Đang cập nhật" %></p>
                    <p class="property-area">Diện tích: <%= property.getArea() != 0.0 ? property.getArea() + " m²" : "Đang cập nhật" %></p>
                    <p class="property-address">Địa chỉ: <%= property.getAddress() != null ? property.getAddress() : "Không xác định" %></p>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <%
    } else {
    %>
    <p>Không có bất động sản nào đang được bán.</p>
    <%
        }
    %>
</div>


<div class="filter-container">
    <h4>Lọc Theo Khoảng Giá</h4>
    <form id="priceFilterForm">
        <div class="form-group">
            <label>Chọn khoảng giá:</label>
            <ul class="price-options">
                <li data-value="thoa-thuan" class="price-option">Thỏa thuận</li>
                <li data-value="duoi-500" class="price-option">Dưới 500 triệu</li>
                <li data-value="500-800" class="price-option">500 - 800 triệu</li>
                <li data-value="800-1ty" class="price-option">800 triệu - 1 tỷ</li>
                <li data-value="1-2ty" class="price-option">1 - 2 tỷ</li>
                <li data-value="2-3ty" class="price-option">2 - 3 tỷ</li>
                <li data-value="3-5ty" class="price-option">3 - 5 tỷ</li>
                <li data-value="5-7ty" class="price-option">5 - 7 tỷ</li>
                <li data-value="7-10ty" class="price-option">7 - 10 tỷ</li>
                <li data-value="10-20ty" class="price-option">10 - 20 tỷ</li>
                <li data-value="20-30ty" class="price-option">20 - 30 tỷ</li>
                <li data-value="30-40ty" class="price-option">30 - 40 tỷ</li>
                <li data-value="40-60ty" class="price-option">40 - 60 tỷ</li>
                <li data-value="tren-60" class="price-option">Trên 60 tỷ</li>
            </ul>
        </div>
        <button type="submit">Lọc</button>
    </form>
</div>
<div class="filter-container1">
    <h4>Lọc Theo Diện Tích</h4>
    <form id="areaFilterForm">
        <div class="form-group">
            <label>Chọn diện tích:</label>
            <ul class="price-options">
                <li data-value="duoi-30" class="price-option">Dưới 30 m²</li>
                <li data-value="30-50" class="price-option">30 - 50 m²</li>
                <li data-value="50-80" class="price-option">50 - 80 m²</li>
                <li data-value="80-100" class="price-option">80 - 100 m²</li>
                <li data-value="100-120" class="price-option">100 - 120 m²</li>
                <li data-value="120-150" class="price-option">120 - 150 m²</li>
                <li data-value="150-200" class="price-option">150 - 200 m²</li>
                <li data-value="200-300" class="price-option">200 - 300 m²</li>
                <li data-value="300-400" class="price-option">300 - 400 m²</li>
                <li data-value="400-500" class="price-option">400 - 500 m²</li>
                <li data-value="tren-500" class="price-option">Trên 500 m²</li>
            </ul>
        </div>
        <button type="submit">Lọc</button>
    </form>
</div>


<style>
    /* Thiết lập form hiển thị sản phẩm */
    .property-container {
        display: flex;
        align-items: flex-start;
        border: 1px solid #ccc;
        border-radius: 8px;
        width: 100%;

        padding: 16px;

        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Thiết lập hình ảnh sản phẩm */
    .property-image {
        width: 200px;
        height: 150px;
        border-radius: 8px;
        margin-right: 16px;
        object-fit: cover;
    }

    /* Thiết lập nội dung bên phải */
    .property-details {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
        max-width: 350px;
    }

    /* Thiết lập tiêu đề sản phẩm */
    .property-title {
        font-size: 20px;
        font-weight: bold;
        margin: 0;
        color: #333;
    }

    /* Thiết lập các chi tiết sản phẩm */
    .property-price,
    .property-area,
    .property-address {
        font-size: 16px;
        margin: 0;
        color: #666;
    }

    .property-price {
        color: #e74c3c;
        font-weight: bold;
    }

</style>

<script>
    document.querySelectorAll('.price-option').forEach(item => {
        item.addEventListener('click', event => {
// Bỏ chọn tất cả các mục trước đó
            document.querySelectorAll('.price-option').forEach(option => {
                option.classList.remove('selected'); // Xóa lớp 'selected'
            });

// Thêm lớp 'selected' cho tùy chọn hiện tại
            item.classList.add('selected');

// Có thể lưu giá trị đã chọn nếu cần
            const selectedValue = item.getAttribute('data-value');
            console.log("Giá đã chọn:", selectedValue);
        });
    });
</script>


<!-- Footer -->
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
