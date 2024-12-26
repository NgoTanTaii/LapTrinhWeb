<%@ page import="Entity.PropertyProject" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@ page import="Dao.PropertyBystatusDAO" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Dự Án</title>
    <link rel="stylesheet" href="css/bds.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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
        /* Cài đặt cơ bản */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Banner Slideshow */
        .slideshow-container {
            width: 100%;
            height: 400px; /* Chiều cao của banner */
            position: relative;
            overflow: hidden;
        }

        .slide {
            width: 100%;
            height: 100%;
            position: absolute;
            display: none;
        }

        .slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Chữ ở banner */
        .slide-caption {
            position: absolute;
            bottom: 60px;
            left: 20px;
            color: #fff;
            font-size: 2em;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px;
            border-radius: 5px;
        }

        /* Form container */
        .search-form {
            max-width: 90%;
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #f8f8f8;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);

            margin: 20px auto;
        }

        /* Search input */
        .search-input {
            display: flex;
            align-items: center;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f3f3f3;
            width: 100%;
            max-width: 500px;
            margin-right: 10px;
        }

        .search-input input {
            border: none;
            outline: none;
            background: none;
            width: 100%;
            font-size: 16px;
        }

        .search-input i {
            margin-right: 8px;
            color: #666;
        }

        /* Dropdown container */
        .filter {
            position: relative;
            margin: 0 10px;
        }

        .filter select {
            padding: 8px 12px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
            cursor: pointer;
        }

        /* Reset button */
        .reset-button {
            padding: 10px;
            border: none;
            background-color: transparent;
            cursor: pointer;
            font-size: 18px;
        }

        .reset-button:hover {
            color: #666;
        }

        .container {
            display: flex;
            gap: 20px;
            max-width: 90%;
            margin: 0 auto;
        }

        /* Phần danh sách dự án */
        .project-list {
            flex: 3;
        }

        .project-header {
            margin-bottom: 15px;
        }

        .project-header h2 {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        .project-header span {
            color: #888;
        }

        .project-item {
            display: flex;
            gap: 15px;
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            margin-bottom: 15px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            width: 100%;
            align-items: center; /* Đảm bảo phần mô tả và ảnh được căn giữa theo chiều dọc */
        }

        .main-image-container {
            position: relative;
            flex-shrink: 0; /* Đảm bảo ảnh không bị co lại */

        }

        .main-image {
            width: 210px; /* Cố định chiều rộng cho ảnh */
            height: auto;
            border-radius: 8px;
        }

        .overlay {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.6);
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
        }

        .project-details {
            flex: 1;
            text-align: left;
        }

        .project-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .project-size {
            color: #555;
            margin: 5px 0;
        }

        .project-location {
            color: #888;
            font-size: 14px;
        }

        .project-description {
            margin-top: 10px;
            color: #555;
            font-size: 14px;
        }

        /* Phần sidebar bên phải */
        .sidebar {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 85px;
        }

        .sidebar-section {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar-section h3 {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .sidebar-section a {
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
            margin-top: 10px;
            display: inline-block;
        }

        .sidebar-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .sidebar-item img {
            width: 80px;
            height: auto;
            border-radius: 8px;
            margin-right: 10px;
        }

        .sidebar-item .sidebar-text {
            font-size: 14px;
            color: #555;
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
        <div class="header-bottom" style="height:60px;margin-top: 0">
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
                    <!-- Mục Nhà Đất Hot -->
                    <li><a href="property-hot.jsp">Nhà Đất Hot</a>
                        <ul>
                            <li><a href="#">Nhà đất bán hot</a></li>
                            <li><a href="#">Nhà đất cho thuê hot</a></li>
                            <li><a href="#">Nhà đất dự án hot</a></li>
                        </ul>
                    </li>
                    <!-- Mục Nhà Đất Bán -->
                    <li><a href="forsale">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Thông tin bán nhà đất</a></li>
                            <li><a href="#">Mua bán bất động sản</a></li>
                            <li><a href="#">Nhà đất giá rẻ</a></li>
                        </ul>
                    </li>
                    <!-- Mục Nhà Đất Cho Thuê -->
                    <li><a href="forrent">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Thông tin cho thuê nhà đất</a></li>
                            <li><a href="#">Thuê nhà nguyên căn</a></li>
                            <li><a href="#">Thuê căn hộ giá rẻ</a></li>
                        </ul>
                    </li>
                    <!-- Mục Dự Án -->
                    <li><a href="Project">Dự Án</a>
                        <ul>
                            <li><a href="#">Các dự án nổi bật</a></li>
                            <li><a href="#">Dự án nhà ở</a></li>
                            <li><a href="#">Dự án chung cư</a></li>
                        </ul>
                    </li>
                    <!-- Mục Tin Tức -->
                    <li><a href="news.jsp">Tin Tức</a>
                        <ul>
                            <li><a href="#">Tin thị trường</a></li>
                            <li><a href="#">Xu hướng bất động sản</a></li>
                            <li><a href="#">Phân tích và đánh giá</a></li>
                        </ul>
                    </li>
                    <!-- Mục Wiki BĐS -->
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

<div class="slideshow-container">
    <!-- Slide 1 -->
    <div class="slide">
        <img src="jpg/20220425163231-06f2.jpg" alt="Banner 1">
        <div class="slide-caption" style="background: none">Chào mừng bạn đến với Dự Án!
            <div class="name" style="font-size: 25px"> Sun Urban City</div>
            <div class="name" style="font-size: 15px;color: blanchedalmond"> Lam Hạ, Hạ Nam</div>
        </div>

    </div>

    <!-- Slide 2 -->
    <div class="slide">
        <img src="jpg/20240313165904-e11f_wm.jpg" alt="Banner 2">
        <div class="slide-caption" style="background: none">Khám phá thêm thông tin!
            <div class="name" style="font-size: 25px"> Sun Urban City</div>
            <div class="name" style="font-size: 15px;color: blanchedalmond"> Lam Hạ, Hạ Nam</div>
        </div>
    </div>

    <!-- Slide 3 -->
    <div class="slide">
        <img src="jpg/20240730145320-0444_wm.jpg" alt="Banner 3">
        <div class="slide-caption" style=" background: none">Tham gia cùng chúng tôi!
            <div class="name" style="font-size: 25px"> Sun Urban City</div>
            <div class="name" style="font-size: 15px;color: blanchedalmond"> Lam Hạ, Hạ Nam</div>
        </div>
    </div>
</div>

<div class="search-form">
    <!-- Thanh tìm kiếm -->
    <div class="search-input">
        <i class="fa fa-search"></i> <!-- Biểu tượng tìm kiếm -->
        <input type="text" placeholder="Tìm kiếm dự án...">
    </div>

    <!-- Bộ lọc Khu vực -->
    <div class="filter">
        <select name="region">
            <option value="all">Khu vực</option>
            <option value="toanquoc">Toàn quốc</option>
            <option value="mienbac">Miền Bắc</option>
            <option value="mientrung">Miền Trung</option>
            <option value="miennam">Miền Nam</option>
        </select>
    </div>

    <!-- Bộ lọc Loại hình -->
    <div class="filter">
        <select name="type">
            <option value="all">Loại hình</option>
            <option value="canho">Căn hộ</option>
            <option value="nhapho">Nhà phố</option>
            <option value="bietthu">Biệt thự</option>
        </select>
    </div>

    <!-- Bộ lọc Mức giá -->
    <div class="filter">
        <select name="price">
            <option value="all">Mức giá</option>
            <option value="duoi1ty">Dưới 1 tỷ</option>
            <option value="1to2ty">1-2 tỷ</option>
            <option value="tren2ty">Trên 2 tỷ</option>
        </select>
    </div>

    <!-- Bộ lọc Trạng thái -->
    <div class="filter">
        <select name="status">
            <option value="all">Trạng thái</option>
            <option value="dangban">Đang bán</option>
            <option value="dangocho">Đang chờ</option>
            <option value="datban">Đã bán</option>
        </select>
    </div>

    <!-- Nút làm mới -->
    <button class="reset-button" onclick="location.reload();">
        ⟲
    </button>
</div>
<%
    // Lấy số lượng dự án từ request
    Integer projectCount = (Integer) request.getAttribute("projectCount");
    // Lấy danh sách các dự án từ request
    List<PropertyProject> projects = (List<PropertyProject>) request.getAttribute("projects");
%>

<div class="container">
    <!-- Phần danh sách dự án -->
    <div class="project-list">
        <div class="project-header">
            <h4>Dự án/ Dự án BDS toàn quốc</h4>
            <h2>Dự án toàn quốc</h2>
            <p>Hiện có <strong><%= projectCount != null ? projectCount : 0 %></strong> bất động sản.</p>
        </div>

        <div id="project-container">
            <%
                if (projects != null && !projects.isEmpty()) {
                    for (PropertyProject project : projects) {
            %>
            <div class="project-item">
                <div class="main-image-container">
                    <!-- Bọc hình ảnh trong thẻ a để khi click sẽ chuyển hướng -->
                    <a href="property-detail.jsp?id=<%= project.getId() %>">
                        <img src="<%= project.getImageUrl() %>" alt="Project Image" class="main-image">
                        <div class="overlay">+8</div>
                    </a>
                </div>
                <div class="project-details">
                    <span class="project-title"><%= project.getTitle() %></span>
                    <p class="project-size"><%= project.getArea() %> ha</p>
                    <p class="houses">1 căn hộ <i class="fas fa-house"></i></p>
                    <p class="project-location"><%= project.getAddress() %></p>

                    <%
                        // Chỉ hiển thị mô tả nếu có dữ liệu
                        if (project.getDescription() != null && !project.getDescription().isEmpty()) {
                    %>
                    <p class="project-description"><%= project.getDescription() %></p>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <p>Không có dự án nào để hiển thị.</p>
            <%
                }
            %>
        </div>
    </div>

    <div id="pagination">
        <button id="prev" onclick="changePage(-1)"> Trước</button>
        <span id="page-number">1</span>
        <button id="next" onclick="changePage(1)">Sau</button>
    </div>
</div>

<div class="sidebar">
    <!-- Đánh giá dự án -->
    <div class="sidebar-section">
        <h3>Đánh giá dự án</h3>
        <div class="sidebar-item">
            <img src="https://via.placeholder.com/80x60" alt="Review Image">
            <div class="sidebar-text">Có còn căn hộ dưới 100 triệu/m2 ở Quận 2 TP.HCM không?</div>
        </div>
        <a href="#">Xem tất cả →</a>
    </div>

    <!-- Tin tức -->
    <div class="sidebar-section">
        <h3>Tin tức</h3>
        <div class="sidebar-item">
            <img src="https://via.placeholder.com/80x60" alt="News Image">
            <div class="sidebar-text">M&A Bất động sản đang diễn ra mạnh mẽ</div>
        </div>
        <a href="#">Xem tất cả →</a>
    </div>
</div>

<script>
    // Declare variables for pagination
    let currentPage = 1;
    const itemsPerPage = 6;

    function displayItems() {
        // Get all project items
        const items = document.querySelectorAll('.project-item');
        const totalItems = items.length;

        // Calculate total pages
        const totalPages = Math.ceil(totalItems / itemsPerPage);

        // Hide all items initially
        items.forEach(item => item.style.display = 'none');

        // Calculate start and end index for the items to display
        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = Math.min(startIndex + itemsPerPage, totalItems);

        // Show items for the current page
        for (let i = startIndex; i < endIndex; i++) {
            items[i].style.display = 'flex'; // Show the item using flex
        }

        // Update the page number display
        document.getElementById('page-number').innerText = currentPage;

        // Disable the 'Previous' button if on the first page
        document.getElementById('prev').disabled = currentPage === 1;

        // Disable the 'Next' button if on the last page
        document.getElementById('next').disabled = currentPage === totalPages;
    }

    function changePage(direction) {
        const items = document.querySelectorAll('.project-item');
        const totalItems = items.length;
        const totalPages = Math.ceil(totalItems / itemsPerPage);


        currentPage += direction;

        // Keep currentPage within valid range
        if (currentPage < 1) currentPage = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        // Display items for the updated current page
        displayItems();

        // Scroll smoothly to the top of the project container
        document.getElementById('project-container').scrollIntoView({behavior: 'smooth'});
    }

    // Initial call to display the first page of items
    displayItems();
</script>
<script>
    let slideIndex = 0;
    showSlides();

    function showSlides() {
        let slides = document.getElementsByClassName("slide");
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) {
            slideIndex = 1
        }
        slides[slideIndex - 1].style.display = "block";
        setTimeout(showSlides, 3000); // Thay đổi slide mỗi 3 giây
    }
</script>
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
