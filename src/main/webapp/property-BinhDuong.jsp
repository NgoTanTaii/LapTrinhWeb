<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
        <%
            Integer userId = (Integer) session.getAttribute("userId");
            String username = (String) session.getAttribute("username");
            boolean isLoggedIn = userId != null;
        %>

        <div class="header-right" style="margin-top: 10px">
            <% if (isLoggedIn) { %>
            <a href="account.jsp" class="btn">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 150px;">
                    Hello, <%= username %>
                </h3>
            </a>

            <a href="javascript:void(0)" id="logoutButton" class="btn"
               onclick="document.getElementById('logoutForm').submit();">
                <h3>Đăng xuất</h3>
            </a>

            <!-- Hidden Form to Logout -->
            <form id="logoutForm" action="logout" method="POST" style="display: none;">
                <button type="submit" style="display: none;"></button> <!-- This button will not be visible -->
            </form>

            <% } else { %>
            <!-- Display login and registration options if not logged in -->
            <a href="login.jsp" class="btn">
                <h3>Đăng nhập</h3>
            </a>
            <a href="register.jsp" class="btn">
                <h3>Đăng ký</h3>
            </a>
            <% } %>

            <!-- "Post Status" button, visible to both logged-in and non-logged-in users -->
            <a href="post-status.jsp" class="btn">
                <h3>Đăng tin</h3>
            </a>
        </div>

    </div>

    <a href="#" class="floating-cart" id="floating-cart" onclick="toggleMiniCart()"
       style="border: 1px solid #ccc; border-radius:100%;">
        <img src="jpg/heart%20(1).png" style="width: 30px!important; height: 30px !important;" alt="Giỏ hàng"
             class="cart-icon">
        <div class="item-count">0</div>
        <div class="mini-cart">
            <h4>Bất động sản đã lưu</h4>
            <ul id="cart-items"></ul>
            <button id="go-to-cart" onclick="goToCart()">Đi tới xem bất động sản đã lưu</button>
        </div>
    </a>


    <div class="menu">
        <div class="header-bottom">

            <div class="store-name">
                <h1><a href="">
                    <span class="color1">HOME</span>
                    <span class="color2">LANDER</span> <!-- Đổi từ VINA BOOK sang VINA BĐS -->
                </a></h1>
            </div>


            <nav>
                <ul class="u-lo">
                    <li><a href="forsale">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Thông tin bán nhà đất</a></li>
                            <li><a href="#">Mua bán bất động sản</a></li>
                            <li><a href="#">Nhà đất giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="forrent">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Thông tin cho thuê nhà đất</a></li>
                            <li><a href="#">Thuê nhà nguyên căn</a></li>
                            <li><a href="#">Thuê căn hộ giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="Project">Dự Án</a>
                        <ul>
                            <li><a href="#">Các dự án nổi bật</a></li>
                            <li><a href="#">Dự án nhà ở</a></li>
                            <li><a href="#">Dự án chung cư</a></li>
                        </ul>
                    </li>
                    <li><a href="news.jsp">Tin Tức</a>
                        <ul>
                            <li><a href="#">Tin thị trường</a></li>
                            <li><a href="#">Xu hướng bất động sản</a></li>
                            <li><a href="#">Phân tích và đánh giá</a></li>
                        </ul>
                    </li>
                    <li><a href="wiki.jsp">Wiki BĐS</a>
                        <ul>
                            <li><a href="#">Mua bán</a></li>
                            <li><a href="#">Cho thuê</a></li>
                            <li><a href="#">Tài chính</a></li>
                            <li><a href="#">Phong thủy</a></li>
                        </ul>
                    </li>
                </ul>

            </nav>


            <div class="contact-info">
                <img src="jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>

        </div>
    </div>


    <div class="slideshow-container">
        <div class="mySlides fade">
            <img src="jpg/1%20(1).webp" alt="Banner 1">
        </div>
        <div class="mySlides fade">
            <img src="jpg/1%20(1).webp" alt="Banner 2">
        </div>

    </div>



    <div class="search-container">
        <form class="search-form" id="search-form" method="post" action="SearchServlet">
            <input type="text" id="search" placeholder="Tìm kiếm sản phẩm..." name="search" required>
            <input type="text" id="city" placeholder="Tìm kiếm theo địa chỉ..." name="city">
            <button type="submit">Tìm Kiếm</button>
        </form>
    </div>
    <script>
        function toggleDropdown(dropdownClass) {
            const dropdown = document.querySelector(`.${dropdownClass}`);
            dropdown.classList.toggle('hidden');
        }
    </script>

    <script src="JS/script.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Khi người dùng gõ vào ô tìm kiếm hoặc ô địa chỉ, thực hiện tìm kiếm ngay lập tức
            $('#search, #city').on('keyup', function () {
                // Lấy giá trị của các trường tìm kiếm
                var searchText = $('#search').val();
                var city = $('#city').val();

                // Kiểm tra nếu ô tìm kiếm không trống mới gửi yêu cầu Ajax
                if (searchText.length > 0 || city.length > 0) {
                    $.ajax({
                        url: 'SearchServlet',  // Địa chỉ servlet xử lý tìm kiếm
                        type: 'POST',
                        data: {
                            search: searchText,
                            city: city
                        },
                        success: function (response) {
                            // Hiển thị kết quả trả về trong phần product-list
                            $('#search-results').html(response);
                        },
                        error: function () {
                            $('#search-results').html('<p>Lỗi trong quá trình tìm kiếm.</p>');
                        }
                    });
                } else {
                    // Nếu không có gì để tìm kiếm, xóa kết quả hiển thị
                    $('#search-results').html('');
                }
            });
        });

    </script>
