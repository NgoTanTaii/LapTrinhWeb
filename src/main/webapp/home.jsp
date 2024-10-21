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
    <div class="header-top">
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
        <div class="header-right">
            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>
        </div>
        <a href="#" class="floating-cart" id="floating-cart">
            <img src="jpg/heart.png" alt="Giỏ hàng" class="cart-icon">
            <div class="item-count">0</div> <!-- Số lượng sản phẩm trong giỏ hàng -->
            <div class="mini-cart">
                <h4>Bất động sản quan tâm</h4>
                <ul id="cart-items">

                </ul>

                <!-- Nút đi tới giỏ hàng -->
                <button id="go-to-cart" onclick="goToCart()">Đi tới xem bất động sản quan tâm</button>

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
                for (Property property : properties) {
        %>
        <div class="product-item">
            <img src="<%= property.getImageUrl() %>" alt="<%= property.getTitle() %>" class="product-image">
            <h3><%= property.getTitle() %>
            </h3>
            <p class="address">
                <img src="jpg/locatin.png" alt="Location Icon" class="location-icon">
                <%= property.getAddress() %>
            </p>

            <div class="details">
                <div class="price-size">
                    <p class="price"><%= property.getPrice() %> tỷ</p>
                    <p class="size"><%= property.getArea() %> m²</p>
                </div>
            </div>
            <div class="heart-icon">
                <img src="jpg/heartred.png" alt="Heart Icon" class="heart-image">
            </div>
        </div>
        <%
                }
            }
        %>

    </div>

    <!-- Link xem thêm -->
    <div class="view-more">
        <a href="#">Xem thêm</a>
    </div>
</div>

<%--<div class="product-section">--%>
<%--    <h2>Dự án bất động sản nổi bật</h2>--%>

<%--    <div class="product-list">--%>
<%--        <div class="product-item">--%>
<%--            <img src="jpg/bat-dong-san-1732-670.jpg" alt="Product 1">--%>
<%--            <div class="image-count">--%>
<%--                +5 Hình ảnh--%>

<%--            </div>--%>

<%--            <h3>Tên sản phẩm 1</h3>--%>
<%--            <p class="address">--%>
<%--                <img src="jpg/locatin.png" alt="Location Icon" class="location-icon">--%>
<%--                Quận 1, TP.HCM--%>
<%--            </p>--%>
<%--            <div class="details">--%>
<%--                <p class="price">2 tỷ</p>--%>
<%--                <p class="size">100m²</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    --%>
<%--    </div>--%>

<%--    <div class="view-more">--%>
<%--        <a href="#">Xem thêm</a>--%>
<%--    </div>--%>
<%--</div>--%>
<div class="banner">
    <img src="jpg/2833732387999181063.gif" alt="Banner Image">
</div>

<div class="product-section">
    <h2>Bất động sản theo địa điểm</h2>

    <div class="property-form">
        <div class="city hcm">
            <img src="jpg/HCM.jpg" alt="TP.HCM">
        </div>
        <div class="other-cities">
            <div class="city">
                <img src="jpg/HaNoi.jpg" alt="Hà Nội">
            </div>
            <div class="city">
                <img src="jpg/DaNang.jpg" alt="Đà Nẵng">
            </div>
            <div class="city">
                <img src="jpg/binhduong.jpg" alt="Bình Dương">
            </div>
            <div class="city">
                <img src="jpg/DongNai.jpg" alt="Đồng Nai">
            </div>
        </div>
    </div>
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
            <a href="#" class="social-icon">Facebook</a>
            <a href="#" class="social-icon">Instagram</a>
            <a href="#" class="social-icon">Twitter</a>
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
    /* Footer */
    .footer {
        background-color: blanchedalmond;
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


<%--</div>--%>
<%--<script>--%>
<%--    // Khôi phục dữ liệu giỏ hàng từ sessionStorage khi tải trang--%>
<%--    let cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];--%>
<%--    let totalPrice = 0;--%>
<%--    let miniCartVisible = false; // Biến để theo dõi trạng thái hiển thị của giỏ hàng--%>
<%--    let isLoggedIn = false; // Thay đổi giá trị này theo trạng thái thực tế của người dùng--%>

<%--    // Thêm sản phẩm vào giỏ hàng--%>
<%--    function addToCart(bookId, bookName, bookPrice, bookImageUrl) {--%>
<%--        const existingProductIndex = cartItems.findIndex(item => item.id === bookId);--%>

<%--        if (existingProductIndex !== -1) {--%>
<%--            cartItems[existingProductIndex].quantity += 1;--%>
<%--        } else {--%>
<%--            const product = {--%>
<%--                id: bookId,--%>
<%--                name: bookName,--%>
<%--                price: parseInt(bookPrice),--%>
<%--                imageUrl: bookImageUrl,--%>
<%--                quantity: 1--%>
<%--            };--%>

<%--            cartItems.push(product);--%>
<%--        }--%>

<%--        updateSessionStorage(); // Cập nhật sessionStorage--%>
<%--        updateCartDisplay();--%>
<%--        showMiniCart(); // Hiện giỏ hàng mini--%>
<%--    }--%>

<%--    // Cập nhật sessionStorage--%>
<%--    function updateSessionStorage() {--%>
<%--        sessionStorage.setItem('cartItems', JSON.stringify(cartItems));--%>
<%--    }--%>

