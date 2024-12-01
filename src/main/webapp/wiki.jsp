<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="css/bds.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>

        /* Thiết lập cho menu chính */
        ul {
            list-style-type: none;
            padding: 0;
            margin-right: 0;
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
        }

        .news-container {
            display: flex;
            max-width: 80%;
            margin: 20px auto;
            gap: 20px;

        }

        .main-news {

            flex: 3;
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .main-news-image {
            width: 100%;
            height: 390px;
            display: block;
        }

        .main-news-content {
            position: absolute;
            bottom: 20px;
            left: 20px;
            color: white;
            background: rgba(0, 0, 0, 0.5);
            padding: 10px 15px;
            border-radius: 5px;
        }

        .date {
            font-size: 12px;
            opacity: 0.8;
        }

        .main-news-title {
            font-size: 24px;
            margin: 5px 0;
        }

        .main-news-description {
            font-size: 14px;
            line-height: 1.5;
        }

        .side-news {
            flex: 0.5;
            background-color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .most-viewed {
            flex: 0.5;
            background-color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .side-news h3, .most-viewed h3 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }

        .side-news-list, .most-viewed-list {
            list-style-type: none;
            font-size: 14px;
        }

        .side-news-list li, .most-viewed-list li {
            margin-bottom: 8px;
        }

        .side-news-list li a, .most-viewed-list li a {
            text-decoration: none;
            color: #0073e6;
            transition: color 0.2s ease;
        }

        .side-news-list li a:hover, .most-viewed-list li a:hover {
            color: #005bb5;
        }

        .articles-container {
            max-width: 54%;
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-left: 128px;
        }

        .article-item {
            display: flex;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);

        }

        .article-image {
            position: relative;
            width: 300px !important;
            height: 200px !important;

        }

        .article-image img {
            width: 180px;
            height: 250px;
            object-fit: cover;
        }

        .tag {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 5px 10px;
            font-size: 12px;
            border-radius: 5px;
        }

        .article-content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .date {
            font-size: 12px;
            color: #888;
        }

        .article-title {
            font-size: 20px;
            margin: 10px 0;
            color: #333;
        }

        .article-description {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
        }

        .tags {
            margin-top: 10px;
        }

        .tags span {
            background-color: #e9e9e9;
            color: #555;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            margin-right: 10px;
            display: inline-block;
        }

        h2 {
            font-size: 2rem;
            margin-left: 135px;
        }

        h1 {
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .grid-container {
            padding-top: 50px;
            padding-bottom: 50px;
            border-bottom: 1px solid black;
            border-top: 1px solid black;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            max-width: 1000px;
            margin: 40px auto;
        }

        .category-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: #333;
        }

        .category-icon {
            font-size: 60px;
            color: #e74c3c;
            background-color: #f9f0ef;
            border-radius: 50%;
            width: 100px;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .category-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }

        /* Responsive for smaller screens */
        @media (max-width: 768px) {
            .grid-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .grid-container {
                grid-template-columns: 1fr;
            }
        }

        .see-more {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .see-more button {
            background-color: #007bff; /* Button color */
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .see-more button:hover {
            background-color: #0056b3; /* Hover color */
        }
    </style>
</head>
<body>
<header class="header">
    <div class="header-top" style="width: 100%; position: sticky; top: 0; z-index: 1000; ">
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
            boolean isLoggedIn = session.getAttribute("username") != null;
            String username = (String) session.getAttribute("username");
        %>

        <div class="header-right" style="margin-top: 10px">
            <% if (isLoggedIn) { %>
            <a href="account.jsp" class="btn user-name-link">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 150px;">
                    Hello, <%= username %>
                </h3>
            </a>

            <a href="javascript:void(0)" id="logoutButton" class="btn logout-btn"
               onclick="document.getElementById('logoutForm').submit();">
                <h3>Đăng xuất</h3>
            </a>

            <!-- Hidden Form to Logout -->
            <form id="logoutForm" action="logout" method="POST" style="display: none;">
                <button type="submit" style="display: none;"></button> <!-- This button will not be visible -->
            </form>
            <% } else { %>
            <a href="login.jsp" class="btn">
                <h3>Đăng nhập</h3>
            </a>
            <a href="register.jsp" class="btn">
                <h3>Đăng ký</h3>
            </a>
            <% } %>
            <a href="create-poster.jsp" class="btn">
                <h3>Đăng tin</h3>
            </a>
        </div>
        <style>
            /* CSS cho hiệu ứng hover và làm nổi bật liên kết */
            .user-name-link h3 {
                display: inline-block;
                cursor: pointer; /* Thêm con trỏ tay để người dùng biết đây là liên kết có thể click */
                transition: color 0.3s ease, background-color 0.3s ease;
            }

            /* Thêm hiệu ứng hover */
            .user-name-link:hover h3 {
                color: #fff;
                background-color: wheat; /* Màu nền khi hover */
                padding: 5px 10px; /* Thêm khoảng cách để làm nổi bật */
                border-radius: 5px; /* Bo góc */
            }

        </style>


        <a href="javascript:void(0)" id="floating-cart" class="floating-cart" onclick="toggleMiniCart()"
           style="border: 1px solid #ccc; border-radius: 50%; position: fixed; bottom: 20px; right: 20px; z-index: 999; padding: 10px; background-color: white;">
            <img src="jpg/heart%20(1).png" style="width: 30px; height: 30px;" alt="Giỏ hàng" class="cart-icon">
            <div class="item-count" id="item-count"
                 style="position: absolute; top: 0; right: 0; background-color: red; color: white; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; font-size: 12px;">
                0
            </div>
            <div class="mini-cart" id="mini-cart"
                 style="display: none; position: absolute; bottom: 50px; right: 0; width: 250px; background-color: #fff; border: 1px solid #ccc; border-radius: 8px; padding: 15px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                <h4 style="margin-top: 0;">Bất động sản đã lưu</h4>
                <ul id="cart-items" style="list-style-type: none; padding: 0; margin: 10px 0;">
                    <!-- Mỗi sản phẩm có một form để xóa -->
                    <li id="mini-cart-item-1">
                        <div style="display: flex; align-items: center; margin-bottom: 10px;">

                            <form action="removeMiniCartItem" method="POST" style="display: inline;">
                                <input type="hidden" name="propertyId" value="1">
                                <button type="submit" class="btn btn-sm btn-danger ml-3"
                                        style="border: none; background-color: red; color: white; padding: 5px; border-radius: 4px; cursor: pointer;">
                                    <i class="fas fa-trash-alt"></i> Xóa
                                </button>
                            </form>
                        </div>
                    </li>
                    <!-- Thêm các mục khác tương tự với ID và giá trị khác nhau -->
                </ul>
                <button id="go-to-cart" onclick="goToCart()"
                        style="width: 100%; padding: 10px; background-color: #007bff; color: #fff; border: none; border-radius: 4px; cursor: pointer;">
                    Đi tới xem bất động sản đã lưu
                </button>
            </div>
        </a>

        <script>
            // Tự động tải số lượng sản phẩm trong giỏ hàng khi trang được tải
            document.addEventListener("DOMContentLoaded", function () {
                loadCartCount(); // Gọi hàm để tải số lượng mục trong giỏ hàng
            });

            // Toggle Mini Cart visibility
            function toggleMiniCart() {
                var miniCart = document.getElementById('mini-cart');
                if (miniCart.style.display === 'none' || miniCart.style.display === '') {
                    miniCart.style.display = 'block';
                    loadCartItems(); // Load cart items khi mở mini-cart
                } else {
                    miniCart.style.display = 'none';
                }
            }

            // Hàm tải số lượng sản phẩm trong giỏ hàng
            function loadCartCount() {
                fetch('http://localhost:8080/Batdongsan/getMiniCart', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            document.getElementById('item-count').innerText = data.itemCount;
                        } else {
                            document.getElementById('item-count').innerText = 0;
                        }
                    })
                    .catch(error => {
                        console.error('Error loading cart count:', error);
                        document.getElementById('item-count').innerText = 0;
                    });
            }

            // Redirect to Cart Page
            function goToCart() {
                window.location.href = 'cart.jsp';  // Thay đổi nếu cần
            }

            // Load Cart Items via AJAX
            function loadCartItems() {
                fetch('http://localhost:8080/Batdongsan/getMiniCart', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then(response => response.json())
                    .then(data => {
                        const cartItemsContainer = document.getElementById('cart-items');
                        cartItemsContainer.innerHTML = '';

                        if (data.success) {
                            document.getElementById('item-count').innerText = data.itemCount;

                            if (data.cartItems.length > 0) {
                                data.cartItems.forEach(item => {
                                    const li = document.createElement('li');
                                    li.id = `cart-item-${item.propertyId}`;

                                    li.innerHTML = `
                            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                <img src="${item.imageUrl}" alt="${item.title}" class="cart-item-image" style="width: 50px; height: 50px; margin-right: 10px;">
                                <div>
                                    <h5>${item.title}</h5>
                                    <p style="color:darkred">Giá: ${item.price} tỷ</p>
                                    <p style="color:darkred">Diện tích: ${item.area} m²</p>
                                    <p>Địa chỉ: ${item.address}</p>
                                    <p>Số lượng: ${item.quantity}</p>
                 <!-- Form xóa sản phẩm -->
<form action="removeMiniCartItem" method="POST" style="display: inline;">
    <input type="hidden" name="propertyId" value="${item.propertyId}">
    <button type="submit" class="btn btn-sm btn-danger ml-3" style="border: none; background-color: red; color: white; padding: 5px; border-radius: 4px; cursor: pointer;">
        <i class="fas fa-trash-alt"></i> Xóa
    </button>
</form>


                                </div>
                            </div>
                        `;
                                    cartItemsContainer.appendChild(li);
                                });
                            } else {
                                cartItemsContainer.innerHTML = '<li>Giỏ hàng trống</li>';
                            }
                        } else {
                            cartItemsContainer.innerHTML = `<li>${data.message}</li>`;
                        }
                    })
                    .catch(error => {
                        console.error('Error loading cart items:', error);
                        document.getElementById('cart-items').innerHTML = '<li>Đã xảy ra lỗi khi tải giỏ hàng.</li>';
                    });
            }

        </script>
    </div>
    <div class="menu">
        <div class="header-bottom" style="height:60px;margin-top: 0;border-bottom: 1px solid black
">

            <div class="store-name">
                <h1>
                    <a href="<%= isLoggedIn ? "welcome" : "homes" %>">
                        <span class="color1">HOME</span>
                        <span class="color2">LANDER</span>
                    </a>
                </h1>
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


</header>
<div class="main-content" style="text-align: center;width: 60%;margin-top: 30px;margin-left: 20% ">
    <h1>
        Wiki BĐS</h1>
    <p>Wiki bất động sản là cẩm nang đáp ứng tất cả nhu cầu của người tìm kiếm thông tin bất động sản bao gồm các chỉ
        dẫn mua-bán, đầu tư, thuê và cho thuê; các thông tin về tài chính, pháp lý, quy hoạch v.v…</p>
</div>


<div class="news-container">
    <!-- Main Featured News -->
    <div class="main-news">
        <img src="jpg/DongNai.jpg" alt="Main News Image" class="main-news-image">
        <div class="main-news-content">
            <p class="date">28/10/2024 08:03 • Tin tức</p>
            <h2 class="main-news-title">M&A Bất Động Sản Đang Diễn Biến Sôi Động Trong Năm 2024</h2>
            <p class="main-news-description">
                Thị trường bất động sản Việt Nam trong 9 tháng đầu năm 2024 chứng kiến sự bùng nổ mạnh mẽ của hoạt động
                M&A bất động sản...
            </p>
        </div>
    </div>

    <!-- Side News Articles -->
    <div class="side-news">
        <h3>Bài viết mới nhất</h3>
        <ul class="side-news-list">
            <li><a href="#">Đất Nền Vành Đai 4 “Nổi Sóng” Cuối Năm 2024</a></li>
            <li><a href="#">Căn Hộ Nhật Bản Đa Phong Cách TT AVIO - Lối Sống Đẳng Cấp, Hiện Đại</a></li>
            <li><a href="#">Eurowindow River Park - Cơ Hội Vàng Để Sở Hữu Căn Hộ Chung Cư Đáng Sống Tại Hà Nội</a></li>
        </ul>
    </div>

    <!-- Most Viewed Articles -->
    <div class="most-viewed">
        <h3>Bài viết được xem nhiều nhất</h3>
        <ol class="most-viewed-list">
            <li><a href="#">Trọn Bộ Lãi Suất Vay Mua Nhà Mới Nhất Tháng 10/2024</a></li>
            <li><a href="#">Thị Trường BĐS Tháng 9/2024: Giảm Mạnh Lượt Tìm Kiếm Do Báo Yagi?</a></li>
            <li><a href="#">Thị Trường BĐS TP.HCM Tháng 7/2024: Khởi Sắc Trở Lại</a></li>
        </ol>
    </div>
</div>
<h2>Chuyên Mục</h2>
<div class="grid-container">
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-search-location"></i>
        </div>
        <div class="category-title">Mua BĐS</div>
    </a>
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-sign"></i>
        </div>
        <div class="category-title">Bán BĐS</div>
    </a>
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-building"></i>
        </div>
        <div class="category-title">Thuê BĐS</div>
    </a>
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-money-bill-wave"></i>
        </div>
        <div class="category-title">Tài chính BĐS</div>
    </a>
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-gavel"></i>
        </div>
        <div class="category-title">Quy hoạch - Pháp lý</div>
    </a>
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-couch"></i>
        </div>
        <div class="category-title">Nội - Ngoại thất</div>
    </a>
    <a href="#" class="category-item">
        <div class="category-icon">
            <i class="fas fa-yin-yang"></i>
        </div>
        <div class="category-title">Phong thủy</div>
    </a>
</div>

<div class="articles-container">
    <h1>Cẩm nang Wiki BĐS mới nhất</h1>
    <div class="article-item">

        <div class="article-image">
            <img src="jpg/DaNang.jpg" alt="Article Image">
            <div class="tag">TIN TỨC</div>
        </div>
        <div class="article-content">
            <p class="date">25/10/2024 15:48 • Hải Âu</p>
            <h2 class="article-title">Thị Trường BĐS Tháng 9/2024: Giảm Mạnh Lượt Tìm Kiếm Do Báo Yagi?</h2>
            <p class="article-description">
                Những thông tin mới nhất về thị trường bất động sản tháng 9/2024 từ dữ liệu thị trường của
                Batdongsan.com.vn: giá bán, nguồn cung và mức độ quan tâm tìm kiếm...
            </p>
            <div class="tags">
                <span>Báo cáo thị trường Batdongsan.com.vn</span>
                <span>Diễn biến thị trường BĐS 2024</span>
            </div>
        </div>
    </div>
</div>

<div class="see-more">
    <button onclick="loadMoreNews()">Xem Thêm</button>
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

</body>
</html>