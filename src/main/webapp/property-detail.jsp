<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Poster" %>
<%@ page import="Entity.Comment" %>
<%@ page import="java.util.ArrayList" %>
<!-- Thêm CKEditor từ CDN -->
<script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>

<%@ page import="Entity.Review" %>

<%@ page import="Dao.*" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<link rel="stylesheet" href="css/property-detail.css">
<meta charset="UTF-8">
<title>Property Details</title>
<head>
    <style>

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

        .heart-icon {
            position: absolute;
            bottom: 5px; /* Di chuyển trái tim xuống góc dưới */
            right: 5px; /* Đặt trái tim ở góc phải */
            z-index: 10; /* Đảm bảo trái tim nằm trên tất cả các phần tử khác */
            cursor: pointer;
            margin-bottom: 2px;
            margin-right: 10px;
        }

        .heart-icon img {
            width: 20px !important; /* Kích thước nhỏ hơn của trái tim */
            height: 20px !important; /* Kích thước nhỏ hơn của trái tim */
            transition: transform 0.3s ease, filter 0.3s ease; /* Hiệu ứng chuyển động */


        }

        .heart-icon:hover img {
            transform: scale(1.2); /* Phóng to biểu tượng trái tim khi hover */
            filter: brightness(1.5); /* Tăng độ sáng khi hover */
        }

        .floating-cart {
            position: fixed; /* Đảm bảo vị trí cố định trên trang */
            bottom: 20px; /* Khoảng cách với mép dưới trang */
            right: 20px; /* Khoảng cách với mép phải của trang */
            width: 40px !important; /* Giảm chiều rộng của biểu tượng giỏ hàng */
            height: 40px !important; /* Giảm chiều cao của biểu tượng giỏ hàng */
            background-color: transparent; /* Màu nền của biểu tượng */
            border-radius: 50%; /* Biểu tượng có hình tròn */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng nhẹ để nổi bật */
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000; /* Đảm bảo nằm trên các thành phần khác */
            cursor: pointer;
            transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu khi hover */
        }

        /* Khi hover vào floating-cart */
        .floating-cart:hover {
            background-color: transparent;
            transform: scale(1.1);
        }

        /* Style cho biểu tượng giỏ hàng (cart-icon) */
        .floating-cart .cart-icon {
            width: 40px; /* Giảm kích thước icon */
            height: 40px;
            object-fit: contain; /* Đảm bảo ảnh vừa khung mà không bị méo */
        }

        /* Hiển thị mini-cart khi hover vào floating-cart */
        .floating-cart:hover .mini-cart {
            display: block; /* Hiển thị mini-cart khi hover */
        }

        /* Style cho mini-cart */
        .mini-cart {
            display: none; /* Mặc định ẩn mini-cart */
            position: absolute;
            bottom: 80px; /* Đặt mini-cart ngay trên biểu tượng giỏ hàng */
            right: 0;
            width: 250px; /* Giảm chiều rộng của mini-cart */
            max-height: 400px; /* Giới hạn chiều cao để tránh quá dài */
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng nhẹ */
            overflow-y: auto; /* Cho phép cuộn khi nội dung quá dài */
            padding: 10px;
        }

        /* Style cho danh sách sản phẩm trong mini-cart */
        .mini-cart ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .mini-cart li {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .mini-cart li img {
            width: 40px; /* Kích thước hình ảnh nhỏ hơn */
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 10px;
        }

        .mini-cart .item-info {
            font-size: 14px;
        }

        .mini-cart .item-info h4 {
            margin: 0;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis; /* Thêm dấu "..." khi tên sách quá dài */
        }

        .item-count {
            position: absolute;
            top: 5px; /* Vị trí từ đầu biểu tượng giỏ hàng */
            right: 5px; /* Vị trí từ bên phải biểu tượng giỏ hàng */
            background-color: red; /* Màu nền */
            color: white; /* Màu chữ */
            border-radius: 50%; /* Hình tròn */
            width: 20px; /* Chiều rộng */
            height: 20px; /* Chiều cao */
            display: flex;
            justify-content: center; /* Canh giữa */
            align-items: center; /* Canh giữa */
            font-size: 12px; /* Kích thước chữ */
            font-weight: bold; /* Đậm chữ */
        }

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
        <script>
            const isLoggedIn = <%= isLoggedIn %>; // Chuyển trạng thái đăng nhập thành biến JavaScript
        </script>


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
    </div>

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
                            cartItemsContainer.innerHTML = '<li>Tin lưu trống</li>';
                        }
                    } else {
                        cartItemsContainer.innerHTML = `<li>${data.message}</li>`;
                    }
                })
                .catch(error => {
                    console.error('Error loading cart items:', error);
                    document.getElementById('cart-items').innerHTML = '<li>Đã xảy ra lỗi khi tải tin lưu.</li>';
                });
        }

    </script>

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

