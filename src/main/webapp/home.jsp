<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="css/style.css">
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
            <img src="jpg/th.jpg" alt="Giỏ hàng" class="cart-icon">
            <div class="item-count">0</div> <!-- Số lượng sản phẩm trong giỏ hàng -->
            <div class="mini-cart">
                <h4>Giỏ hàng của bạn</h4>
                <ul id="cart-items">

                </ul>
                <div class="total">
                    <strong>Tổng: <span id="total-price">0</span>₫</strong>
                </div>
                <!-- Nút đi tới giỏ hàng -->
                <button id="go-to-cart" onclick="goToCart()">Đi tới giỏ hàng của bạn</button>

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
            <style>
                /* Định dạng chung cho menu */
                nav {
                    text-align: left; /* Căn trái cho toàn bộ nav */
                    margin-left: 0; /* Loại bỏ margin trái */
                }

                nav ul {
                    list-style-type: none; /* Xóa dấu chấm cho danh sách */
                    margin: 0; /* Bỏ margin */
                    padding: 0; /* Bỏ padding */
                    display: flex; /* Sử dụng Flexbox để các mục nằm sát nhau */
                    justify-content: flex-start; /* Căn các mục về phía bên trái */
                }

                nav ul li {
                    margin-right: 20px; /* Khoảng cách giữa các mục */
                }

                nav ul li:last-child {
                    margin-right: 0; /* Loại bỏ margin phải của mục cuối */
                }

                nav ul li a {
                    text-decoration: none; /* Xóa gạch chân */
                    color: #000; /* Màu chữ */
                    font-size: 16px; /* Kích thước chữ */
                }

                nav ul li a:hover {
                    color: darkred; /* Màu khi hover */
                    text-decoration: underline;
                }


            </style>

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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Slideshow Banner */
        .slideshow-container {
            position: relative;
            width: 100%;
            height: 300px; /* Chiều cao banner, có thể thay đổi */
            overflow: hidden;
        }

        /* Các hình ảnh trong slideshow */
        .mySlides {
            display: none;
        }

        /* Ảnh trong banner */
        .mySlides img {
            width: 100%; /* Chiều rộng bằng 100% của container */
            height: 100%; /* Chiều cao bằng 100% của container */
            object-fit: cover; /* Đảm bảo ảnh bao phủ toàn bộ banner mà không bị biến dạng */
        }

        /* Hiệu ứng fade */
        .fade {
            animation: fade 1.5s ease-in-out;
        }

        @keyframes fade {
            0% {
                opacity: 0;
            }
            50% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }

        /* Trung tâm form tìm kiếm */
        .search-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }

        /* Kiểu dáng cho form tìm kiếm */
        .search-form {
            background-color: rgba(255, 255, 255, 0.7); /* Nền bán trong suốt */
            padding: 20px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Kiểu dáng cho ô tìm kiếm */
        .search-form input {
            padding: 10px;
            font-size: 16px;
            margin-right: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        /* Kiểu dáng cho nút tìm kiếm */
        .search-form button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: deeppink;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-form button:hover {
            background-color: darkred;
        }


    </style>
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
        <!-- Thêm các item tin tức khác ở đây -->
    </div>


</div>



<%--            <div class="banner">--%>
<%--                <img src="jpg/DALL·E%202024-09-26%2012.40.53%20-%20A%20vertical%20banner%20designed%20for%20a%20bookstore%20website.%20The%20banner%20should%20have%20a%20dark,%20mysterious%20background%20featuring%20a%20full%20moon%20and%20a%20night%20sky%20filled%20.webp"--%>
<%--                >--%>
<%--            </div>--%>

<%--        </ul>--%>
<%--    </div>--%>

<%--    <div class="main-banner">--%>
<%--        <div class="large-banner">--%>
<%--            <img src="jpg/805_acaac32dffab45978e11acb1ebcbe4ef_master.webp" alt="Large Banner">--%>
<%--        </div>--%>
<%--        <div class="small-banners">--%>
<%--            <div class="small-banner">--%>
<%--                <img src="jpg/805_acaac32dffab45978e11acb1ebcbe4ef_master.webp" alt="Small Banner 1">--%>
<%--            </div>--%>
<%--            <div class="small-banner">--%>
<%--                <img src="jpg/805_acaac32dffab45978e11acb1ebcbe4ef_master.webp" alt="Small Banner 2">--%>
<%--            </div>--%>
<%--        </div>--%>


<%--        <h1>Danh sách sách</h1>--%>
<%--        <div class="product-row">--%>
<%--            <%--%>
<%--                List<Book> books = (List<Book>) request.getAttribute("books");--%>
<%--                if (books != null && !books.isEmpty()) {--%>
<%--                    for (Book book : books) {--%>
<%--            %>--%>
<%--            <div class="product">--%>
<%--                <img src="<%= book.getImageUrl() %>" alt="<%= book.getTitle() %>" class="product-image">--%>
<%--                <p class="product-name"><%= book.getTitle() %>--%>
<%--                </p>--%>
<%--                <div class="item-price">--%>
<%--                    <span class="price"><%= book.getPrice() %> đ</span>--%>
<%--                </div>--%>
<%--                <div class="icon-container">--%>
<%--                    <a href="#" class="icon magnifier" title="Xem chi tiết">--%>
<%--                        <img src="jpg/zoom-in.png" alt="Kính lúp" class="icon-image">--%>
<%--                    </a>--%>

<%--                    <form id="addToCartForm1" method="post" action="add-to-cart" style="display:inline;">--%>
<%--                        <input type="hidden" name="bookId" value="<%= book.getId() %>">--%>
<%--                        <input type="hidden" name="bookName" value="<%= book.getTitle() %>">--%>
<%--                        <input type="hidden" name="bookPrice" value="<%= book.getPrice() %>">--%>
<%--                        <input type="hidden" name="bookImageUrl" value="<%= book.getImageUrl() %>">--%>
<%--                        <button type="submit" class="icon cart" title="Thêm vào giỏ hàng">--%>
<%--                            <img src="jpg/add-to-cart.png" alt="Giỏ hàng" class="icon-image">--%>
<%--                        </button>--%>
<%--                    </form>--%>

<%--                    <a href="#" class="icon eye" title="Xem nhanh">--%>
<%--                        <img src="jpg/eye.png" alt="Con mắt" class="icon-image">--%>
<%--                    </a>--%>


<%--                </div>--%>
<%--                <form id="addToCartForm" method="post" action="cart">--%>
<%--                    <input type="hidden" name="bookId" value="<%= book.getId() %>">--%>
<%--                    <input type="hidden" name="bookName" value="<%= book.getTitle() %>"> <!-- Tên sách -->--%>
<%--                    <input type="hidden" name="bookPrice" value="<%= book.getPrice() %>"> <!-- Giá sách -->--%>
<%--                    <input type="hidden" name="bookImageUrl" value="<%= book.getImageUrl() %>">--%>
<%--                    <button type="submit" class="add-to-cart-button" title="Thêm vào giỏ hàng">--%>
<%--                        Thêm vào giỏ hàng--%>
<%--                    </button>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--            <%--%>
<%--                    }--%>
<%--                } else {--%>
<%--                    out.println("<p>Không có sản phẩm nào phù hợp với tìm kiếm.</p>");--%>
<%--                }--%>
<%--            %>--%>
<%--        </div>--%>


<%--    </div>--%>
<%--</div>--%>
<%--<div class="footer-container">--%>

<%--    <div class="footer-section">--%>
<%--        <h3>Giới thiệu</h3>--%>

<%--        <ul>--%>

<%--            <li><a href="#">Về Vinabook</a></li>--%>

<%--            <li><a href="#">Chính sách bảo mật</a></li>--%>

<%--            <li><a href="#">Điều khoản sử dụng</a></li>--%>

<%--            <li><a href="#">Liên hệ</a></li>--%>

<%--        </ul>--%>

<%--    </div>--%>


<%--    <div class="footer-section">--%>
<%--        <h3>Hỗ trợ khách hàng</h3>--%>

<%--        <ul>--%>

<%--            <li><a href="#">Câu hỏi thường gặp</a></li>--%>

<%--            <li><a href="#">Chính sách đổi trả</a></li>--%>

<%--            <li><a href="#">Phương thức thanh toán</a></li>--%>

<%--            <li><a href="#">Giao hàng</a></li>--%>

<%--        </ul>--%>

<%--    </div>--%>


<%--    <div class="footer-section">--%>
<%--        <h3>Kết nối với chúng tôi</h3>--%>

<%--        <ul class="social-media">--%>

<%--            <li><a href="#">Facebook</a></li>--%>

<%--            <li><a href="#">Instagram</a></li>--%>

<%--            <li><a href="#">YouTube</a></li>--%>

<%--        </ul>--%>
<%--    </div>--%>


<%--    <div class="footer-section">--%>
<%--        <h3>Đăng ký nhận tin</h3>--%>

<%--        <form>--%>
<%--            <input type="email" placeholder="Nhập email của bạn" required>--%>

<%--            <button type="submit">Đăng ký</button>--%>

<%--        </form>--%>

<%--    </div>--%>

<%--</div>--%>


<%--<div class="footer-bottom">--%>
<%--    <p>© 2024 Vinabook. Bảo lưu mọi quyền.</p>--%>

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