</header>

<div class="container1">
    <div class="left-content">
        <p class="breadcrumbs">Bán / Tất cả BĐS tại Bình Dương</p>
        <h1>Mua bán nhà đất tại Bình Dương giá rẻ mới nhất T10/2024</h1>
        <p>Hiện có <strong>181.125</strong> bất động sản.</p>

        <div class="filter-group">
            <button class="filter-btn">
                <i class="fas fa-map-marker-alt"></i> Bản đồ
            </button>
            <button class="filter-btn">
                <i class="fas fa-user-tie"></i> Môi giới chuyên nghiệp
                <label class="switch">
                    <input type="checkbox">
                    <span class="slider round"></span>
                </label>
            </button>
            <button class="filter-btn">
                <i class="fas fa-check-circle"></i> Tin xác thực
                <label class="switch">
                    <input type="checkbox">
                    <span class="slider round"></span>
                </label>
            </button>
            <button class="filter-btn">
                Thông thường <i class="fas fa-chevron-down"></i>
            </button>
        </div>
    </div>

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


<script src="JS/script.js"></script>
<div class="container">

    <div class="image-gallery">

        <div class="large-image">
            <img src="jpg/HCM.jpg" alt="Hình ảnh lớn">
        </div>


        <div class="small-images">
            <div class="small-image">
                <img src="jpg/binhduong.jpg" alt="Hình ảnh nhỏ 1">
            </div>
            <div class="small-image with-overlay">
                <img src="jpg/binhduong.jpg" alt="Hình ảnh nhỏ 2">
                <div class="overlay">+5</div> <!-- Thông báo số ảnh còn lại -->
            </div>
        </div>

    </div>
    <div class="listing-container">
        <div class="listing-header">
            <h2>CAM KẾT LẤY CĂN THE SENIQUE CAPITALAND CK KHỦNG 13% - BOOKING TRỰC TIẾP CĐT 1N,2N,3N,4N TỪ 68TR/M2</h2>
            <p class="listing-info">
                <span>Giá thỏa thuận</span> ·
                <span>54 m²</span> ·
                <span>2 <i class="fas fa-bed"></i></span> ·
                <span>2 <i class="fas fa-bath"></i></span> ·
                <span>Thủ Đức,Hồ Chí Minh</span>
            </p>
            <p class="listing-description">
                Giỏ hàng KĐT Vạn Phúc T10/2024 nhà có thang máy 5x21m 19tỷ 5x22 19.5 tỷ (Đường rộng 20m),7x20m 26tỷ
            </p>
        </div>

        <div class="listing-footer">
            <div class="agent-info">
                <img src="https://via.placeholder.com/50" alt="Agent" class="agent-avatar">
                <div class="agent-details">
                    <p class="agent-name"> Cẩm Tiên</p>
                    <p class="posting-time">Đăng hôm nay</p>
                </div>
            </div>

            <div class="contact-info">
                <button class="show-number">
                    <i class="fas fa-phone"></i> 0962 852 *** • Hiện số
                </button>
                <button class="save-favorite">
                    <i class="far fa-heart"></i> <!-- Sử dụng "far" thay vì "fas" để có trái tim không màu -->
                </button>

            </div>
        </div>
    </div>


