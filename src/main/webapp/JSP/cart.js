// Lấy phần tử của icon và bảng giỏ hàng
const cartIcon = document.getElementById('cart-icon');
const miniCart = document.getElementById('mini-cart');

// Thêm sự kiện click vào icon giỏ hàng
cartIcon.addEventListener('click', function() {
    // Toggle hiển thị hoặc ẩn bảng giỏ hàng
    if (miniCart.style.display === 'block') {
        miniCart.style.display = 'none';
    } else {
        miniCart.style.display = 'block';
    }
});

// Đóng bảng giỏ hàng nếu click ra ngoài nó
window.addEventListener('click', function(event) {
    if (!cartIcon.contains(event.target) && !miniCart.contains(event.target)) {
        miniCart.style.display = 'none';
    }
});
