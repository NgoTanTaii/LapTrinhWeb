<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="css/test.css">
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
            <a href="account.jsp" class="btn"><h3>Hello, <%= username %>
            </h3></a>
            <a href="homes" class="btn"><h3>Đăng xuất</h3></a>
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
                    <li><a href="property-for-sale.html">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Thông tin bán nhà đất</a></li>
                            <li><a href="#">Mua bán bất động sản</a></li>
                            <li><a href="#">Nhà đất giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="property-for-rent.html">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Thông tin cho thuê nhà đất</a></li>
                            <li><a href="#">Thuê nhà nguyên căn</a></li>
                            <li><a href="#">Thuê căn hộ giá rẻ</a></li>
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


<div class="main-content">
    <h1>Giỏ hàng bất động sản của bạn</h1>
    <ul id="cart-items" class="cart-list">
    </ul>
    <form id="order-form" method="post">
        <button type="button" onclick="window.location.href='checkout.jsp'">Đặt lịch</button>
    </form>
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


        window.location.href = 'cart.jsp'; // Chuyển hướng đến trang giỏ hàng

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

</body>
</html>
