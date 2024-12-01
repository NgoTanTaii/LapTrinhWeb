<%@ page import="Entity.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.CartItemDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đặt lịch</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: antiquewhite;
            margin: 0;
            padding: 20px;
        }

        .appointment-form {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 450px;
            width: 100%;
        }

        .appointment-form h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            border: none;
            background-color: #007bff;
            color: #fff;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
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
    System.out.println(cartItems.size());
%>

<div class="appointment-form">
    <h2>Nhập thông tin đặt lịch</h2>
    <form id="schedule-form" method="post" action="schedule-appointment">
        <div class="form-group">
            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" name="address" required>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone" required>
        </div>

        <div class="form-group">
            <label for="appointment-date">Ngày hẹn:</label>
            <input type="date" id="appointment-date" name="appointmentDate" required>
        </div>
        <div class="form-group">
            <label for="appointment-time">Giờ hẹn:</label>
            <input type="time" id="appointment-time" name="appointmentTime" required>
        </div>

        <!-- Truyền username vào dưới dạng input ẩn -->
        <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">


        <input type="hidden" name="productCount" value="<%= cartItems.size() %>">

        <button type="submit" class="submit-btn">Xác nhận đặt lịch</button>
    </form>
</div>

<script>
    // Lấy giỏ hàng từ sessionStorage
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];

    // Lấy phần tử div để hiển thị các sản phẩm
    const productListDiv = document.getElementById('product-list');

    // Duyệt qua từng sản phẩm trong giỏ hàng và thêm vào productDetails
    cartItems.forEach((item, index) => {
        const productNameInput = document.createElement('input');
        productNameInput.type = 'hidden';
        productNameInput.name = 'productName' + index;
        productNameInput.value = item.name;

        const productQuantityInput = document.createElement('input');
        productQuantityInput.type = 'hidden';
        productQuantityInput.name = 'productQuantity' + index;
        productQuantityInput.value = 1;  // Giả sử mỗi sản phẩm có số lượng là 1

        const productPriceInput = document.createElement('input');
        productPriceInput.type = 'hidden';
        productPriceInput.name = 'productPrice' + index;
        productPriceInput.value = item.price;

        // Thêm các input vào div product-list
        productListDiv.appendChild(productNameInput);
        productListDiv.appendChild(productQuantityInput);
        productListDiv.appendChild(productPriceInput);
    });

    // Tạo input ẩn để truyền số lượng sản phẩm vào form
    const productCountInput = document.createElement('input');
    productCountInput.type = 'hidden';
    productCountInput.name = 'productCount';
    productCountInput.value = cartItems.length;  // Lấy số lượng sản phẩm trong giỏ
    productListDiv.appendChild(productCountInput);
</script>
</body>
</html>