</div>



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
<style>

    .footer {
        background-color: whitesmoke;
        color: black;
        padding: 30px 50px; /* Thêm padding cho lề trái và phải */
    }

    /* Căn chỉnh các phần trong footer content thành một hàng */
    .footer-content {
        display: flex;
        justify-content: space-between; /* Giãn cách đều giữa các phần tử */
        align-items: flex-start; /* Căn chỉnh các phần tử theo chiều dọc */
        flex-wrap: wrap; /* Cho phép xuống dòng khi cần thiết trên màn hình nhỏ */
    }


    /* Căn chỉnh mỗi phần tử trong footer */
    .footer-content > div {
        flex: 1;
        margin-right: 20px;
        min-width: 200px; /* Đảm bảo mỗi phần có ít nhất 200px */
        display: flex;
        flex-direction: column;
        justify-content: flex-start; /* Căn theo chiều dọc */
        align-items: flex-start; /* Căn chỉnh nội dung theo lề trái */
    }

    .footer-content > div:last-child {
        margin-right: 0;
    }

    /* Các phần trong footer */
    .company-info, .quick-links, .social-media, .newsletter {
        margin-bottom: 15px;
    }

    .quick-links ul li a:hover,
    .social-media a:hover {
        color: darkred; /* Màu khi hover vào liên kết */

    }

    h3 {
        margin-bottom: 10px;
        color: black;
    }

    ul {
        list-style-type: none;
        padding: 0;
        margin-right: 0;
        border-radius: 10px;
    }

    .u-lo li {
        position: relative;
        display: inline-block;
        margin-right: 20px;
        z-index: 10; /* Đảm bảo menu cha hiển thị trên cùng */
    }

    ul li a {
        text-decoration: none;
        display: inline-block;
        color: #333;
    }

    /* Thiết lập cho menu con */
    ul li ul {
        display: none; /* Ẩn menu con mặc định */
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #f9f9f9;
        min-width: 200px;
        padding: 10px 0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 999; /* Đảm bảo menu con hiển thị trên các phần tử khác */
    }

    ul li ul li {
        display: block;
        margin: 0;
    }

    ul li ul li a {
        padding: 10px 15px;
        color: #333;
        display: block;
    }

    /* Hiển thị menu con khi hover */
    ul li:hover ul {
        display: block;
    }

    /* Style cho menu con khi hover */
    ul li ul li a:hover {
        background-color: #eee;
        text-decoration: none;
    }

    .social-media a {
        margin-right: 10px;
        color: black;
    }

    /* Form nhập email */
    .newsletter form {
        display: flex;
        flex-direction: row;
        gap: 10px;
        align-items: center;
    }

    .newsletter input[type="email"] {
        padding: 8px;
        font-size: 14px;
        width: 220px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    .newsletter input[type="email"]:focus {
        border-color: #f4a261;
    }

    .newsletter button {
        padding: 8px 15px; /* Làm cho nút nhỏ hơn */
        font-size: 13px; /* Giảm kích thước chữ */
        background-color: #f4a261;
        border: none;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
    }

    .newsletter button:hover {
        background-color: #e38e3e;
    }

    /* Responsive design */
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            align-items: flex-start;
        }

        .footer-content > div {
            margin-right: 0;
            margin-bottom: 20px;
        }

        .newsletter form {
            flex-direction: column;
            align-items: flex-start;
        }

        .newsletter input[type="email"] {
            width: 100%;
        }

        .newsletter button {
            width: 100%;
        }
    }

    .footer-bottom {
        text-align: center;
        margin-top: 20px;
        font-size: 18px;
        color: black;
    }

