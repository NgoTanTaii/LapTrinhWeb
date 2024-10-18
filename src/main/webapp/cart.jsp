<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="css/test.css"> <!-- Nếu có file CSS -->
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
            <%
                String username = (String) session.getAttribute("username");
                if (username != null) {
            %>
            <h3>
                <a href="account.jsp" style="color: black; text-decoration: none;">Hello, <%= username %>
                </a>
            </h3>
            <a href="logout" class="btn"><h3>Đăng xuất</h3></a>
            <%
            } else {
            %>

            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>
            <%
                }
            %>
        </div>
    </div>
    <div class="menu">
        <div class="header-bottom">
            <div class="store-name">
                <h1><a href="welcome">
                    <span class="color1">VINA</span>
                    <span class="color2">BOOK</span>
                </a></h1>
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
</header>
<body>
<div class="main-content">
    <h1>Giỏ hàng của bạn</h1>
    <ul id="cart-items" class="cart-list"></ul>
    <div class="total-price">
        <strong>Tổng: <span id="total-price">0</span>₫</strong>
    </div>
    <form id="order-form" method="post">
        <button type="button" onclick="window.location.href='checkout.jsp'">Đặt hàng</button>
    </form>
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
    // Lưu username vào biến JavaScript
    const username = "<%= (username != null) ? username : "" %>";

    let cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    let totalPrice = 0;

    function updateLocalStorage() {
        sessionStorage.setItem('cartItems', JSON.stringify(cartItems));
    }

    function displayCartItems() {
        const cartList = document.getElementById('cart-items');
        cartList.innerHTML = '';
        totalPrice = 0;

        cartItems.forEach((item, index) => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `
              <img src="${item.imageUrl}" alt="${item.name}" class="item-image">
            <div class="item-details">
                <h4>${item.name}</h4>
                <span>${item.price.toLocaleString()}₫</span>
            </div>
            <div class="item-quantity">
                <button onclick="updateQuantity(${index}, -1)">-</button>
                <input type="number" value="${item.quantity}" min="1" onchange="updateQuantity(${index}, this.value - ${item.quantity})">
                <button onclick="updateQuantity(${index}, 1)">+</button>
            </div>
            <div class="item-total">
                <span>${(item.price * item.quantity).toLocaleString()}₫</span>
            </div>
            <button class="remove-button" onclick="removeFromCart(${index})">Xóa</button>
        `;
            cartList.appendChild(listItem);
            totalPrice += item.price * item.quantity;
        });

        document.getElementById('total-price').innerText = totalPrice.toLocaleString();
    }

    function updateQuantity(index, change) {
        if (change === 1) {
            cartItems[index].quantity += 1;
        } else if (change === -1 && cartItems[index].quantity > 1) {
            cartItems[index].quantity -= 1;
        } else if (change < 0) {
            removeFromCart(index);
            return;
        }
        updateLocalStorage();
        displayCartItems(); // Cập nhật giỏ hàng đầy đủ
    }

    function removeFromCart(index) {
        cartItems.splice(index, 1);
        updateLocalStorage();
        displayCartItems(); // Cập nhật giỏ hàng đầy đủ
    }

    window.onload = function () {
        displayCartItems(); // Hiển thị giỏ hàng khi tải trang
    };

    function placeOrder() {
        const address = document.getElementById('shipping-address').value;
        const phone = document.getElementById('phone-number').value;

        if (address.trim() === '' || phone.trim() === '') {
            alert("Vui lòng nhập địa chỉ và số điện thoại!");
            return;
        }

        const formData = new FormData();
        formData.append('address', address);
        formData.append('phone', phone);
        formData.append('username', username); // Thêm username vào form

        fetch('place-order', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    // Redirect to the place-order.jsp page instead of reloading the cart page
                    alert("Đặt hàng thành công! Chúng tôi sẽ gửi thông báo đến email của bạn.");
                    window.location.href = 'cart.jsp'; // Redirect to place-order.jsp
                } else {
                    alert("Đặt hàng không thành công! Vui lòng thử lại.");
                }
            })
            .catch(error => {
                console.error("Lỗi:", error);
                alert("Đã xảy ra lỗi!");
            });
    }

</script>
</body>
</html>
