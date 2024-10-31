<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đặt lịch</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Liên kết CSS nếu có -->
</head>
<body>
<h1>Nhập thông tin đặt lịch</h1>

<form id="schedule-form" method="post" action="schedule-appointment">
    <!-- Trường nhập địa chỉ -->
    <label for="address">Địa chỉ:</label>
    <input type="text" id="address" name="address" required>

    <!-- Trường nhập số điện thoại -->
    <label for="phone">Số điện thoại:</label>
    <input type="text" id="phone" name="phone" required>

    <!-- Trường chọn ngày hẹn -->
    <label for="appointment-date">Ngày hẹn:</label>
    <input type="date" id="appointment-date" name="appointmentDate" required>

    <!-- Trường chọn giờ hẹn -->
    <label for="appointment-time">Giờ hẹn:</label>
    <input type="time" id="appointment-time" name="appointmentTime" required>

    <!-- Thêm các input hidden để chứa thông tin sản phẩm (bất động sản) -->
    <div id="product-list"></div>

    <!-- Nút xác nhận đặt lịch -->
    <button type="submit">Xác nhận đặt lịch</button>
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

        // Bất động sản chỉ có số lượng là 1
        const productQuantityInput = document.createElement('input');
        productQuantityInput.type = 'hidden';
        productQuantityInput.name = 'productQuantity' + index;
        productQuantityInput.value = 1;

        const productPriceInput = document.createElement('input');
        productPriceInput.type = 'hidden';
        productPriceInput.name = 'productPrice' + index;
        productPriceInput.value = item.price;

        productListDiv.appendChild(productNameInput);
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
