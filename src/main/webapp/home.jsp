<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@page import="Entity.Book" %>
<%@ page import="Entity.CartItem" %>
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
                    <span class="color1">VINA</span>
                    <span class="color2">BOOK</span>
                </a>
                </h1>
            </div>

            <div class="menu">
                <div class="search-bar">
                    <input type="text" placeholder="Tìm kiếm sản phẩm..." class="search-input">
                    <button class="search-btn">Tìm kiếm</button>
                </div>
            </div>
            <div class="contact-info">
                <img src="jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>

        </div>

    </div>
    </div>
</header>
<div class="container">
    <div class="sidebar">
        <h2>Danh Mục Sách</h2>
        <ul>
            <li>
                <strong>Sách Mới Nhất</strong>
                <ul class="dropdown">
                    <li>Sách mới phát hành</li>
                    <li>Sách đang hot</li>
                </ul>
            </li>
            <li>
                <strong>Thể Loại Sách</strong>
                <ul class="dropdown">
                    <li>Văn học
                        <ul class="sub-dropdown">
                            <li>Tiểu thuyết</li>
                            <li>Truyện ngắn</li>
                        </ul>
                    </li>
                    <li>Khoa học
                        <ul class="sub-dropdown">
                            <li>Khoa học tự nhiên</li>
                            <li>Khoa học xã hội</li>
                        </ul>
                    </li>
                    <li>Giáo dục
                        <ul class="sub-dropdown">
                            <li>Sách giáo khoa</li>
                            <li>Sách tham khảo</li>
                        </ul>
                    </li>
                    <li>Kinh doanh
                        <ul class="sub-dropdown">
                            <li>Quản trị</li>
                            <li>Marketing</li>
                        </ul>
                    </li>
                    <li>Sách Thiếu Nhi
                        <ul class="sub-dropdown">
                            <li>Truyện cổ tích</li>
                            <li>Sách phát triển kỹ năng</li>
                        </ul>
                    </li>
                    <li>Nghệ Thuật
                        <ul class="sub-dropdown">
                            <li>Họa sĩ</li>
                            <li>Âm nhạc</li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li>
                <strong>Sách Bán Chạy</strong>
                <ul class="dropdown">
                    <li>Top 10 sách bán chạy nhất</li>
                    <li>Sách được yêu thích</li>
                </ul>
            </li>
            <li>
                <strong>Khuyến Mãi</strong>
                <ul class="dropdown">
                    <li>Sách giảm giá</li>
                    <li>Combo sách ưu đãi</li>
                </ul>
            </li>
            <li>
                <strong>Tác Giả Nổi Bật</strong>
                <ul class="dropdown">
                    <li>Tác giả A</li>
                    <li>Tác giả B</li>
                    <li>Tác giả C</li>
                </ul>
            </li>
            <li>
                <strong>Danh Mục Khác</strong>
                <ul class="dropdown">
                    <li>Sách điện tử</li>
                    <li>Sách nói</li>
                    <li>Sách học tiếng Anh</li>
                </ul>
            </li>
            <div class="banner">
                <img src="jpg/DALL·E%202024-09-26%2012.40.53%20-%20A%20vertical%20banner%20designed%20for%20a%20bookstore%20website.%20The%20banner%20should%20have%20a%20dark,%20mysterious%20background%20featuring%20a%20full%20moon%20and%20a%20night%20sky%20filled%20.webp"
                >
            </div>
            <div class="book-list">
                <h3>Sách Mới Bán Chạy</h3>
                <ul>
                    <li>
                        <div class="book-item">
                            <img src="jpg/đắc%20nhân%20tâm.jpg" alt="Sách 1">
                            <div>
                                <h3 class="book-title">Chế Ngự Tâm Trí</h3>
                                <p class="price"><span>199,000₫</span>
                                <p class="old-price"><span> 259 ,000₫</span></p>
                                </p>
                            </div>
                        </div>
                    </li>

                </ul>
                <ul>
                    <li>
                        <div class="book-item">
                            <img src="jpg/đắc%20nhân%20tâm.jpg" alt="Sách 1">
                            <div>
                                <h3 class="book-title">Chế Ngự Tâm Trí</h3>
                                <p class="price"><span>199,000₫</span>
                                <p class="old-price"><span> 259 ,000₫</span></p></p>

                            </div>
                        </div>
                    </li>

                </ul>
                <ul>
                    <li>
                        <div class="book-item">
                            <img src="jpg/đắc%20nhân%20tâm.jpg" alt="Sách 1">
                            <div>
                                <h3 class="book-title">Chế Ngự Tâm Trí</h3>
                                <p class="price"><span>199,000₫</span>
                                <p class="old-price"><span> 259 ,000₫</span></p>
                                </p>
                            </div>
                        </div>
                    </li>

                </ul>
            </div>

        </ul>
    </div>

    <div class="main-banner">
        <div class="large-banner">
            <img src="jpg/805_acaac32dffab45978e11acb1ebcbe4ef_master.webp" alt="Large Banner">
        </div>
        <div class="small-banners">
            <div class="small-banner">
                <img src="jpg/805_acaac32dffab45978e11acb1ebcbe4ef_master.webp" alt="Small Banner 1">
            </div>
            <div class="small-banner">
                <img src="jpg/805_acaac32dffab45978e11acb1ebcbe4ef_master.webp" alt="Small Banner 2">
            </div>
        </div>


        <h1>Danh sách sách</h1>

        <div class="product-row">
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books != null) {
                    for (Book book : books) {
            %>
            <div class="product">
                <img src="<%= book.getImageUrl() %>" alt="<%= book.getTitle() %>" class="product-image">
                <p class="product-name"><%= book.getTitle() %>
                </p>
                <div class="item-price">
                    <span class="price"><%= book.getPrice() %> đ</span>
                </div>
                <div class="icon-container">
                    <a href="#" class="icon magnifier" title="Xem chi tiết">
                        <img src="jpg/zoom-in.png" alt="Kính lúp" class="icon-image">
                    </a>

                    <form id="addToCartForm" method="post" action="add-to-cart" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= book.getId() %>">
                        <input type="hidden" name="bookName" value="<%= book.getTitle() %>"> <!-- Tên sách -->
                        <input type="hidden" name="bookPrice" value="<%= book.getPrice() %>"> <!-- Giá sách -->
                        <input type="hidden" name="bookImageUrl" value="<%= book.getImageUrl() %>">

                        <button type="submit" class="icon cart" title="Thêm vào giỏ hàng">
                            <img src="jpg/add-to-cart.png" alt="Giỏ hàng" class="icon-image">
                        </button>
                    </form>



                    <a href="#" class="icon eye" title="Xem nhanh">
                        <img src="jpg/eye.png" alt="Con mắt" class="icon-image">
                    </a>
                </div>
                <form id="addToCartForm" method="post" action="cart">
                    <input type="hidden" name="bookId" value="<%= book.getId() %>">
                    <input type="hidden" name="bookName" value="<%= book.getTitle() %>"> <!-- Tên sách -->
                    <input type="hidden" name="bookPrice" value="<%= book.getPrice() %>"> <!-- Giá sách -->
                    <input type="hidden" name="bookImageUrl" value="<%= book.getImageUrl() %>">
                    <button type="submit" class="add-to-cart-button" title="Thêm vào giỏ hàng">
                        Thêm vào giỏ hàng
                    </button>
                </form>
            </div>


            <%
                    }
                } else {
                    System.out.println("books == null");
                }
            %>
        </div>

    </div>