<div class="container" style="max-width:80% ">
    <div class="property-detail">
        <h2><%= property.getTitle() %>
        </h2>


        <img id="mainImage" class="main-image" style="border-radius: 10px"
             src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
             alt="<%= property.getTitle() %>">

        <div class="thumbnails">

            <div class="thumbnail"
                 onclick="changeMainImage('<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>')">
                <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                     style="border-radius: 10px"
                     alt="Thumbnail">
            </div>

            <%
                if (thumbnailUrls != null && !thumbnailUrls.isEmpty()) {
                    int displayedCount = Math.min(thumbnailUrls.size(), 20); // Giảm số lượng thumbnail còn lại xuống 4
                    for (int i = 0; i < displayedCount; i++) {
                        String thumbnailUrl = thumbnailUrls.get(i);
            %>
            <div class="thumbnail" onclick="changeMainImage('<%= thumbnailUrl %>')">
                <img src="<%= thumbnailUrl %>" alt="Thumbnail" style="border-radius: 10px">
            </div>
            <%
                    }
                }
            %>
        </div>
        <%
            // Lấy địa chỉ từ property
            String address2 = property.getAddress();
            String formattedAddress = address2.replace(" ", "+"); // Thay khoảng trắng bằng dấu +

            // Tạo URL nhúng Google Maps không có API key
            String mapUrl = "https://www.google.com/maps?q=" + formattedAddress + "&output=embed";
        %>
        <head>
            <style>
                /* Sử dụng flexbox để căn chỉnh biểu tượng và chữ */
                .info-item {
                    display: flex; /* Sử dụng flexbox */
                    align-items: center; /* Căn giữa theo chiều dọc */
                    padding: -15px 0; /* Khoảng cách giữa các dòng */
                }

                .info-item i {
                    margin-right: 10px; /* Khoảng cách giữa biểu tượng và chữ */
                }

                .info-item span {
                    font-size: 16px; /* Cỡ chữ */
                }
            </style>
        </head>

        <body>
        <div class="info-item">
            <i class="fas fa-map-marker-alt"></i>
            <span><%= property.getAddress() %></span>
        </div>

        <div class="info-item" style="color: darkred;">
            <i class="fas fa-money-bill-wave"></i>
            <span>
            <%
                String status = property.getStatus();
                if ("3".equals(status)) {  // Nếu status là "3" (Giá thoả thuận)
            %>
            Giá thoả thuận
            <%
            } else {  // Nếu không phải "Giá thoả thuận", hiển thị giá
            %>
            <%= property.getPrice() %>
            <%
                if ("1".equals(status)) {  // Nếu status là "1"
            %>
            tỷ
            <%
            } else if ("2".equals(status)) {  // Nếu status là "2"
            %>
            triệu
            <%
                }
            %>
            <%
                }
            %>
        </span>
        </div>

        <div class="info-item" style="color: darkred;">
            <i class="fas fa-ruler-combined"></i>
            <span><%= property.getArea() %> m²</span>
        </div>

        <div class="info-item">
            <i class="fas fa-info-circle"></i>
            <span><%= property.getDescription() %></span>
        </div>
        </body>

        </p>

        <%
            VideoDAO videoDAO = new VideoDAO();
            String videoUrl = videoDAO.getVideoUrlByPropertyId(propertyId);
        %>

        <div style="padding: 10px;margin-left: -10px">
            <!-- Nút chia sẻ Facebook -->
            <form action="https://www.facebook.com/sharer/sharer.php" method="get" target="_blank"
                  style="display:inline;">
                <input type="hidden" name="u"
                       value="http://localhost:8080/Batdongsan/property-detail.jsp?id=<%= property.getId() %>">
                <button type="submit"
                        style="background: #3b5998; color: white; padding: 10px 20px; border-radius: 5px; cursor: pointer;">
                    Chia sẻ lên Facebook
                </button>
            </form>

            <!-- Nút chia sẻ Zalo -->
            <form action="https://chat.zalo.me" method="get" target="_blank" style="display:inline;">
                <input type="hidden" name="link"
                       value="http://localhost:8080/Batdongsan/property-detail.jsp?id=<%= property.getId() %>">
                <button type="submit"
                        style="background: #0078FF; color: white; padding: 10px 20px; border-radius: 5px; cursor: pointer;">
                    Chia sẻ qua Zalo
                </button>
            </form>

            <!-- Nút xem video BĐS -->
            <% if (videoUrl != null && !videoUrl.isEmpty()) { %>
            <form action="http://localhost:8080/Batdongsan/<%= videoUrl %>" method="get" target="_blank"
                  style="display:inline;">
                <button type="submit"
                        style="background: #FF4500; color: white; padding: 15px 20px; border-radius: 5px; cursor: pointer;">
                    Xem Video về BĐS
                </button>
            </form>
            <% } else { %>
            <p style="padding-top: 10px">Chưa có video cho bất động sản này.</p>
            <% } %>
        </div>


        <%--        <p><i class=""></i><%= property.getDescription() %>--%>
        <%--        </p>--%>


        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
        <div class="alert alert-info" style="color: darkred;padding-top: 30px;font-size: 30px   "><i
                class="fas fa-info-circle"></i>
            <%= message %>
        </div>
        <%
                // Optionally remove the message after displaying it
                session.removeAttribute("message");
            }
        %>

        <form action="addToCart" method="post" style="display: inline;">
            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
            <input type="hidden" name="title" value="<%= property.getTitle() %>">
            <input type="hidden" name="price" value="<%= property.getPrice() %>">
            <input type="hidden" name="area" value="<%= property.getArea() %>">
            <input type="hidden" name="imageUrl" value="<%= property.getImageUrl() %>">
            <input type="hidden" name="address" value="<%= property.getAddress() %>">

            <!-- Heart icon as submit button -->
            <button type="submit" class="heart-icon" style="border: none; background: transparent; padding: 0;">
                <img src="jpg/heartred.png" alt="Heart Icon" class="heart-image">
                <span class="favorite-text">Bấm vào đây để lưu tin</span>
            </button>
        </form>
        <!-- Đánh giá sao -->
        <!-- Nút Xem Đánh Giá và Bình Luận -->
        <button style="padding-top: 10px;" type="button" id="toggleReviewsBtn" onclick="toggleReviews()">Xem Đánh Giá và
            Bình Luận
        </button>


        <div id="reviewsSection" style="display:none;">
            <h3 style="padding-top: 10px;">Đánh Giá và Bình Luận</h3>

            <%
                ReviewDAO reviewDAO = new ReviewDAO();
                List<Review> reviews = reviewDAO.getReviewsByPropertyId(property.getId());

                if (reviews != null && !reviews.isEmpty()) {
                    for (Review rev : reviews) {
            %>
            <div class="review">
                <p><strong>Sao:</strong> <%= rev.getRating() %> ⭐</p>
                <p><strong>Đánh giá:</strong> <%= rev.getReview() %>
                </p>
                <p><small><%= rev.getCreatedAt() %>
                </small></p>

                <!-- Hiển thị hình ảnh của đánh giá -->
                <%
                    List<String> imageUrls = reviewDAO.getImagesByReviewId(rev.getId());
                    if (imageUrls != null && !imageUrls.isEmpty()) {
                %>
                <div class="review-images-container">
                    <h4>Hình ảnh của đánh giá:</h4>
                    <div class="image-gallery">
                        <% for (String imageUrl : imageUrls) { %>
                        <div class="image-item">
                            <img src="<%= imageUrl %>" alt="Review Image" class="review-image">
                        </div>
                        <% } %>
                    </div>
                </div>
                <style>
                    .review-images-container {
                        margin-top: 20px;
                        padding: 15px;
                        background-color: #f9f9f9;
                        border-radius: 8px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .review-images-container h4 {
                        font-size: 18px;
                        margin-bottom: 10px;
                    }

                    .image-gallery {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
                        gap: 15px;
                        padding: 10px;
                    }

                    .image-item {
                        background-color: #fff;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        overflow: hidden;
                        text-align: center;
                    }

                    .review-image {
                        width: 100%;
                        height: auto;
                        object-fit: cover;
                        border-radius: 5px;
                        transition: transform 0.3s ease-in-out;
                    }

                    .review-image:hover {
                        transform: scale(1.05);
                    }

                </style>
                <%
                } else {
                %>
                <p>Không có hình ảnh cho đánh giá này.</p>
                <% } %>

                <!-- Nút Xoá Đánh Giá -->
                <form action="DeleteReviewServlet" method="post" style="display:inline;">
                    <input type="hidden" name="reviewId" value="<%= rev.getId() %>">
                    <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                    <button style="margin: 10px 10px" type="submit"
                            onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này không?')">Xoá Đánh Giá
                    </button>
                </form>
            </div>
            <%
                }
            } else {
            %>
            <p>Chưa có đánh giá nào.</p>
            <%
                }
            %>


            <div class="rating">
                <h4>Thêm Đánh Giá của Bạn</h4>
                <form action="ReviewServlet" method="post" enctype="multipart/form-data">
                    <!-- Phần đánh giá sao -->
                    <div class="stars">
                        <input type="radio" id="star5" name="rating" value="5" required><label for="star5">★</label>
                        <input type="radio" id="star4" name="rating" value="4" required><label for="star4">★</label>
                        <input type="radio" id="star3" name="rating" value="3" required><label for="star3">★</label>
                        <input type="radio" id="star2" name="rating" value="2" required><label for="star2">★</label>
                        <input type="radio" id="star1" name="rating" value="1" required><label for="star1">★</label>
                    </div>

                    <!-- Phần bình luận -->
                    <textarea name="review" id="review" placeholder="Viết bình luận của bạn..." rows="4" cols="50" required></textarea><br>

                    <!-- Phần upload ảnh -->
                    <div class="image-upload" style="margin-top: 20px;">
                        <label for="images">Chọn ảnh về bất động sản (Bạn có thể chọn nhiều ảnh):</label><br>
                        <input type="file" id="images" name="images" accept="image/*" multiple onchange="previewImages()"><br><br>
                        <div id="imagePreviewContainer" class="image-preview-container"></div>

                        <!-- Thêm Form Kéo Thả Hình Ảnh -->
                        <div class="drag-drop-upload" style="margin-top: 20px; border: 2px dashed #ccc; padding: 20px;">
                            <label for="dragAndDropImages">Hoặc kéo và thả ảnh vào đây:</label><br>
                            <input type="file" id="dragAndDropImages" name="dragAndDropImages" accept="image/*" multiple style="display:none" onchange="previewImages()">
                            <div id="dropZone" style="width: 100%; height: 150px; border: 2px dashed #aaa; text-align: center; line-height: 150px;">
                                Kéo thả ảnh vào đây
                            </div>
                            <div id="dragDropImagePreviewContainer" class="drag-drop-image-preview-container"></div>
                        </div>
                    </div>

                    <!-- Form Đăng Video -->
                    <!-- Form Đăng Video -->
                    <div class="video-upload" style="margin-top: 20px;">
                        <label for="video">Chọn video về bất động sản (Bạn có thể chọn video từ máy tính hoặc nhập URL):</label><br>
                        <!-- Chọn video từ máy tính -->
                        <input type="file" id="video" name="video" accept="video/*"><br><br>
                        <!-- Hoặc nhập URL video -->

                        <div id="videoPreviewContainer" class="video-preview-container"></div>
                    </div>

                    <script>
                        // Xử lý khi kéo ảnh vào vùng drop zone
                        var dropZone = document.getElementById('dropZone');
                        var dragAndDropInput = document.getElementById('dragAndDropImages');
                        var previewContainer = document.getElementById('imagePreviewContainer'); // Cập nhật lại container

                        // Thêm sự kiện "dragover" để cho phép thả file
                        dropZone.addEventListener('dragover', function (event) {
                            event.preventDefault();
                            dropZone.style.backgroundColor = '#f0f0f0'; // Thay đổi màu nền khi kéo vào
                        });

                        // Thêm sự kiện "dragleave" để trả lại màu nền khi kéo ra ngoài
                        dropZone.addEventListener('dragleave', function () {
                            dropZone.style.backgroundColor = ''; // Trả lại màu nền ban đầu
                        });

                        // Xử lý khi người dùng thả ảnh vào vùng drop zone
                        dropZone.addEventListener('drop', function (event) {
                            event.preventDefault();
                            dropZone.style.backgroundColor = ''; // Trả lại màu nền khi thả

                            // Lấy danh sách ảnh từ sự kiện drop
                            var files = event.dataTransfer.files;
                            previewImagesFromFiles(files);
                        });

                        // Xử lý khi người dùng chọn ảnh từ input file
                        function previewImages() {
                            var files = dragAndDropInput.files;
                            previewImagesFromFiles(files);
                        }

                        // Hàm xử lý hiển thị preview và nút xóa
                        function previewImagesFromFiles(files) {
                            previewContainer.innerHTML = ''; // Xóa ảnh cũ trước khi thêm ảnh mới

                            for (var i = 0; i < files.length; i++) {
                                var file = files[i];
                                var reader = new FileReader();

                                reader.onload = function (event) {
                                    var imgElement = document.createElement('img');
                                    imgElement.src = event.target.result;
                                    imgElement.style.width = '100px';
                                    imgElement.style.margin = '5px';
                                    imgElement.classList.add('preview-image');

                                    // Tạo nút xóa
                                    var deleteBtn = document.createElement('button');
                                    deleteBtn.innerText = 'Xóa';
                                    deleteBtn.classList.add('delete-button');
                                    deleteBtn.onclick = function () {
                                        imgElement.remove();  // Xóa ảnh
                                        deleteBtn.remove();   // Xóa nút xóa
                                    };

                                    // Thêm ảnh và nút xóa vào preview container
                                    previewContainer.appendChild(imgElement);
                                    previewContainer.appendChild(deleteBtn);
                                };

                                reader.readAsDataURL(file); // Đọc file ảnh để hiển thị
                            }
                        }

                        // Hàm xử lý video (nếu muốn hiển thị preview cho video)
                        document.getElementById('video').addEventListener('change', function (event) {
                            var file = event.target.files[0];
                            if (file) {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    var videoElement = document.createElement('video');
                                    videoElement.src = e.target.result;
                                    videoElement.controls = true;
                                    videoElement.style.width = '100px';
                                    document.getElementById('videoPreviewContainer').appendChild(videoElement);
                                };
                                reader.readAsDataURL(file);
                            }
                        });
                    </script>

                    <!-- Thêm thông tin về bất động sản -->
                    <input type="hidden" name="propertyId" value="<%= property.getId() %>">

                    <button style="margin-top:10px;" type="submit">Gửi Đánh Giá</button>
                </form>
            </div>


        </div>


        <script>
            // Hàm xem trước ảnh và xóa ảnh đã chọn
            function previewImages() {
                var files = document.getElementById('images').files;
                var previewContainer = document.getElementById('imagePreviewContainer');
                previewContainer.innerHTML = ''; // Xóa ảnh đã có trước đó

                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        var imgElement = document.createElement('img');
                        imgElement.src = e.target.result;
                        imgElement.classList.add('preview-img');

                        var closeButton = document.createElement('span');
                        closeButton.classList.add('close-btn');
                        closeButton.innerText = '×';
                        closeButton.onclick = function () {
                            removeImage(this);
                        };

                        var imageWrapper = document.createElement('div');
                        imageWrapper.classList.add('image-wrapper');
                        imageWrapper.appendChild(imgElement);
                        imageWrapper.appendChild(closeButton);

                        previewContainer.appendChild(imageWrapper);
                    };

                    reader.readAsDataURL(file);
                }
            }

            // Hàm để xóa ảnh
            function removeImage(button) {
                var imageWrapper = button.parentElement;
                imageWrapper.remove();
            }

            // Hàm để ẩn/hiện phần đánh giá
            function toggleReviews() {
                var reviewsSection = document.getElementById("reviewsSection");
                var btn = document.getElementById("toggleReviewsBtn");

                // Kiểm tra xem phần đánh giá đang hiển thị hay không và thay đổi trạng thái
                if (reviewsSection.style.display === "none") {
                    reviewsSection.style.display = "block";
                    btn.innerHTML = "Ẩn Đánh Giá và Bình Luận"; // Đổi nội dung nút
                } else {
                    reviewsSection.style.display = "none";
                    btn.innerHTML = "Xem Đánh Giá và Bình Luận"; // Đổi lại nội dung nút
                }
            }
        </script>


    </div>
    <style>
        /* Container chứa các ảnh xem trước */
        .image-preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        /* Mỗi ảnh xem trước */
        .preview-img {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        /* Wrapper chứa ảnh và dấu "x" */
        .image-wrapper {
            position: relative;
            display: inline-block;
        }

        /* Dấu "x" để xóa ảnh */
        .close-btn {
            position: absolute;
            top: 0;
            right: 0;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 5px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 50%;
        }

        .stars {
            display: flex;

            justify-content: flex-end;
        }

        .stars input[type="radio"] {
            display: none;
        }

        .stars label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
        }

        .stars input[type="radio"]:checked ~ label {
            color: #FFD700;
        }

    </style>

    <style>
        .favorite-text {
            position: absolute;
            bottom: -25px; /* Đưa văn bản xuống dưới trái tim */
            left: 50%;
            transform: translateX(-50%); /* Căn giữa văn bản với trái tim */
            visibility: hidden; /* Ẩn văn bản mặc định */
            background-color: rgba(0, 0, 0, 0.7);
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            white-space: nowrap; /* Ngừng việc gãy dòng */
            z-index: 1000; /* Đảm bảo văn bản nổi lên trên mọi phần tử khác */
        }

        .heart-icon:hover .favorite-text {
            visibility: visible; /* Hiển thị khi hover vào icon trái tim */
        }

        .container {
            max-width: 800px; /* Đặt chiều rộng tối đa cho container */
            margin: 0 auto; /* Center container */
        }

        .property-detail {
            position: relative;

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

    <%

        PosterDAO posterDAO = new PosterDAO();
        Poster poster = posterDAO.getPosterByPropertyId(Integer.parseInt(propertyId));

        if (poster == null) {
            out.println("<h2>Poster information not found</h2>");
        } else {
    %>

    <div class="sender-info">
        <h3>Thông tin người đăng</h3>
        <div class="sender-image">
            <img src="<%= poster.getImgUrl() %>" alt="Người đăng" class="sender-avatar">
        </div>
        <div class="info-box">
            <span id="sender-name"><%= poster.getName() %></span>
        </div>
        <div class="info-box">
            <span class="icon" style="margin-bottom: 12px;">✉️</span>
            <span id="sender-email"><%= poster.getMail() %></span>
        </div>
        <div class="info-box">
            <span class="icon" style="margin-bottom: 12px;">📱</span>
            <a <%= poster.getPhone() %> target="_blank" id="sender-phone">
                <%= poster.getPhone() %> (Gọi)
            </a>
        </div>
        <!-- Font Awesome Messenger -->
        <div class="info-box">
    <span class="icon" style="margin-bottom: 12px;">
        <i class="fab fa-facebook-messenger" style="font-size: 24px; color: #0078FF;"></i>
    </span>
            <a href="https://zalo.me/<%= poster.getPhone() %>" target="_blank" id="sender-zalo">
                Nhắn tin qua Zalo
            </a>
        </div>

    </div>

    <% } %>

</div>


<div class="property-features">
    <h3>Đặc điểm bất động sản</h3>
    <div class="features-container">
        <div class="features-column">
            <div class="feature-item" style="padding-left: 10px;">
                <i class="fas fa-border-all feature-icon" style="margin-left: -5px"></i>
                <span><strong> Mặt tiền:</strong> 5 m</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-road feature-icon" style="margin-left: -1px"></i>
                <span><strong> Đường vào:</strong> 10 m</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-building feature-icon"style="margin-left: 5px"></i>
                <span><strong style="margin-left: 3px"> Số tầng:</strong> 2 tầng</span>
            </div>
        </div>
        <div class="features-column">
            <div class="feature-item">
                <i class="fas fa-bed feature-icon"></i>
                <span><strong>Số phòng ngủ:</strong> 4 phòng</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-bath feature-icon"></i>
                <span><strong style="margin-left: 6px">Số toilet:</strong>2 phòng</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-file-alt feature-icon" style="margin-left:5px"></i>
                <span><strong style="margin-left:7px ">Pháp lý:</strong>.. </span>
            </div>
            <div class="feature-item">
                <i class="fas fa-couch feature-icon"></i>
                <span><strong>Nội thất:</strong> Đầy đủ</span>
            </div>
        </div>
    </div>
</div>

<div class="bottom-banner">
    <img src="jpg/bank-loan-offer-banner-web.jpg" alt="Banner quảng cáo" style="width: 100%; border-radius: 5px;">
</div>

<div class="map-container">
    <h3>Bản đồ vị trí bất động sản</h3>
    <iframe
            src="<%=mapUrl%>"
            width="100%"
            height="300"
            style="border:5px;"
            allowfullscreen=""
            loading="lazy"></iframe>
</div>


<div class="additional-info">
    <h3>Thông tin bổ sung</h3>
    <div class="info-container">
        <div class="info-item">
            <i class="fas fa-calendar-alt info-icon"></i>
            <span><strong>Ngày đăng:</strong> 31/12/2024</span>
        </div>
        <div class="info-item">
            <i class="fas fa-calendar-times info-icon"></i>
            <span><strong>Ngày hết hạn:</strong> 14/1/2025</span>
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

<%
    // Giả sử bạn đã có thông tin chi tiết của bất động sản
    // Lấy địa chỉ để tìm các sản phẩm cùng thành phố
    String address = property.getAddress();
    String[] addressParts = address.split(","); // Tách địa chỉ theo dấu phẩy
    String city = addressParts[addressParts.length - 1].trim(); // Lấy tên thành phố (phần cuối cùng)


    // Lấy các sản phẩm cùng thành phố
    PropertyDAO propertyDAO1 = new PropertyDAO();
    List<Property1> relatedProperties = propertyDAO1.getPropertiesByCity(city); // Phương thức để lấy các sản phẩm cùng thành phố
%>

<div class="related-properties" style="width:63%">
    <h3>Các bất động sản liên quan</h3>

    <div class="related-properties-container" id="relatedProductsContainer">
        <%
            if (relatedProperties != null && !relatedProperties.isEmpty()) {
                for (Property1 relatedProperty : relatedProperties) {

        %>
        <div class="related-property">
            <a href="property-detail.jsp?id=<%= relatedProperty.getId() %>"
               style="text-decoration: none; color: inherit;">

                <img src="<%= relatedProperty.getImageUrl() %>" alt="Sản phẩm <%= relatedProperty.getTitle() %>">
                <h4 class="property-title"><%= relatedProperty.getTitle() %>
                </h4>
                <style>
                    .property-title {
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        width: 100%;
                        display: block;
                        font-size: 16px;
                        line-height: 1.5;
                    }

                </style>
                <p style="display: flex; justify-content: space-between; color: red;">
                    <span style="font-size: 14px">Giá: <%= relatedProperty.getPrice() %> tỷ</span>
                    <span style="font-size: 14px">Diện tích: <%= relatedProperty.getArea() %> m²</span>
                </p>
                <p style="display: flex; align-items: center;">
                <p class="location" style="display: flex; align-items: center;">
                    <!-- Thay thế hình ảnh bằng biểu tượng Font Awesome -->
                    <i class="fas fa-map-marker-alt" style="font-size: 16px; margin-right: 5px;"></i>

                    <%
                        if (address != null && !address.isEmpty()) {
                            String[] words = address.split("\\s+");
                            int start = Math.max(words.length - 4, 0);
                            StringBuilder lastFourWords = new StringBuilder();
                            for (int i = start; i < words.length; i++) {
                                if (i > start) {
                                    lastFourWords.append(" ");  // Chỉ thêm khoảng trắng giữa các từ
                                }
                                lastFourWords.append(words[i]);
                            }
                            out.print(lastFourWords.toString());
                        }
                    %>
                </p>


            </a>
        </div>
        <%
            }
        } else {
        %>
        <p>Không có sản phẩm nào liên quan từ cùng thành phố.</p>
        <%
            }
        %>

        <div class="more-products">
            <button id="scrollLeftBtn"><i class="fas fa-chevron-left"></i></button>
            <button id="scrollRightBtn"><i class="fas fa-chevron-right"></i></button>
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

<%

    String address1 = property.getAddress();
    String[] addressParts1 = address1.split(",");
    String city1 = addressParts1[addressParts1.length - 1].trim(); // Lấy tên thành phố (phần cuối cùng)

    // Khởi tạo DAO
    PropertyDAO propertyDAO2 = new PropertyDAO();
    List<Property1> highestPriceProperties = propertyDAO2.getHighestPriceProperties(city1, 3); // Lấy 3 sản phẩm có giá cao nhất
    List<Property1> largestAreaProperties = propertyDAO2.getLargestAreaProperties(city1, 3); // Lấy 3 sản phẩm có diện tích lớn nhất
%>

<div class="related-properties" style="width:63%">
    <h3>Các bất động sản bạn có thể sẽ quan tâm</h3>
    <div class="related-properties-container" id="relatedProductsContainer1">

        <%
            for (Property1 property1 : highestPriceProperties) {
        %>
        <div class="related-property">
            <a href="property-detail.jsp?id=<%= property1.getId() %>" style="text-decoration: none; color: inherit;">

                <img src="<%= property1.getImageUrl() %>" alt="Sản phẩm <%= property1.getTitle() %>">
                <h4 class="property-title"><%=property1.getTitle() %>
                </h4>
                <style>
                    .property-title {
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        width: 100%;
                        display: block;
                        font-size: 16px;
                        line-height: 1.5;
                    }

                </style>
                <p style="display: flex; justify-content: space-between; color: red;">
                    <span style="font-size: 14px">Giá: <%= property1.getPrice() %> tỷ</span>
                    <span style="font-size: 14px">Diện tích: <%= property1.getArea() %> m²</span>
                </p>
                <p style="display: flex; align-items: center;">
                    <i class="fas fa-map-marker-alt" style="font-size: 16px; margin-right: 5px;"></i>

                    <%

                        if (address != null && !address.isEmpty()) {
                            // Tách địa chỉ thành các từ
                            String[] words = address.split("\\s+");

                            // Nếu địa chỉ có ít hơn 4 từ, lấy toàn bộ
                            int start = Math.max(words.length - 4, 0);

                            // Tạo một chuỗi để chứa 4 từ cuối
                            StringBuilder lastFourWords = new StringBuilder();
                            for (int i = start; i < words.length; i++) {
                                if (i > start) {
                                    lastFourWords.append(" ");  // Chỉ thêm khoảng trắng giữa các từ
                                }
                                lastFourWords.append(words[i]);
                            }

                            // In ra chuỗi địa chỉ đã xử lý
                            out.print(lastFourWords.toString());
                        }
                    %>
                </p>
            </a>
        </div>
        <%
            }
        %>

        <%
            for (Property1 property2 : largestAreaProperties) {
        %>
        <div class="related-property">
            <a href="property-detail.jsp?id=<%= property2.getId() %>" style="text-decoration: none; color: inherit;">

                <img src="<%= property2.getImageUrl() %>" alt="Sản phẩm <%= property2.getTitle() %>">
                <h4 class="property-title"><%=property2.getTitle() %>
                </h4>
                <style>
                    .property-title {
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        width: 100%;
                        display: block;
                        font-size: 16px;
                        line-height: 1.5;
                    }

                </style>
                <p style="display: flex; justify-content: space-between; color: red;">
                    <span style="font-size: 14px">Giá: <%= property2.getPrice() %> tỷ</span>
                    <span style="font-size: 14px">Diện tích: <%= property2.getArea() %> m²</span>
                </p>
                <p style="display: flex; align-items: center;">
                    <i class="fas fa-map-marker-alt" style="font-size: 16px; margin-right: 5px;"></i>

                    <%

                        if (address != null && !address.isEmpty()) {
                            // Tách địa chỉ thành các từ
                            String[] words = address.split("\\s+");

                            // Nếu địa chỉ có ít hơn 4 từ, lấy toàn bộ
                            int start = Math.max(words.length - 4, 0);

                            // Tạo một chuỗi để chứa 4 từ cuối
                            StringBuilder lastFourWords = new StringBuilder();
                            for (int i = start; i < words.length; i++) {
                                if (i > start) {
                                    lastFourWords.append(" ");  // Chỉ thêm khoảng trắng giữa các từ
                                }
                                lastFourWords.append(words[i]);
                            }

                            // In ra chuỗi địa chỉ đã xử lý
                            out.print(lastFourWords.toString());
                        }
                    %>
                </p>
            </a>

        </div>
        <%
            }
        %>

        <div class="more-products">
            <button id="scrollLeftBtn1"><i class="fas fa-chevron-left"></i></button>
            <button id="scrollRightBtn1"><i class="fas fa-chevron-right"></i></button>
        </div>

    </div>
</div>

<style>
    .more-products button {
        background-color: whitesmoke; /* Nền trong suốt */

        border-radius: 5px; /* Bo tròn viền */
        padding: 5px 10px; /* Điều chỉnh kích thước nút */
        font-size: 16px; /* Kích thước biểu tượng */
        cursor: pointer; /* Con trỏ chuột thành hình bàn tay khi di chuột vào */
        transition: background-color 0.3s, border-color 0.3s; /* Hiệu ứng chuyển đổi cho viền và nền */
    }

    .more-products button:hover {
        background-color: #f0f0f0; /* Màu nền khi hover */
        border-color: #007bff; /* Màu viền khi hover */
    }

    .more-products button i {
        font-size: 20px; /* Kích thước biểu tượng FontAwesome */
    }

</style>
<script>
    const container1 = document.getElementById('relatedProductsContainer1');

    document.getElementById('scrollLeftBtn1').addEventListener('click', function () {
        container1.scrollBy({
            top: 0,
            left: -200, // Cuộn 200px sang trái
            behavior: 'smooth'
        });
    });

    document.getElementById('scrollRightBtn1').addEventListener('click', function () {
        container1.scrollBy({
            top: 0,
            left: 200, // Cuộn 200px sang phải
            behavior: 'smooth'
        });
    });
</script>


<!-- Form for Adding Comments (only shown if logged in) -->
<% if (isLoggedIn) { %>
<div class="comment-section">
    <h3>Để lại bình luận của bạn:</h3>
    <form action="SubmitCommentServlet" method="POST">
        <input type="hidden" name="productId" value="<%= request.getParameter("id") %>">
        <textarea name="comment" rows="5" placeholder="Nhập bình luận của bạn..." required></textarea>
        <button type="submit">Gửi bình luận</button>
    </form>
</div>
<% } else { %>
<div class="login-prompt">
    <p style=" margin-left: 135px;margin-top: 30px">Vui lòng <a href="login.jsp">đăng nhập</a> để có thể để lại bình
        luận.</p>
</div>
<% } %>


<%
    String propertyIdParam = request.getParameter("id");
    String loggedInUsername = (String) session.getAttribute("username"); // Get logged-in username from session
    String role = (String) session.getAttribute("role"); // Get role from session
    List<Comment> comments = new ArrayList<>();

    if (propertyIdParam != null) {
        try {
            CommentDAO commentDAO = new CommentDAO();
            comments = commentDAO.getCommentsByPropertyId(propertyId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="existing-comments">
    <h3>Bình luận:</h3>

    <%
        if (comments != null && !comments.isEmpty()) {
            for (Comment comment : comments) {
                // Check if the logged-in user is the comment author (by username) or an admin
                boolean canDelete = "admin".equals(role) ||
                        (loggedInUsername != null && loggedInUsername.equals(comment.getUserName()));
    %>
    <div class="comment">
        <p>
            <strong><%= comment.getUserName() != null ? comment.getUserName() : "Unknown User" %>
            </strong>
            - <%= comment.getCommentDate() %>
                <% if (canDelete) { %>
            <!-- Show delete button if the user is admin or the comment's author -->
        <form action="DeleteCommentServlet" method="post" style="display:inline;">
            <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
            <input type="hidden" name="propertyId" value="<%= propertyIdParam %>">
            <button type="submit" onclick="return confirm('Are you sure you want to delete this comment?');">Delete
            </button>
        </form>
        <% } %>
        </p>
        <p><%= comment.getContent() %>
        </p>
    </div>
    <%
        }
    } else {
    %>
    <p>Chưa có bình luận nào.</p>
    <% } %>
</div>


</div>


<style>
    /* Styling for the comments section */
    .existing-comments {
        margin-left: 135px;
        width: 100%;
        max-width: 600px;
        margin-top: 30px;
        padding: 20px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-family: Arial, sans-serif;
    }

    .existing-comments h3 {
        font-size: 24px;
        color: #333;
        border-bottom: 2px solid #ddd;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    .comment {

        padding: 15px;
        margin-bottom: 15px;
        border-bottom: 1px solid #ddd;
    }

    .comment:last-child {
        border-bottom: none;
    }

    .comment p {
        margin: 5px 0;
        color: #333;
        line-height: 1.4;
    }

    .comment strong {
        color: #0077cc;
        font-weight: bold;
    }

    .comment .date {
        color: #999;
        font-size: 12px;
        margin-left: 10px;
    }

    .no-comments {
        font-size: 16px;
        color: #666;
        text-align: center;
        padding: 20px 0;
    }

</style>


<style>
    .comment-section {
        margin-top: 20px;
        margin-left: 135px;
        max-width: 53%;
    }

    textarea {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        padding: 10px 20px;
        color: black;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: dodgerblue;
    }

    .login-prompt p {
        color: #f00;
    }

</style>

<div class="copyright">
    <p>© Mọi quyền thuộc về Homelander. Mọi thông tin liên quan vui lòng liên hệ với chúng tôi.</p>
</div>


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


<%
    }
%>
