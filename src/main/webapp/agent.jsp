<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <title>Tư Vấn Bất Động Sản</title>
    <link rel="stylesheet" type="text/css" href=" css/agent.css"/>

</head>
<body>
<header>
    <div class="logo">
        <h1>Tư Vấn BĐS</h1>
    </div>
    <nav>
        <ul>
            <li><a href="#">Trang Chủ</a></li>
            <li><a href="#">Dịch Vụ</a></li>
            <li><a href="#">Tư Vấn Viên</a></li>
            <li><a href="#">Liên Hệ</a></li>
            <li><a href="#">Đăng Nhập</a></li>
        </ul>
    </nav>
</header>

<!-- Banner -->
<section class="banner">
    <h2>Chọn Tư Vấn Viên Bất Động Sản Chuyên Nghiệp</h2>
    <p>Tìm người tư vấn uy tín cho các dịch vụ bất động sản.</p>
    <button class="cta-button">Tìm Tư Vấn Viên</button>
</section>
<!-- Lọc theo địa chỉ -->
<section class="filter">
    <h3>Lọc Tư Vấn Viên</h3>
    <form id="filter-form">
        <label for="city">Chọn Thành Phố:</label>
        <select id="city" name="city" onchange="filterConsultants()">
            <option value="">Tất cả</option>
            <option value="TPHCM">Thành Phố Hồ Chí Minh</option>
            <option value="Hanoi">Hà Nội</option>
            <option value="DaNang">Đà Nẵng</option>
            <option value="BinhDuong">Bình Dương</option>

            <option value="DongNai">Đồng Nai</option>

            <!-- Thêm các thành phố khác nếu cần -->
        </select>
    </form>
</section>


<!-- Tư Vấn Viên -->
<section class="consultants">
    <h3>Các Tư Vấn Viên</h3>

    <!-- Tư vấn viên có địa chỉ ở TP.HCM -->
    <div class="consultant-card" data-city="TPHCM">
        <img src="jpg/hinh-nen-gai-xinh.jpg" alt="Consultant">
        <h4>Nguyễn Văn A</h4>
        <p>Chuyên gia tư vấn mua bán BĐS</p>
        <p>Đánh giá: ★★★★☆</p>
        <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP. HCM</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>

    <!-- Tư vấn viên có địa chỉ ở Hà Nội -->
    <div class="consultant-card" data-city="Hanoi">
        <img src="jpg/nv1.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 456 Đường XYZ, Quận 3, Hà Nội</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>

    <!-- Tư vấn viên có địa chỉ ở TP.HCM -->
    <div class="consultant-card" data-city="TPHCM">
        <img src="jpg/nv2.jpg" alt="Consultant">
        <h4>Nguyễn C</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 789 Đường LMN, Quận 5, TP. HCM</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>

    <!-- Tư vấn viên có địa chỉ ở Đà Nẵng -->
    <div class="consultant-card" data-city="DaNang">
        <img src="jpg/nv3.jpg" alt="Consultant">
        <h4>Trần Thị D</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 101 Đường PQR, Quận 7, Đà Nẵng</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card" data-city="TPHCM">
        <img src="jpg/nv4.jpg" alt="Consultant">
        <h4>Nguyễn C</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 789 Đường LMN, Quận 5, TP. HCM</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>

    <!-- Tư vấn viên có địa chỉ ở Đà Nẵng -->
    <div class="consultant-card" data-city="DaNang">
        <img src="jpg/nv5.jpg" alt="Consultant">
        <h4>Trần Thị D</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 101 Đường PQR, Quận 7, Đà Nẵng</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card" data-city="BinhDuong">
        <img src="jpg/nv6.jpg" alt="Consultant">
        <h4>Nguyễn C</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 789 Đường LMN, Quận 5, Bình Dương</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>

    <!-- Tư vấn viên có địa chỉ ở Đà Nẵng -->
    <div class="consultant-card" data-city="DongNai">
        <img src="jpg/nv7.jpg" alt="Consultant">
        <h4>Trần Thị D</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <p><strong>Địa chỉ:</strong> 101 Đường PQR, Quận 7, Đồng Nai</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>


    <!-- Các tư vấn viên khác... -->
</section>

<!-- Dịch Vụ -->
<section class="services">
    <h3>Dịch Vụ Tư Vấn</h3>
    <div class="service-item">
        <h4>Mua Bán BĐS</h4>
        <p>Chúng tôi giúp bạn mua bán nhà đất với giá tốt nhất.</p>
    </div>
    <div class="service-item">
        <h4>Cho Thuê BĐS</h4>
        <p>Cung cấp giải pháp cho thuê bất động sản nhanh chóng và hiệu quả.</p>
    </div>
    <div class="service-item">
        <h4>Đầu Tư BĐS</h4>
        <p>Chúng tôi tư vấn và hỗ trợ đầu tư BĐS sinh lời bền vững.</p>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2024 Tư Vấn BĐS | Liên hệ: info@bds.com</p>
</footer>
<script src="JS/agent.js" defer></script></body>
</html>