</div>
<div class="footer-container">

    <div class="footer-section">
        <h3>Giới thiệu</h3>

        <ul>

            <li><a href="#">Về Vinabook</a></li>

            <li><a href="#">Chính sách bảo mật</a></li>

            <li><a href="#">Điều khoản sử dụng</a></li>

            <li><a href="#">Liên hệ</a></li>

        </ul>

    </div>


    <div class="footer-section">
        <h3>Hỗ trợ khách hàng</h3>

        <ul>

            <li><a href="#">Câu hỏi thường gặp</a></li>

            <li><a href="#">Chính sách đổi trả</a></li>

            <li><a href="#">Phương thức thanh toán</a></li>

            <li><a href="#">Giao hàng</a></li>

        </ul>

    </div>


    <div class="footer-section">
        <h3>Kết nối với chúng tôi</h3>

        <ul class="social-media">

            <li><a href="#">Facebook</a></li>

            <li><a href="#">Instagram</a></li>

            <li><a href="#">YouTube</a></li>

        </ul>
    </div>


    <div class="footer-section">
        <h3>Đăng ký nhận tin</h3>

        <form>
            <input type="email" placeholder="Nhập email của bạn" required>

            <button type="submit">Đăng ký</button>

        </form>

    </div>

</div>


<div class="footer-bottom">
    <p>© 2024 Vinabook. Bảo lưu mọi quyền.</p>

