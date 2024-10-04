<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Nếu có file CSS -->
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
</head>
<body>
<h1>Giỏ hàng của bạn</h1>
<ul id="cart-items">
    <!-- Sản phẩm sẽ được thêm vào đây -->
</ul>
<div class="total">
    <strong>Tổng: <span id="total-price">0</span>₫</strong>
</div>
<button onclick="goToCheckout()">Thanh toán</button> <!-- Nút thanh toán -->

<script>
    // Lấy giỏ hàng từ sessionStorage
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    let totalPrice = 0;

    function displayCartItems() {
        const cartList = document.getElementById('cart-items');
        cartList.innerHTML = '';

        totalPrice = 0; // Reset totalPrice

        cartItems.forEach((item, index) => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `
                <img src="${item.imageUrl}" alt="${item.name}" width="40" height="40">
                <div class="item-info">
                    <h4>${item.name}</h4>
                    <span>${(item.price * item.quantity).toLocaleString()}₫</span>
                    <span>Số lượng:
                        <button onclick="updateQuantity(${index}, -1)">-</button>
                        <input type="number" value="${item.quantity}" min="1" onchange="updateQuantity(${index}, this.value - ${item.quantity})">
                        <button onclick="updateQuantity(${index}, 1)">+</button>
                    </span>
                    <button onclick="removeFromCart(${index})">Xóa</button>
                </div>
            `;
            cartList.appendChild(listItem);
            totalPrice += item.price * item.quantity;
        });

        document.getElementById('total-price').innerText = totalPrice.toLocaleString();
        updateMiniCart(); // Cập nhật mini cart khi hiển thị giỏ hàng
    }

    function updateMiniCart() {
        const miniCartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
        const miniCartList = document.getElementById('mini-cart-items'); // Giả sử bạn có ID cho danh sách mini cart
        const miniTotalPrice = document.getElementById('mini-total-price'); // Giả sử bạn có ID cho tổng giá mini cart

        // Cập nhật mini cart
        miniCartList.innerHTML = '';
        let miniTotal = 0;

        miniCartItems.forEach(item => {
            const miniListItem = document.createElement('li');
            miniListItem.innerHTML = `
                <img src="${item.imageUrl}" alt="${item.name}" width="30" height="30">
                <div class="mini-item-info">
                    <h4>${item.name}</h4>
                    <span>${(item.price * item.quantity).toLocaleString()}₫</span>
                </div>
            `;
            miniCartList.appendChild(miniListItem);
            miniTotal += item.price * item.quantity;
        });

        miniTotalPrice.innerText = miniTotal.toLocaleString();
    }

    // Cập nhật số lượng sản phẩm
    function updateQuantity(index, change) {
        if (change === 1) {
            cartItems[index].quantity += 1;
        } else if (change === -1 && cartItems[index].quantity > 1) {
            cartItems[index].quantity -= 1;
        } else if (change < 0) {
            removeFromCart(index);
            return;
        }
        sessionStorage.setItem('cartItems', JSON.stringify(cartItems)); // Cập nhật giỏ hàng
        displayCartItems(); // Hiển thị lại giỏ hàng
    }

    // Xóa sản phẩm khỏi giỏ hàng
    function removeFromCart(index) {
        cartItems.splice(index, 1);
        sessionStorage.setItem('cartItems', JSON.stringify(cartItems)); // Cập nhật giỏ hàng
        displayCartItems(); // Hiển thị lại giỏ hàng
    }

    // Hàm gọi khi tải trang
    displayCartItems();

    // Chuyển tới trang thanh toán
    function goToCheckout() {
        // Chuyển hướng đến trang thanh toán
        window.location.href = 'checkout.jsp';
    }
</script>

</body>
</html>
