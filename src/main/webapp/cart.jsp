<html lang="vi">
<head>
    <%@ page import="java.util.List" %>
    <%@ page import="Dao.CartItemDAO" %>
    <%@ page import="Entity.CartItem" %>
    <%@ page import="java.sql.SQLException" %>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="css/bds.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
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

        .main-content {
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        /* Container for cart items */
        .container.mt-4 {
            max-width: 1200px; /* Limit the width for larger screens */
            margin: 0 auto;
            padding: 20px;
        }

        /* List of cart items */
        .list-group {
            list-style-type: none;
            padding: 0;
        }

        /* Individual product item styling */
        .list-group-item {
            display: flex;
            align-items: center;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 15px;
            transition: transform 0.3s ease-in-out;
        }

        /* On hover, slightly enlarge the product card */
        .list-group-item:hover {
            transform: scale(1.05);
        }

        /* Styling for product image */
        .list-group-item img {
            width: 150px;  /* Larger image */
            height: 150px;  /* Maintain aspect ratio */
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        /* Styling for the description part (title, price, etc.) */
        .list-group-item div {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Title styling */
        .list-group-item h5 {
            font-size: 18px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        /* Address and area styling */
        .list-group-item p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }

        /* Price styling */
        .list-group-item .text-danger {
            font-size: 16px;
            font-weight: bold;
        }

        /* Button to remove item */
        .btn.btn-sm.btn-danger {
            margin-left: 10px;
            background-color: #d9534f;
            border: none;
            color: white;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .btn.btn-sm.btn-danger:hover {
            background-color: #a94442;
        }

        /* Checkout button styling */
        #checkout-button {
            background-color: #5cb85c;
            color: white;
            padding: 15px;
            font-size: 18px;
            border-radius: 5px;
            border: none;
            width: 100%;
            margin-top: 20px;
            cursor: pointer;
            text-align: center;
        }

        #checkout-button:hover {
            background-color: #4cae4c;
        }

        .cart-item .price, .cart-item .area {
            color: #d9534f; /* Màu đỏ */
            font-weight: bold;
        }

    </style>
</head>


<%
    Integer userId = (Integer) session.getAttribute("userId");
    List<CartItem> cartItems = null;

    if (userId != null) {
        CartItemDAO cartItemDAO = new CartItemDAO();
        try {
            cartItems = cartItemDAO.getCartItemsByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>




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
            <a href="account.jsp" class="btn">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 150px;">
                    Hello, <%= username %>
                </h3>
            </a>

            <a href="javascript:void(0)" id="logoutButton" class="btn" onclick="document.getElementById('logoutForm').submit();">
                <h3>Đăng xuất</h3>
            </a>

            <!-- Hidden Form to Logout -->
            <form id="logoutForm" action="logout" method="POST" style="display: none;">
                <button type="submit" style="display: none;"></button> <!-- This button will not be visible -->
            </form>

            <% } else { %>
            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>
            <% } %>
            <a href="post-status.html" class="btn"><h3>Đăng tin</h3></a>
        </div>


    </div>
    <div class="menu">
        <div class="header-bottom">

            <div class="store-name">
                <h1><a href="welcome">
                    <span class="color1">HOME</span>
                    <span class="color2">LANDER</span> <!-- Đổi từ VINA BOOK sang VINA BĐS -->
                </a></h1>
            </div>


            <nav>
                <ul class="u-lo">
                    <li><a href="forsale">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Bán căn hộ chung cư</a></li>
                            <li><a href="#">Bán nhà riêng</a></li>
                            <li><a href="#">Bán nhà biệt thự liền kề</a></li>
                            <li><a href="#">Bán nhà mặt phố</a></li>
                            <li><a href="#">Bán trang trại, khu nghỉ dưỡng</a></li>
                            <li><a href="#">Bán kho , nhà xưởng</a></li>
                            <li><a href="#">Bán loại bất động sản khác</a></li>
                        </ul>
                    </li>
                    <li><a href="property-for-rent.html">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Cho thuê căn hộ chung cư</a></li>
                            <li><a href="#">Cho thuê nhà riêng</a></li>
                            <li><a href="#">Cho thuê nhà biệt thự, liền kề</a></li>
                            <li><a href="#">Cho thuê nhà mặt phố</a></li>
                            <li><a href="#">Cho thuê phòng trọ , nhà trọ</a></li>
                            <li><a href="#">Cho thuê văn phòng</a></li>
                            <li><a href="#">Cho thuê loại bất động sản khác</a></li>
                        </ul>
                    </li>
                    <li><a href="project.html">Dự Án</a>
                        <ul>
                            <li><a href="#">Các dự án nổi bật</a></li>
                            <li><a href="#">Dự án nhà ở</a></li>
                            <li><a href="#">Dự án chung cư</a></li>
                        </ul>
                    </li>
                    <li><a href="news.html">Tin Tức</a>
                        <ul>
                            <li><a href="#">Tin thị trường</a></li>
                            <li><a href="#">Xu hướng bất động sản</a></li>
                            <li><a href="#">Phân tích và đánh giá</a></li>
                        </ul>
                    </li>
                    <li><a href="wiki.html">Wiki BĐS</a>
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


<body>

<div class="container mt-4">
    <h3 class="text-center mb-4">Giỏ hàng của bạn</h3>

    <ul class="list-group">
        <%
            if (cartItems != null && !cartItems.isEmpty()) {
                for (CartItem item : cartItems) {
        %>
        <li class="list-group-item d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <!-- Image is wrapped in an anchor tag for redirection -->
                <a href="property-detail.jsp?id=<%= item.getPropertyId() %>" style="cursor: pointer;">
                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getTitle() %>" class="img-thumbnail mr-3"
                         style="width: 100px; height: 100px; object-fit: cover;">
                </a>

                <div>
                    <h5 class="mb-1"><%= item.getTitle() %></h5>
                    <p class="mb-1 text-muted"><i class="fas fa-map-marker-alt"></i> Địa chỉ: <%= item.getAddress() %></p>
                    <p class="mb-1"><i class="fas fa-ruler-combined"></i> Diện tích: <strong><%= item.getArea() %> m²</strong></p>
                    <p class="mb-0 text-danger"><i class="fas fa-dollar-sign"></i> Giá: <strong><%= item.getPrice() %> tỷ</strong></p>
                </div>
            </div>

            <!-- Remove button (form to delete product) -->
            <form action="removeItemFromCart" method="POST" style="display: inline;">
                <input type="hidden" name="propertyId" value="<%= item.getPropertyId() %>">
                <button type="submit" class="btn btn-sm btn-danger ml-3" onclick="return confirm('Are you sure you want to remove this item?')">
                    <i class="fas fa-trash-alt"></i> Xóa
                </button>
            </form>
        </li>
        <%
            }
        } else {
        %>
        <li class="list-group-item text-center text-muted">Giỏ hàng của bạn đang trống.</li>
        <% } %>
    </ul>

    <button id="checkout-button" class="btn btn-success w-100 mt-3" onclick="window.location.href='checkout.jsp'">
        Đặt lịch
    </button>
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
