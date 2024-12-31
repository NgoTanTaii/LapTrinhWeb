<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <title>Tư Vấn Bất Động Sản</title>
    <style>

        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body and Layout */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
            color: #333;
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            color: white;
            padding: 10px 20px;
        }

        header .logo h1 {
            font-size: 24px;
        }

        header nav ul {
            list-style: none;
            display: flex;
        }

        header nav ul li {
            margin-left: 20px;
        }

        header nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        /* Banner Section */
        .banner {
            background-image: url('jpg/1.webp');
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
            padding: 100px 20px;
        }

        .banner h2 {
            font-size: 36px;
        }

        .banner p {
            font-size: 18px;
        }

        .cta-button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #f1c40f;
            border: none;
            cursor: pointer;
        }

        .cta-button:hover {
            background-color: #e1b40f;
        }

        /* Consultants Section */
        .consultants {
            padding: 40px 20px;
            text-align: center;
            background-color: #fff;
        }

        .consultant-card {
            display: inline-block;
            width: 250px;
            margin: 10px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .consultant-card img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
        }

        .contact-button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .contact-button a {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            text-decoration: none;
        }

        .contact-button a:hover {
            background-color: #2980b9;
        }

        .contact-button:hover {
            background-color: #2980b9;
        }

        /* Services Section */
        .services {
            padding: 40px 20px;
            background-color: #ecf0f1;
            text-align: center;
        }

        .service-item {
            background-color: white;
            margin: 10px;
            padding: 20px;
            display: inline-block;
            width: 30%;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .service-item h4 {
            font-size: 22px;
            margin-bottom: 10px;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: white;
        }

        footer p {
            font-size: 14px;
        }

    </style>
</head>
<body>

<!-- Header -->
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

<!-- Tư Vấn Viên -->
<section class="consultants">
    <h3>Các Tư Vấn Viên</h3>
    <div class="consultant-card">
        <img src="jpg/hinh-nen-gai-xinh.jpg" alt="Consultant">
        <h4>Nguyễn Văn A</h4>
        <p>Chuyên gia tư vấn mua bán BĐS</p>
        <p>Đánh giá: ★★★★☆</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>

    </div>
    <div class="consultant-card">
        <img src="jpg/nv1.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card">
        <img src="jpg/nv2.jpg" alt="Consultant">
        <h4>Nguyễn C</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card">
        <img src="jpg/nv3.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card">
        <img src="jpg/nv4.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card">
        <img src="jpg/nv5.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card">
        <img src="jpg/nv6.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>
    <div class="consultant-card">
        <img src="jpg/nv7.jpg" alt="Consultant">
        <h4>Trần Thị B</h4>
        <p>Chuyên gia đầu tư BĐS</p>
        <p>Đánh giá: ★★★★★</p>
        <button class="contact-button"><a href="contact-agent.jsp">Liên Hệ</a></button>
    </div>


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
<script>// Mở modal
function openModal() {
    document.getElementById("contact-agent.jsp").style.display = "block";
}

// Đóng modal
function closeModal() {
    document.getElementById("contactModal").style.display = "none";
}

// Đảm bảo rằng người dùng có thể đóng modal khi bấm ra ngoài
window.onclick = function (event) {
    if (event.target == document.getElementById("contactModal")) {
        closeModal();
    }
}


</script>
</body>
</html>
