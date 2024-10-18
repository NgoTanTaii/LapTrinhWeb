<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đặt hàng</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Liên kết CSS nếu có -->
</head>
<body>
<h1>Nhập thông tin giao hàng</h1>

<form id="checkout-form" method="post" action="place-order">
    <label for="address">Địa chỉ giao hàng:</label>
    <input type="text" id="address" name="address" required>

    <label for="phone">Số điện thoại:</label>
    <input type="text" id="phone" name="phone" required>

    <!-- Thêm các input hidden để chứa thông tin từng sản phẩm -->
    <div id="product-list"></div>

    <button type="submit">Xác nhận đặt hàng</button>
</form>

<script>
    // Lấy giỏ hàng từ sessionStorage
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    const productListDiv = document.getElementById('product-list');

    cartItems.forEach((item, index) => {
        const productNameInput = document.createElement('input');
        productNameInput.type = 'hidden';
        productNameInput.name = 'productName' + index;
        productNameInput.value = item.name;

        const productQuantityInput = document.createElement('input');
        productQuantityInput.type = 'hidden';
        productQuantityInput.name = 'productQuantity' + index;
        productQuantityInput.value = item.quantity;

        const productPriceInput = document.createElement('input');
        productPriceInput.type = 'hidden';
        productPriceInput.name = 'productPrice' + index;
        productPriceInput.value = item.price;

        productListDiv.appendChild(productNameInput);
        productListDiv.appendChild(productQuantityInput);
        productListDiv.appendChild(productPriceInput);
    });

    // Thêm một input ẩn để truyền số lượng sản phẩm
    const productCountInput = document.createElement('input');
    productCountInput.type = 'hidden';
    productCountInput.name = 'productCount';
    productCountInput.value = cartItems.length;
    productListDiv.appendChild(productCountInput);
</script>
</body>
</html>
