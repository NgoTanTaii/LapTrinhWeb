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


<div class="main-content">
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
</div>