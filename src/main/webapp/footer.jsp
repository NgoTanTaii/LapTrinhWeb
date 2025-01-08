<%--
  Created by IntelliJ IDEA.
  User: Linh Luu
  Date: 1/4/2025
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <style>

    .footer {
      background-color: whitesmoke;
      color: black;
      padding: 30px 50px; /* Thêm padding cho lề trái và phải */
    }

    /* Căn chỉnh các phần trong footer content thành một hàng */
    .footer-content {
      display: flex;
      justify-content: space-between; /* Giãn cách đều giữa các phần tử */
      align-items: flex-start; /* Căn chỉnh các phần tử theo chiều dọc */
      flex-wrap: wrap; /* Cho phép xuống dòng khi cần thiết trên màn hình nhỏ */
    }


    /* Căn chỉnh mỗi phần tử trong footer */
    .footer-content > div {
      flex: 1;
      margin-right: 20px;
      min-width: 200px; /* Đảm bảo mỗi phần có ít nhất 200px */
      display: flex;
      flex-direction: column;
      justify-content: flex-start; /* Căn theo chiều dọc */
      align-items: flex-start; /* Căn chỉnh nội dung theo lề trái */
    }

    .footer-content > div:last-child {
      margin-right: 0;
    }

    /* Các phần trong footer */
    .company-info, .quick-links, .social-media, .newsletter {
      margin-bottom: 15px;
    }

    .quick-links ul li a:hover,
    .social-media a:hover {
      color: darkred; /* Màu khi hover vào liên kết */

    }

    h3 {
      margin-bottom: 10px;
      color: black;
    }

  </style>
</head>
<body>
<div class="footer-top">

  <h1><a href="homes">
    <span class="color1">HOME</span>
    <span class="color2">LANDER</span>
  </a></h1>
  <span class="footer-item"><i class="fas fa-phone"></i> Hotline: 0123 456 789</span>
  <span class="footer-item"><i class="fas fa-envelope"></i> Hỗ trợ: support@batdongsan.com</span>
  <span class="footer-item"><i class="fas fa-headset"></i> Chăm sóc: 0987 654 321</span>
</div>

<div class="footer-content">
  <!-- Thông tin công ty -->
  <div class="company-info">
    <h3>Công ty Bất Động Sản</h3>
    <p>Địa chỉ: 123 Đường ABC, Quận 1, TP.HCM</p>
    <p>Điện thoại: 0123 456 789</p>
  </div>

  <!-- Liên kết nhanh -->
  <div class="quick-links">
    <h3>Liên kết nhanh</h3>
    <ul>
      <li><a href="#">Trang chủ</a></li>
      <li><a href="#">Dự án</a></li>
      <li><a href="#">Tin tức</a></li>
      <li><a href="#">Liên hệ</a></li>
    </ul>
  </div>

  <!-- Mạng xã hội -->
  <div class="social-media">
    <h3>Mạng xã hội</h3>
    <a href="https://www.facebook.com/khoa.ngo.562114/" class="social-icon"><i class="fab fa-facebook"></i>
      Facebook</a>
    <a href="https://www.instagram.com/khoa5462/" class="social-icon"><i class="fab fa-instagram"></i>
      Instagram</a>
    <a href="https://mail.google.com/mail/u/0/?hl=vi#inbox" class="social-icon"><i
            class="fas fa-envelope"></i>
      Mail</a>
  </div>

  <!-- Form nhập email -->
  <div class="newsletter">
    <h3>Đăng ký nhận tin tức mới nhất</h3>
    <form action="#" method="POST">
      <input type="email" name="email" placeholder="Nhập email của bạn" required>
      <button type="submit">Đăng ký</button>
    </form>
  </div>
</div>

<div class="footer-bottom">
  <p>&copy; 2024 Công ty Bất Động Sản. Mọi quyền lợi thuộc về công ty.</p>
</div>

</body>
</html>