</div>
<script>
    let cartItems = [];
    let totalPrice = 0;
    let miniCartVisible = false; // Biến để theo dõi trạng thái hiển thị của giỏ hàng

    // Thêm sản phẩm vào giỏ hàng
    function addToCart(bookId, bookName, bookPrice, bookImageUrl) {
        const existingProductIndex = cartItems.findIndex(item => item.id === bookId);

        if (existingProductIndex !== -1) {
            cartItems[existingProductIndex].quantity += 1;
        } else {
            const product = {
                id: bookId,
                name: bookName,
                price: parseInt(bookPrice),
                imageUrl: bookImageUrl,
                quantity: 1
            };

            cartItems.push(product);
        }
        sessionStorage.setItem('cartItems', JSON.stringify(cartItems));
        
        updateCartDisplay();
        showMiniCart(); // Hiện giỏ hàng mini
    }

    // Cập nhật hiển thị giỏ hàng
    function updateCartDisplay() {
        const itemCount = document.querySelector('.item-count');
        const cartList = document.getElementById('cart-items');
        const totalPriceDisplay = document.getElementById('total-price');

        cartList.innerHTML = '';

        totalPrice = 0;
        cartItems.forEach((item, index) => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `
                <img src="${item.imageUrl}" alt="${item.name}" width="40" height="40">
                <div class="item-info">
                    <h4>${item.name}</h4>
                    <span>${(item.price * item.quantity).toLocaleString()}₫</span>
                    <div>
                        <input type="number" value="${item.quantity}" min="1" onchange="updateQuantity(${index}, this.value)">
                    </div>
                </div>
                <button onclick="removeFromCart(${index})">Xóa</button> <!-- Xóa sản phẩm -->
            `;
            cartList.appendChild(listItem);
            totalPrice += item.price * item.quantity;
        });

        itemCount.innerText = cartItems.reduce((total, item) => total + item.quantity, 0);
        totalPriceDisplay.innerText = totalPrice.toLocaleString();

        // Giữ cho giỏ hàng mini hiển thị
        if (miniCartVisible) {
            showMiniCart();
        }
    }

    // Cập nhật số lượng sản phẩm từ input
    function updateQuantity(index, newQuantity) {
        if (newQuantity < 1) {
            removeFromCart(index); // Nếu số lượng < 1, xóa sản phẩm
        } else {
            cartItems[index].quantity = parseInt(newQuantity);
            updateCartDisplay(); // Cập nhật hiển thị mà không ẩn giỏ hàng
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    function removeFromCart(index) {
        cartItems.splice(index, 1); // Xóa sản phẩm khỏi giỏ hàng
        updateCartDisplay(); // Cập nhật hiển thị mà không ẩn giỏ hàng
    }

    // Hiển thị hoặc ẩn mini-cart
    function toggleMiniCart() {
        const miniCart = document.querySelector('.mini-cart');
        miniCartVisible = !miniCartVisible; // Đảo ngược trạng thái hiển thị
        miniCart.style.display = miniCartVisible ? 'block' : 'none'; // Hiện hoặc ẩn mini-cart
    }
    function goToCart() {
        // Chuyển hướng đến trang giỏ hàng
        window.location.href = 'cart.jsp'; // Đảm bảo rằng đường dẫn đúng với trang giỏ hàng của bạn
    }


    // Thêm sự kiện khi form thêm vào giỏ hàng được submit
    document.querySelectorAll('#addToCartForm').forEach(form => {
        form.addEventListener('submit', function (event) {
            event.preventDefault();

            const bookId = form.querySelector('input[name="bookId"]').value;
            const bookName = form.querySelector('input[name="bookName"]').value;
            const bookPrice = form.querySelector('input[name="bookPrice"]').value;
            const bookImageUrl = form.querySelector('input[name="bookImageUrl"]').value;

            addToCart(bookId, bookName, bookPrice, bookImageUrl);
        });
    });

    // Thêm sự kiện cho giỏ hàng để hiển thị hoặc ẩn khi nhấn
    const floatingCart = document.getElementById('floating-cart');
    floatingCart.addEventListener('click', toggleMiniCart);
</script>

</body>
</html>