</style>
<script>

    let cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    let miniCartVisible = false; // Biến theo dõi trạng thái hiển thị của giỏ hàng

    // Hàm thêm bất động sản vào giỏ hàng
    function addToFavorites(id, title, price, area, imageUrl, address) {
        const existingProductIndex = cartItems.findIndex(item => item.id === id);

        if (existingProductIndex !== -1) {
            alert("bất động sản này đã được quan tâm!"); // Thông báo cho người dùng
        } else {
            const product = {
                id: id,
                title: title,
                price: parseFloat(price),
                area: area,
                imageUrl: imageUrl,
                address: address,
                quantity: 1 // Số lượng cố định là 1
            };
            cartItems.push(product);
            updateSessionStorage();
            updateCartDisplay();
            showMiniCart();
        }
    }

    // Cập nhật sessionStorage
    function updateSessionStorage() {
        sessionStorage.setItem('cartItems', JSON.stringify(cartItems));
    }

    // Cập nhật hiển thị giỏ hàng
    function updateCartDisplay() {
        const itemCount = document.querySelector('.item-count');
        const cartList = document.getElementById('cart-items');

        cartList.innerHTML = '';

        if (cartItems.length === 0) {
            cartList.innerHTML = '<li>Bạn chưa có bất động sản đã lưu.</li>';
            itemCount.innerText = 0; // Cập nhật số lượng sản phẩm
            return; // Kết thúc hàm nếu giỏ hàng trống
        }

        cartItems.forEach((item) => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `
            <img src="${item.imageUrl}" alt="${item.title}" width="40" height="40">
            <div class="item-info">
                <h4>${item.title}</h4>
                <p>Địa chỉ: ${item.address}</p>
                <p>Diện tích: ${item.area} m²</p>
                <span>Giá: ${item.price.toLocaleString()} tỷ</span>

            </div>
            <button onclick="removeFromCart('${item.id}')">Xóa</button>
        `;
            cartList.appendChild(listItem);
        });

        itemCount.innerText = cartItems.length; // Cập nhật số lượng sản phẩm
    }

    // Xóa sản phẩm khỏi giỏ hàng
    function removeFromCart(id) {
        cartItems = cartItems.filter(item => item.id !== id);
        updateSessionStorage();
        updateCartDisplay();
    }

    // Hiện giỏ hàng mini
    function showMiniCart() {
        const miniCart = document.querySelector('.mini-cart');
        miniCart.style.display = 'block';
        updateCartDisplay();
    }

    // Chuyển hướng đến trang giỏ hàng
    function goToCart() {
        const isLoggedIn = sessionStorage.getItem('isLoggedIn'); // Giả sử bạn kiểm tra trạng thái đăng nhập ở đây

        if (!isLoggedIn) {
            alert("Bạn cần đăng nhập để xem bất động sản đã quan tâm."); // Thông báo cho người dùng
            window.location.href = 'login.jsp'; // Chuyển hướng đến trang đăng nhập
        } else {
            window.location.href = 'cart.jsp'; // Chuyển hướng đến trang giỏ hàng
        }
    }

    // Cập nhật hiển thị giỏ hàng khi tải lại trang
    updateCartDisplay();

    function toggleMiniCart() {
        const miniCart = document.querySelector('.mini-cart');
        miniCartVisible = !miniCartVisible; // Chuyển đổi trạng thái hiển thị
        miniCart.style.display = miniCartVisible ? 'block' : 'none'; // Cập nhật hiển thị
        updateCartDisplay(); // Cập nhật hiển thị giỏ hàng
    }


