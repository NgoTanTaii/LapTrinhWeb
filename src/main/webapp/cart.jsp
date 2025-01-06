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
            width: 150px; /* Larger image */
            height: 150px; /* Maintain aspect ratio */
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

        .title-cart {
            display: flex;
            justify-content: space-between; /* Đẩy các phần tử ra hai đầu */
            align-items: center; /* Căn giữa các phần tử theo chiều dọc */
            gap: 10px; /* Khoảng cách giữa các phần tử */
            margin-bottom: 20px;
        }

        .title-cart h3 {
            margin: 0; /* Bỏ margin để tránh khoảng cách không mong muốn */
            font-size: 20px; /* Cỡ chữ của tiêu đề */
        }

        .title-cart .btn {
            width: auto; /* Đảm bảo nút không chiếm hết chiều rộng */
            padding: 10px 20px; /* Đảm bảo kích thước nút phù hợp */
        }

        .hire-agent-btn {
            display: inline-block; /* Hiển thị dưới dạng khối nội tuyến */
            padding: 12px 20px; /* Khoảng cách bên trong nút */
            background-color: darkred; /* Màu nền của nút */
            color: #fff; /* Màu chữ trắng */
            font-size: 16px; /* Kích thước chữ */
            text-align: center; /* Căn giữa nội dung của nút */
            text-decoration: none; /* Bỏ gạch dưới mặc định của thẻ a */
            border-radius: 5px; /* Bo góc cho nút */
            transition: background-color 0.3s, transform 0.2s; /* Thêm hiệu ứng chuyển màu và hiệu ứng nhấn */
            cursor: pointer; /* Thay đổi con trỏ thành dạng tay khi hover */
        }

        /* Khi người dùng hover (di chuột qua) */
        .hire-agent-btn:hover {

            background-color: #0056b3; /* Màu nền thay đổi khi hover */
            transform: scale(1.05); /* Tăng kích thước nút khi hover */
        }

        /* Khi người dùng click (nhấn vào) */
        .hire-agent-btn:active {
            background-color: #004085; /* Màu nền khi nút bị nhấn */
            transform: scale(1); /* Quay lại kích thước bình thường */
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


<body>

<div class="container mt-4">
    <div class="title-cart">
        <h3 class="text-center mb-4">Tin đã lưu của bạn</h3>
        <a href="agent.jsp" class="hire-agent-btn">Thuê người môi giới</a> <!-- Liên kết tới agent.jsp -->

    </div>
    <ul class="list-group">
        <%
            boolean hasItemsInCart = cartItems != null && !cartItems.isEmpty();
            if (hasItemsInCart) {
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
                    <h5 class="mb-1"><%= item.getTitle() %>
                    </h5>
                    <p class="mb-1 text-muted"><i class="fas fa-map-marker-alt"></i> Địa chỉ: <%= item.getAddress() %>
                    </p>
                    <p class="mb-1"><i class="fas fa-ruler-combined"></i> Diện tích: <strong><%= item.getArea() %>
                        m²</strong></p>
                    <p class="mb-0 text-danger"><i class="fas fa-dollar-sign"></i> Giá: <strong><%= item.getPrice() %>
                        tỷ</strong></p>
                </div>
            </div>

            <!-- Remove button (form to delete product) -->
            <form action="removeItemFromCart" method="POST" style="display: inline;">
                <input type="hidden" name="propertyId" value="<%= item.getPropertyId() %>">
                <button type="submit" class="btn btn-sm btn-danger ml-3"
                        onclick="return confirm(' Bạn có chắc chắn muốn xóa bất động sản này không?')">
                    <i class="fas fa-trash-alt"></i> Xóa
                </button>
            </form>
        </li>
        <%
            }
        } else {
        %>
        <li class="list-group-item text-center text-muted">Bạn chưa lưu tin nào.</li>
        <% } %>
    </ul>

    <button id="checkout-button" class="btn btn-success w-100 mt-3" onclick="submitOrderForm()">Đặt lịch</button>

    <!-- Thêm nút "Thuê người môi giới" -->

    <form id="orderForm" action="createOrder" method="POST" style="display:none;">
        <input type="hidden" name="userId" value="<%= userId %>">
        <input type="hidden" name="username" value="<%= username %>">

        <% for (CartItem item : cartItems) { %>
        <input type="hidden" name="propertyId" value="<%= item.getPropertyId() %>">
        <input type="hidden" name="title" value="<%= item.getTitle() %>">
        <input type="hidden" name="price" value="<%= item.getPrice() %>">
        <input type="hidden" name="area" value="<%= item.getArea() %>">
        <input type="hidden" name="address" value="<%= item.getAddress() %>">
        <% } %>
        <input type="hidden" name="orderDate" value="<%= new java.util.Date() %>">
    </form>

    <script>
        function submitOrderForm() {
            const emptyCartMessage = document.querySelector('.list-group-item.text-muted');

            if (emptyCartMessage) {
                alert('Giỏ hàng của bạn hiện tại không có sản phẩm. Vui lòng thêm sản phẩm vào giỏ hàng để tiếp tục.');
            } else {
                document.getElementById('orderForm').submit();
            }
        }
    </script>

</div>

<script>
    function checkCartBeforeCheckout() {
        // Check if there are items in the cart by checking the cart content message
        const emptyCartMessage = document.querySelector('.list-group-item.text-muted');

        if (emptyCartMessage) {
            // Cart is empty
            alert('Giỏ hàng của bạn hiện tại không có sản phẩm. Vui lòng thêm sản phẩm vào giỏ hàng để tiếp tục.');
        } else {
            // Proceed to checkout if there are items
            window.location.href = 'checkout.jsp';
        }
    }

    // Disable the checkout button initially if the cart is empty
    window.onload = function () {
        const checkoutButton = document.getElementById('checkout-button');
        const emptyCartMessage = document.querySelector('.list-group-item.text-muted');

        if (emptyCartMessage) {
            checkoutButton.disabled = true; // Disable button if cart is empty
            checkoutButton.style.backgroundColor = '#ccc'; // Change color to indicate disabled state
        }
    };
</script>


<div class="footer">
    <div class="footer-top">

        <h1><a href="welcome">
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
                <li><a href="agent.jsp">Thuê người môi giới</a></li>
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
            <a href="agent.jsp"><i class="fas fa-user-tie"></i> Thuê người môi giới</a>
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
