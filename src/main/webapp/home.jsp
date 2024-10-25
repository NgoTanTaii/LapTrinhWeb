<%@ page import="Entity.Property" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="css/bds.css">
<!DOCTYPE html>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang JSP với UTF-8</title>
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
        <div class="header-right" style="margin-top: 10px">

            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>

        </div>

        <a href="#" class="floating-cart" id="floating-cart" onclick="toggleMiniCart()"
           style="border: 1px solid #ccc; border-radius:100%;">
            <img src="jpg/heart.png" style="width: 30px!important; height: 30px !important;" alt="Giỏ hàng"
                 class="cart-icon">
            <div class="item-count">0</div>
            <div class="mini-cart">
                <h4>Bất động sản đã lưu</h4>
                <ul id="cart-items"></ul>
                <button id="go-to-cart" onclick="goToCart()">Đi tới xem bất động sản đã lưu</button>
            </div>
        </a>

    </div>
    <div class="menu">
        <div class="header-bottom">

            <div class="store-name">
                <h1><a href="">
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
    <div class="slideshow-container">
        <div class="mySlides fade">
            <img src="jpg/1.webp" alt="Banner 1">
        </div>
        <div class="mySlides fade">
            <img src="jpg/1.webp" alt="Banner 2">
        </div>

    </div>

    <!-- Form tìm kiếm ở giữa -->
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

    </div>
</header>
<div class="news-section">
    <h2>Tin Tức Bất Động Sản</h2>

    <!-- Danh mục -->
    <ul class="news-categories">
        <li><a href="#">Tin nổi bật</a></li>
        <li><a href="#">BĐS TP.HCM</a></li>
        <li><a href="#">BĐS Hà Nội</a></li>
    </ul>

    <!-- List các tin tức -->
    <div class="news-list">
        <div class="news-item">
            <img src="jpg/banner-books.jpg" alt="Image">
            <h3><a href="#">Tiêu đề bài viết</a></h3>
            <p class="summary">Tóm tắt ngắn gọn về nội dung bài viết...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>
        <div class="news-item">
            <img src="jpg/banner-books.jpg" alt="Image">
            <h3><a href="#">Tiêu đề bài viết</a></h3>
            <p class="summary">Tóm tắt ngắn gọn về nội dung bài viết...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>
        <div class="news-item">
            <img src="jpg/banner-books.jpg" alt="Image">
            <h3><a href="#">Tiêu đề bài viết</a></h3>
            <p class="summary">Tóm tắt ngắn gọn về nội dung bài viết...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>


    </div>


</div>


<div class="product-section">
    <h2>Bất động sản dành cho bạn</h2>
    <div class="product-list">
        <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            if (properties != null && !properties.isEmpty()) {
                int index = 0;
                for (Property property : properties) {
        %>
        <div class=" product-item" <%= index >= 8 ? "style='display: none;'" : "" %> >
           <span onclick="location.href='property-detail.jsp?id=<%= property.getId() %>'"
                 style="cursor: pointer; color: blue; text-decoration: none;">
                <img src="<%= property.getImageUrl() %>" alt="<%= property.getTitle() %>" class="product-image">
                <h3><%= property.getTitle() %>
                </h3>
                <p class="address">
                    <img src="jpg/location.png" alt="Location Icon" class="location-icon">
                    <%= property.getAddress() %>
                </p>
                <div class="details">
                    <div class="price-size">
                        <p class="price"><%= property.getPrice() %> tỷ</p>
                        <p class="size"><%= property.getArea() %> m²</p>
                    </div>
                </div>
            </span>
            <div class="heart-icon"
                 onclick="addToFavorites('<%= property.getId() %>', '<%= property.getTitle() %>', <%= property.getPrice() %>, <%= property.getArea() %>, '<%= property.getImageUrl() %>','<%= property.getAddress() %>')">
                <img src="jpg/heartred.png" alt="Heart Icon" class="heart-image">
            </div>
        </div>

        <%
                    index++;
                }
            }
        %>
    </div>

    <!-- Nút xem thêm và ẩn bớt -->
    <div class="view-more">
        <a href="#" id="toggleButton">Xem thêm</a>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleButton = document.getElementById('toggleButton');
        const products = document.querySelectorAll('.product-item');
        let isExpanded = false; // Trạng thái để theo dõi việc mở rộng hay thu gọn

        // Ban đầu hiển thị 8 sản phẩm đầu tiên
        products.forEach((product, index) => {
            if (index < 8) {
                product.style.display = 'block'; // Hiển thị 8 sản phẩm đầu tiên
            } else {
                product.style.display = 'none'; // Ẩn các sản phẩm còn lại
            }
        });

        toggleButton.addEventListener('click', function (e) {
            e.preventDefault();

            if (isExpanded) {
                // Khi trạng thái đang mở rộng, thu gọn lại và chỉ hiển thị 8 sản phẩm
                products.forEach((product, index) => {
                    if (index >= 8) {
                        product.style.display = 'none'; // Ẩn các sản phẩm ngoài 8 sản phẩm đầu tiên
                    }
                });
                toggleButton.textContent = 'Xem thêm'; // Đổi lại thành "Xem thêm"
            } else {
                // Khi trạng thái đang thu gọn, hiển thị tất cả sản phẩm
                products.forEach(product => product.style.display = 'block'); // Hiển thị tất cả sản phẩm
                toggleButton.textContent = 'Ẩn bớt'; // Đổi thành "Ẩn bớt"
            }

            // Đảo trạng thái
            isExpanded = !isExpanded;
        });
    });


</script>
<div class="product-section">
    <h2>Dự án bất động sản nổi bật</h2>
</div>
<div class="banner">
    <img src="jpg/2833732387999181063.gif" alt="Banner Image">
</div>

<div class="product-section">
    <h2>Bất động sản theo địa điểm</h2>

    <div class="property-form">
        <div class="city hcm">
            <a href="#" class="city-link">
                <img src="jpg/HCM.jpg" alt="TP.HCM">
                <span class="city-name">TP.HCM</span>
            </a>
        </div>
        <div class="other-cities">
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/HaNoi.jpg" alt="Hà Nội">
                    <span class="city-name">Hà Nội</span>
                </a>
            </div>
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/DaNang.jpg" alt="Đà Nẵng">
                    <span class="city-name">Đà Nẵng</span>
                </a>
            </div>
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/binhduong.jpg" alt="Bình Dương">
                    <span class="city-name">Bình Dương</span>
                </a>
            </div>
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/DongNai.jpg" alt="Đồng Nai">
                    <span class="city-name">Đồng Nai</span>
                </a>
            </div>
        </div>
    </div>
    <style>
        .property-form {
            position: relative;
        }

        .city-link {
            position: relative;
            display: inline-block;
        }

        .city-name {
            position: absolute;
            top: 10px; /* Khoảng cách từ đỉnh */
            left: 10px; /* Khoảng cách từ bên trái */
            color: white; /* Màu chữ */
            background-color: transparent; /* Nền bán trong suốt */
            padding: 5px;
            border-radius: 3px; /* Bo góc */
            font-size: 20px; /* Kích thước chữ */
        }

        .city-link:hover .city-name {
            text-decoration: underline; /* Gạch chân khi hover */
        }
    </style>

</div>

<div class="footer">
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
            <a href="https://www.facebook.com/khoa.ngo.562114/" class="social-icon">Facebook</a>
            <a href="https://www.instagram.com/khoa5462/" class="social-icon">Instagram</a>
            <a href="https://mail.google.com/mail/u/0/?hl=vi#inbox" class="social-icon">Mail</a>
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


</body>
</html>
