<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm - Tràng Vinabook</title>
    <link rel="stylesheet" href="css/product-display.css">
</head>
<body>
<div class="product-container">
    <h1 class="product-title">Tên Sách</h1>
    <h2 class="product-author">Tác Giả: Tên Tác Giả</h2>
    <h3 class="product-publisher">Nhà Xuất Bản: Tên Nhà Xuất Bản</h3>

    <div class="product-image">
        <img src="jpg/đắc%20nhân%20tâm.jpg" alt="Hình ảnh bìa sách">
    </div>

    <div class="product-description">
        <h4>Mô Tả Sản Phẩm</h4>
        <p>Nội dung: Mô tả ngắn gọn về nội dung chính của sách.</p>
        <p>Số trang: 300</p>
        <p>Kích thước: 14 x 20 cm</p>
        <p>Năm xuất bản: 2023</p>
    </div>

    <div class="product-price">
        <p>Giá gốc: <span class="original-price">150.000 VNĐ</span></p>
        <p>Giá giảm: <span class="discount-price">120.000 VNĐ</span></p>
        <p>Khuyến mãi: Giảm 20% cho đơn hàng đầu tiên</p>
    </div>

    <div class="product-rating">
        <p>Đánh giá: ★★★★☆ (4/5)</p>
        <p>Số lượng đánh giá: 25</p>
        <h5>Nhận xét:</h5>
        <p>"Sách hay và bổ ích!" - Người Dùng 1</p>
        <p>"Mình rất thích nội dung của sách này!" - Người Dùng 2</p>
    </div>

    <div class="add-to-cart">
        <h4>Số lượng:</h4>
        <button class="quantity-button">-</button>
        <span class="quantity">1</span>
        <button class="quantity-button">+</button>
        <button class="add-button">Thêm vào giỏ hàng</button>
    </div>

    <div class="related-products">
        <h4>Sản Phẩm Liên Quan:</h4>
        <div class="related-product">Sản phẩm 1</div>
        <div class="related-product">Sản phẩm 2</div>
        <div class="related-product">Sản phẩm 3</div>
    </div>

    <div class="shipping-policy">
        <h4>Chính Sách Vận Chuyển</h4>
        <p>Thông tin về vận chuyển, thời gian giao hàng.</p>
        <h4>Chính Sách Đổi Trả</h4>
        <p>Thông tin về đổi trả, nếu có.</p>
    </div>
</div>
</body>
</html>