</script>
<style>
    .footer-top {
        display: flex; /* Sử dụng flexbox để căn chỉnh */
        justify-content: space-around; /* Giãn cách đều giữa các mục */
        padding: 10px 0; /* Khoảng cách trên và dưới */
        margin-bottom: 20px; /* Khoảng cách dưới để tách khỏi nội dung footer */
        text-align: center; /* Căn giữa nội dung */

    }

    .footer-top h1 a {
        text-decoration: none;


    }

    .footer-item {
        margin: 0 15px; /* Khoảng cách giữa các mục */
        font-weight: bold; /* Chữ đậm */
    }

    /* Các phần khác của footer giữ nguyên */
    .footer {
        margin-top: 30px;
        background-color: whitesmoke;
        color: black;
        padding: 30px 50px;
    }

    .footer-content {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        flex-wrap: wrap;
    }

    .footer-content > div {
        flex: 1;
        margin-right: 20px;
        min-width: 200px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
    }

    .footer-content > div:last-child {
        margin-right: 0;
    }

    .company-info, .quick-links, .social-media, .newsletter {
        margin-bottom: 15px;
    }

    .quick-links ul li a:hover,
    .social-media a:hover {
        color: darkred;
    }

    h3 {
        margin-bottom: 10px;
        color: black;
    }

    ul {
        padding-left: 20px;
        color: black;
    }

    ul li {
        list-style: none;
        color: black;
    }

    ul li a {
        text-decoration: none;
        color: black;
    }

    .social-media a {
        margin-right: 10px;
        color: black;
        text-decoration: none;
    }

    .newsletter form {
        display: flex;
        flex-direction: row;
        gap: 10px;
        align-items: center;
    }

    .newsletter input[type="email"] {
        padding: 8px;
        font-size: 14px;
        width: 220px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    .newsletter input[type="email"]:focus {
        border-color: #f4a261;
    }

    .newsletter button {
        padding: 8px 15px;
        font-size: 13px;
        background-color: #f4a261;
        border: none;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
    }

    .newsletter button:hover {
        background-color: #e38e3e;
    }

    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            align-items: flex-start;
        }

        .footer-content > div {
            margin-right: 0;
            margin-bottom: 20px;
        }

        .newsletter form {
            flex-direction: column;
            align-items: flex-start;
        }

        .newsletter input[type="email"] {
            width: 100%;
        }

        .newsletter button {
            width: 100%;
        }
    }

    .footer-bottom {
        text-align: center;
        margin-top: 20px;
        font-size: 18px;
        color: black;
    }

    .heart-container {
        position: relative;
        display: inline-block;
        padding-top: 1px;
    }

    .heart-icon1 {
        width: 15px; /* Kích thước của biểu tượng trái tim */
        height: 15px;
        cursor: pointer;
    }

    /* Định dạng dòng chữ "Tin đăng đã lưu" */
    .hover-text {
        position: absolute;
        top: 30px; /* Điều chỉnh vị trí theo ý muốn */
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.7); /* Màu nền của dòng chữ */
        color: #fff;
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 14px;
        white-space: nowrap;
        opacity: 0; /* Ẩn dòng chữ */
        transition: opacity 0.3s ease; /* Hiệu ứng hiển thị mượt */
        pointer-events: none; /* Vô hiệu hóa sự kiện trên hover-text */
    }

    /* Khi hover vào biểu tượng trái tim, hiển thị dòng chữ */
    .heart-container:hover .hover-text {
        opacity: 1;
    }
</style>



</body>
</html>