<%--    // Cập nhật hiển thị giỏ hàng--%>
<%--    function updateCartDisplay() {--%>
<%--        const itemCount = document.querySelector('.item-count');--%>
<%--        const cartList = document.getElementById('cart-items');--%>
<%--        const totalPriceDisplay = document.getElementById('total-price');--%>

<%--        cartList.innerHTML = '';--%>

<%--        totalPrice = 0;--%>
<%--        cartItems.forEach((item, index) => {--%>
<%--            const listItem = document.createElement('li');--%>
<%--            listItem.innerHTML = `--%>
<%--                <img src="${item.imageUrl}" alt="${item.name}" width="40" height="40">--%>
<%--                <div class="item-info">--%>
<%--                    <h4>${item.name}</h4>--%>
<%--                    <span>${(item.price * item.quantity).toLocaleString()}₫</span>--%>
<%--                    <div>--%>
<%--                        <input type="number" value="${item.quantity}" min="1" onchange="updateQuantity(${index}, this.value)">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <button onclick="removeFromCart(${index})">Xóa</button> <!-- Xóa sản phẩm -->--%>
<%--            `;--%>
<%--            cartList.appendChild(listItem);--%>
<%--            totalPrice += item.price * item.quantity;--%>
<%--        });--%>

<%--        itemCount.innerText = cartItems.reduce((total, item) => total + item.quantity, 0);--%>
<%--        totalPriceDisplay.innerText = totalPrice.toLocaleString();--%>

<%--        // Giữ cho giỏ hàng mini hiển thị--%>
<%--        if (miniCartVisible) {--%>
<%--            showMiniCart();--%>
<%--        }--%>
<%--    }--%>

<%--    // Cập nhật số lượng sản phẩm từ input--%>
<%--    function updateQuantity(index, newQuantity) {--%>
<%--        if (newQuantity < 1) {--%>
<%--            removeFromCart(index); // Nếu số lượng < 1, xóa sản phẩm--%>
<%--        } else {--%>
<%--            cartItems[index].quantity = parseInt(newQuantity);--%>
<%--            updateSessionStorage(); // Cập nhật sessionStorage--%>
<%--            updateCartDisplay(); // Cập nhật hiển thị mà không ẩn giỏ hàng--%>
<%--        }--%>
<%--    }--%>

<%--    // Xóa sản phẩm khỏi giỏ hàng--%>
<%--    function removeFromCart(index) {--%>
<%--        cartItems.splice(index, 1); // Xóa sản phẩm khỏi giỏ hàng--%>
<%--        updateSessionStorage(); // Cập nhật sessionStorage--%>
<%--        updateCartDisplay(); // Cập nhật hiển thị mà không ẩn giỏ hàng--%>
<%--    }--%>

<%--    // Hiển thị hoặc ẩn mini-cart--%>
<%--    function toggleMiniCart() {--%>
<%--        const miniCart = document.querySelector('.mini-cart');--%>
<%--        miniCartVisible = !miniCartVisible; // Đảo ngược trạng thái hiển thị--%>
<%--        miniCart.style.display = miniCartVisible ? 'block' : 'none'; // Hiện hoặc ẩn mini-cart--%>
<%--    }--%>

<%--    // Hiện giỏ hàng mini--%>
<%--    function showMiniCart() {--%>
<%--        const miniCart = document.querySelector('.mini-cart');--%>
<%--        miniCart.style.display = 'block'; // Luôn hiện giỏ hàng mini--%>
<%--        updateCartDisplay(); // Cập nhật hiển thị--%>
<%--    }--%>

<%--    // Chuyển hướng đến trang giỏ hàng--%>
<%--    function goToCart() {--%>
<%--        if (!isLoggedIn) {--%>
<%--            alert("Bạn cần đăng nhập để truy cập giỏ hàng!");--%>
<%--            goToLogin(); // Gọi hàm để chuyển hướng đến trang đăng nhập--%>
<%--            return; // Dừng thực hiện hàm nếu người dùng chưa đăng nhập--%>
<%--        }--%>

<%--        window.location.href = 'cart.jsp'; // Đảm bảo rằng đường dẫn đúng với trang giỏ hàng của bạn--%>
<%--    }--%>

<%--    // Chuyển hướng đến trang đăng nhập--%>
<%--    function goToLogin() {--%>
<%--        window.location.href = 'login.jsp'; // Đảm bảo rằng đường dẫn đúng với trang đăng nhập của bạn--%>
<%--    }--%>

<%--    // Thêm sự kiện khi form thêm vào giỏ hàng được submit--%>
<%--    document.querySelectorAll('#addToCartForm').forEach(form => {--%>
<%--        form.addEventListener('submit', function (event) {--%>
<%--            event.preventDefault();--%>

<%--            const bookId = form.querySelector('input[name="bookId"]').value;--%>
<%--            const bookName = form.querySelector('input[name="bookName"]').value;--%>
<%--            const bookPrice = form.querySelector('input[name="bookPrice"]').value;--%>
<%--            const bookImageUrl = form.querySelector('input[name="bookImageUrl"]').value;--%>

<%--            addToCart(bookId, bookName, bookPrice, bookImageUrl);--%>
<%--        });--%>
<%--    });--%>

<%--    // Thêm sự kiện cho giỏ hàng để hiển thị hoặc ẩn khi nhấn--%>
<%--    const floatingCart = document.getElementById('floating-cart');--%>
<%--    floatingCart.addEventListener('click', toggleMiniCart);--%>

<%--    // Cập nhật hiển thị giỏ hàng khi tải lại trang--%>
<%--    updateCartDisplay(); // Gọi hàm này để hiển thị giỏ hàng khi tải lại trang--%>
<%--</script>--%>

</body>
</html>
