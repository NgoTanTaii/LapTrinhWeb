<%@ page import="Entity.Property" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="css/bds.css">
<!DOCTYPE html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang JSP với UTF-8</title>
</head>
<header class="header">
    <div class="header-top" style="width: 100%; position: sticky; top: 0; z-index: 1000;">
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
        <div class="header-right" style="margin-top: 10px">


            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>
            <a href="post-status.html" class="btn"><h3>Đăng tin</h3></a>
        </div>
    </div>

    <a href="#" class="floating-cart" id="floating-cart" onclick="toggleMiniCart()"
       style="border: 1px solid #ccc; border-radius:100%;">
        <img src="jpg/heart%20(1).png" style="width: 30px!important; height: 30px !important;" alt="Giỏ hàng"
             class="cart-icon">
        <div class="item-count">0</div>
        <div class="mini-cart">
            <h4>Bất động sản đã lưu</h4>
            <ul id="cart-items"></ul>
            <button id="go-to-cart" onclick="goToCart()">Đi tới xem bất động sản đã lưu</button>
        </div>
    </a>

    </div>
    <div class="menu">
        <div class="header-bottom">

            <div class="store-name">
                <h1><a href="">
                    <span class="color1">HOME</span>
                    <span class="color2">LANDER</span> <!-- Đổi từ VINA BOOK sang VINA BĐS -->
                </a></h1>
            </div>


            <nav>
                <ul class="u-lo">
                    <li><a href="property-for-sale.html">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Thông tin bán nhà đất</a></li>
                            <li><a href="#">Mua bán bất động sản</a></li>
                            <li><a href="#">Nhà đất giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="property-for-rent.html">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Thông tin cho thuê nhà đất</a></li>
                            <li><a href="#">Thuê nhà nguyên căn</a></li>
                            <li><a href="#">Thuê căn hộ giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="project.html">Dự Án</a>
                        <ul>
                            <li><a href="#">Các dự án nổi bật</a></li>
                            <li><a href="#">Dự án nhà ở</a></li>
                            <li><a href="#">Dự án chung cư</a></li>
                        </ul>
                    </li>
                    <li><a href="news.html">Tin Tức</a>
                        <ul>
                            <li><a href="#">Tin thị trường</a></li>
                            <li><a href="#">Xu hướng bất động sản</a></li>
                            <li><a href="#">Phân tích và đánh giá</a></li>
                        </ul>
                    </li>
                    <li><a href="wiki.html">Wiki BĐS</a>
                        <ul>
                            <li><a href="#">Mua bán</a></li>
                            <li><a href="#">Cho thuê</a></li>
                            <li><a href="#">Tài chính</a></li>
                            <li><a href="#">Phong thủy</a></li>
                        </ul>
                    </li>
                </ul>

            </nav>


            <div class="contact-info">
                <img src="jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>

        </div>
    </div>


    </div>
    <div class="slideshow-container">
        <div class="mySlides fade">
            <img src="jpg/1.webp" alt="Banner 1">
        </div>
        <div class="mySlides fade">
            <img src="jpg/1.webp" alt="Banner 2">
        </div>

    </div>

    <!-- Form tìm kiếm ở giữa -->
    <div class="search-container">
        <form class="search-form">
            <input type="text" placeholder="Tìm kiếm..." name="search" required>

            <fieldset class="price-group">
                <legend>Giá <span class="arrow-down">▼</span></legend>
                <div class="price-dropdown hidden">
                    <label for="min-price">Giá tối thiểu (tỷ):</label>
                    <input type="number" id="min-price" name="min-price" placeholder="Nhập giá tối thiểu">

                    <label for="max-price">Giá tối đa (tỷ):</label>
                    <input type="number" id="max-price" name="max-price" placeholder="Nhập giá tối đa">
                </div>
            </fieldset>

            <fieldset class="area-group">
                <legend>Diện Tích <span class="arrow-down">▼</span></legend>
                <div class="area-dropdown hidden">
                    <label for="min-area">Diện tích tối thiểu (m²):</label>
                    <input type="number" id="min-area" name="min-area" placeholder="Nhập diện tích tối thiểu">

                    <label for="max-area">Diện tích tối đa (m²):</label>
                    <input type="number" id="max-area" name="max-area" placeholder="Nhập diện tích tối đa">
                </div>
            </fieldset>

            <button type="submit">Tìm Kiếm</button>
        </form>
    </div>

    <script src="JS/script.js"></script>

    </div>
</header>
<div class="news-section">
    <h2>Tin Tức Bất Động Sản</h2>

    <!-- Danh mục -->
    <ul class="news-categories">
        <li><a href="#">Tin nổi bật</a></li>
        <li><a href="#">BĐS TP.HCM</a></li>
        <li><a href="#">BĐS Hà Nội</a></li>
    </ul>

    <!-- List các tin tức -->
    <div class="news-list">
        <div class="news-item">
            <img src="jpg/banner-books.jpg" alt="Image">
            <h3><a href="#">Tiêu đề bài viết</a></h3>
            <p class="summary">Tóm tắt ngắn gọn về nội dung bài viết...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>
        <div class="news-item">
            <img src="jpg/banner-books.jpg" alt="Image">
            <h3><a href="#">Tiêu đề bài viết</a></h3>
            <p class="summary">Tóm tắt ngắn gọn về nội dung bài viết...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>
        <div class="news-item">
            <img src="jpg/banner-books.jpg" alt="Image">
            <h3><a href="#">Tiêu đề bài viết</a></h3>
            <p class="summary">Tóm tắt ngắn gọn về nội dung bài viết...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>


    </div>


</div>


<div class="product-section"    >
    <h2>Bất động sản dành cho bạn</h2>
    <div class="product-list">
        <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            if (properties != null && !properties.isEmpty()) {
                int index = 0;
                for (Property property : properties) {
        %>
        <div class=" product-item" <%= index >= 8 ? "style='display: none;'" : "" %> >
           <span onclick="location.href='property-detail.jsp?id=<%= property.getId() %>'"
                 style="cursor: pointer; color: blue; text-decoration: none;">
                <img src="<%= property.getImageUrl() %>" alt="<%= property.getTitle() %>" class="product-image">
                <h3><%= property.getTitle() %>
                </h3>
                <p class="address">
                    <img src="jpg/location.png" alt="Location Icon" class="location-icon">
                    <%= property.getAddress() %>
                </p>
                <div class="details">
                    <div class="price-size">
                        <p class="price"><%= property.getPrice() %> tỷ</p>
                        <p class="size"><%= property.getArea() %> m²</p>
                    </div>
                </div>
            </span>
            <div class="heart-icon"
                 onclick="addToFavorites('<%= property.getId() %>', '<%= property.getTitle() %>', <%= property.getPrice() %>, <%= property.getArea() %>, '<%= property.getImageUrl() %>','<%= property.getAddress() %>')">
                <img src="jpg/heartred.png" alt="Heart Icon" class="heart-image">
            </div>
        </div>

        <%
                    index++;
                }
            }
        %>
    </div>

    <!-- Nút xem thêm và ẩn bớt -->
    <div class="view-more">
        <a href="#" id="toggleButton">Xem thêm</a>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleButton = document.getElementById('toggleButton');
        const products = document.querySelectorAll('.product-item');
        let isExpanded = false; // Trạng thái để theo dõi việc mở rộng hay thu gọn

        // Ban đầu hiển thị 8 sản phẩm đầu tiên
        products.forEach((product, index) => {
            if (index < 8) {
                product.style.display = 'block'; // Hiển thị 8 sản phẩm đầu tiên
            } else {
                product.style.display = 'none'; // Ẩn các sản phẩm còn lại
            }
        });

        toggleButton.addEventListener('click', function (e) {
            e.preventDefault();

            if (isExpanded) {
                // Khi trạng thái đang mở rộng, thu gọn lại và chỉ hiển thị 8 sản phẩm
                products.forEach((product, index) => {
                    if (index >= 8) {
                        product.style.display = 'none'; // Ẩn các sản phẩm ngoài 8 sản phẩm đầu tiên
                    }
                });
                toggleButton.textContent = 'Xem thêm'; // Đổi lại thành "Xem thêm"
            } else {
                // Khi trạng thái đang thu gọn, hiển thị tất cả sản phẩm
                products.forEach(product => product.style.display = 'block'); // Hiển thị tất cả sản phẩm
                toggleButton.textContent = 'Ẩn bớt'; // Đổi thành "Ẩn bớt"
            }

            // Đảo trạng thái
            isExpanded = !isExpanded;

            // Thực hiện cuộn mượt mà về đầu phần sản phẩm
            document.querySelector('.product-section').scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        });
    });
</script>
<style>
    /* Basic styling */
    .featured-properties-section {
        max-width: 85%;
        margin-left: 95px;
        text-align: center;
        overflow: hidden;
        margin-bottom: 50px;
    }

    .property-list-container {
        display: flex;
        overflow-x: auto;
        scroll-behavior: smooth;
        padding: 10px;
        gap: 10px;
    }

    .property-card {
        flex: 0 0 200px;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 10px;
        text-align: center;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .property-card p {
        font-size: 16px;
        font-family: Arial;
    }

    .property-card img {
        width: 100%;
        height: auto;
        border-radius: 8px;
    }

    .property-card:hover {
        transform: translateY(-10px); /* Lift the card slightly */
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* Increase shadow */
    }

    /* Navigation buttons */
    .navigation-buttons {
        display: flex;
        justify-content: space-between;
        margin: 10px;
    }

    .navigation-button {
        background-color: #007bff;
        color: white;
        padding: 8px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .navigation-button:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }

    .property-list-container::-webkit-scrollbar {
        display: none; /* For Chrome, Safari, and Edge */
    }

</style>



<%
    // Tạo danh sách các thành phố lớn
    List<String> majorCities = List.of("TP.HCM", "Hà Nội", "Đà Nẵng", "Vũng Tàu");

    // Lấy danh sách bất động sản từ các thành phố này
    PropertyDAO propertyDAO = new PropertyDAO();
    List<Property1> properties1 = propertyDAO.getPropertiesByCities(majorCities);
%>

<div class="featured-properties-section">
    <h2>Dự án bất động sản nổi bật</h2>
    <div class="navigation-buttons">
        <button class="navigation-button" id="prevButton">⬅️ Trước</button>
        <button class="navigation-button" id="nextButton">Tiếp ➡️</button>
    </div>
    <div class="property-list-container" id="productList">
        <!-- Hiển thị danh sách bất động sản -->
        <%
            if (properties1 != null && !properties1.isEmpty()) {
                for (Property1 property : properties1) {
                    // Tách địa chỉ theo dấu ','
                    String[] addressParts = property.getAddress().split(",");
                    String cityPart = "";
                    String preCityWord = "";

                    // Kiểm tra và lấy tên thành phố
                    if (addressParts.length > 0) {
                        cityPart = addressParts[addressParts.length - 1].trim(); // Thành phố
                        // Kiểm tra và lấy từ trước thành phố
                        if (addressParts.length > 1) {
                            preCityWord = addressParts[addressParts.length - 2].trim(); // Từ trước thành phố
                        }
                    }
        %>
        <div class="property-card">
            <a href="property-detail.jsp?id=<%= property.getId() %>" style="text-decoration: none; color: inherit;">
                <img src="<%= property.getImageUrl() %>" alt="<%= property.getTitle() %>">
                <h3><%= property.getTitle() %></h3>
                <p><%= property.getDescription() %></p>
                <div style="display: flex; justify-content: space-between; color: red; margin-top: 5px;">
                    <span><%= property.getArea() %> m²</span>
                    <span><i class="fas fa-map-marker-alt"></i> <%= preCityWord + ", " + cityPart %></span>
                </div>
            </a>
        </div>
        <%
            }
        } else {
        %>
        <p>Không có bất động sản từ các thành phố lớn hiện tại.</p>
        <%
            }
        %>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const productList = document.getElementById("productList");
        const prevButton = document.getElementById("prevButton");
        const nextButton = document.getElementById("nextButton");

        // Function to scroll the product list by a set amount
        function scrollProductList(amount) {
            productList.scrollBy({
                left: amount,
                behavior: 'smooth'
            });
        }

        // Event listeners for the buttons
        prevButton.addEventListener("click", () => scrollProductList(-300));
        nextButton.addEventListener("click", () => scrollProductList(300));
    });
</script>

<div class="banner">
    <img src="jpg/2833732387999181063.gif" alt="Banner Image">
</div>

<div class="product-section">
    <h2>Bất động sản theo địa điểm</h2>

    <div class="property-form">
        <div class="city hcm">
            <a href="#" class="city-link">
                <img src="jpg/HCM.jpg" alt="TP.HCM">
                <span class="city-name">TP.HCM</span>
            </a>
        </div>
        <div class="other-cities">
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/HaNoi.jpg" alt="Hà Nội">
                    <span class="city-name">Hà Nội</span>
                </a>
            </div>
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/DaNang.jpg" alt="Đà Nẵng">
                    <span class="city-name">Đà Nẵng</span>
                </a>
            </div>
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/binhduong.jpg" alt="Bình Dương">
                    <span class="city-name">Bình Dương</span>
                </a>
            </div>
            <div class="city">
                <a href="#" class="city-link">
                    <img src="jpg/DongNai.jpg" alt="Đồng Nai">
                    <span class="city-name">Đồng Nai</span>
                </a>
            </div>
        </div>
    </div>
    <style>
        .property-form {
            position: relative;
        }

        .city-link {
            position: relative;
            display: inline-block;
        }

        .city-name {
            position: absolute;
            top: 10px; /* Khoảng cách từ đỉnh */
            left: 10px; /* Khoảng cách từ bên trái */
            color: white; /* Màu chữ */
            background-color: transparent; /* Nền bán trong suốt */
            padding: 5px;
            border-radius: 3px; /* Bo góc */
            font-size: 20px; /* Kích thước chữ */
        }

        .city-link:hover .city-name {
            text-decoration: underline; /* Gạch chân khi hover */
        }
    </style>

</div>

<div class="footer">
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


</div>
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

    ul {
        list-style-type: none;
        padding: 0;
        margin-right: 0;
        border-radius: 10px;
    }

    .u-lo li {
        position: relative;
        display: inline-block;
        margin-right: 20px;
        z-index: 10; /* Đảm bảo menu cha hiển thị trên cùng */
    }

    ul li a {
        text-decoration: none;
        display: inline-block;
        color: #333;
    }

    /* Thiết lập cho menu con */
    ul li ul {
        display: none; /* Ẩn menu con mặc định */
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #f9f9f9;
        min-width: 200px;
        padding: 10px 0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 999; /* Đảm bảo menu con hiển thị trên các phần tử khác */
    }

    ul li ul li {
        display: block;
        margin: 0;
    }

    ul li ul li a {
        padding: 10px 15px;
        color: #333;
        display: block;
    }

    /* Hiển thị menu con khi hover */
    ul li:hover ul {
        display: block;
    }

    /* Style cho menu con khi hover */
    ul li ul li a:hover {
        background-color: #eee;
        text-decoration: none;
    }

    .social-media a {
        margin-right: 10px;
        color: black;
    }

    /* Form nhập email */
    .newsletter form {
        display: flex;
        flex-direction: row;
        gap: 10px;
        align-items: center;
    }

    .newsletter input[type="email"] {
        padding: 8px;
        font-size: 14px;
        width: 220px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    .newsletter input[type="email"]:focus {
        border-color: #f4a261;
    }

    .newsletter button {
        padding: 8px 15px; /* Làm cho nút nhỏ hơn */
        font-size: 13px; /* Giảm kích thước chữ */
        background-color: #f4a261;
        border: none;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
    }

    .newsletter button:hover {
        background-color: #e38e3e;
    }

    /* Responsive design */
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            align-items: flex-start;
        }

        .footer-content > div {
            margin-right: 0;
            margin-bottom: 20px;
        }

        .newsletter form {
            flex-direction: column;
            align-items: flex-start;
        }

        .newsletter input[type="email"] {
            width: 100%;
        }

        .newsletter button {
            width: 100%;
        }
    }

    .footer-bottom {
        text-align: center;
        margin-top: 20px;
        font-size: 18px;
        color: black;
    }

</style>
<script>

    let cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    let miniCartVisible = false; // Biến theo dõi trạng thái hiển thị của giỏ hàng

    // Hàm thêm bất động sản vào giỏ hàng
    function addToFavorites(id, title, price, area, imageUrl, address) {
        const existingProductIndex = cartItems.findIndex(item => item.id === id);

        if (existingProductIndex !== -1) {
            alert("bất động sản này đã được quan tâm!"); // Thông báo cho người dùng
        } else {
            const product = {
                id: id,
                title: title,
                price: parseFloat(price),
                area: area,
                imageUrl: imageUrl,
                address: address,
                quantity: 1 // Số lượng cố định là 1
            };
            cartItems.push(product);
            updateSessionStorage();
            updateCartDisplay();
            showMiniCart();
        }
    }

    // Cập nhật sessionStorage
    function updateSessionStorage() {
        sessionStorage.setItem('cartItems', JSON.stringify(cartItems));
    }

    // Cập nhật hiển thị giỏ hàng
    function updateCartDisplay() {
        const itemCount = document.querySelector('.item-count');
        const cartList = document.getElementById('cart-items');

        cartList.innerHTML = '';

        if (cartItems.length === 0) {
            cartList.innerHTML = '<li>Bạn chưa có bất động sản đã lưu.</li>';
            itemCount.innerText = 0; // Cập nhật số lượng sản phẩm
            return; // Kết thúc hàm nếu giỏ hàng trống
        }

        cartItems.forEach((item) => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `
            <img src="${item.imageUrl}" alt="${item.title}" width="40" height="40">
            <div class="item-info">
                <h4>${item.title}</h4>
                <p>Địa chỉ: ${item.address}</p>
                <p>Diện tích: ${item.area} m²</p>
                <span>Giá: ${item.price.toLocaleString()} tỷ</span>

            </div>
            <button onclick="removeFromCart('${item.id}')">Xóa</button>
        `;
            cartList.appendChild(listItem);
        });

        itemCount.innerText = cartItems.length; // Cập nhật số lượng sản phẩm
    }

    // Xóa sản phẩm khỏi giỏ hàng
    function removeFromCart(id) {
        cartItems = cartItems.filter(item => item.id !== id);
        updateSessionStorage();
        updateCartDisplay();
    }

    // Hiện giỏ hàng mini
    function showMiniCart() {
        const miniCart = document.querySelector('.mini-cart');
        miniCart.style.display = 'block';
        updateCartDisplay();
    }

    // Chuyển hướng đến trang giỏ hàng
    function goToCart() {
        const isLoggedIn = sessionStorage.getItem('isLoggedIn'); // Giả sử bạn kiểm tra trạng thái đăng nhập ở đây

        if (!isLoggedIn) {
            alert("Bạn cần đăng nhập để xem bất động sản đã quan tâm."); // Thông báo cho người dùng
            window.location.href = 'login.jsp'; // Chuyển hướng đến trang đăng nhập
        } else {
            window.location.href = 'cart.jsp'; // Chuyển hướng đến trang giỏ hàng
        }
    }

    // Cập nhật hiển thị giỏ hàng khi tải lại trang
    updateCartDisplay();

    function toggleMiniCart() {
        const miniCart = document.querySelector('.mini-cart');
        miniCartVisible = !miniCartVisible; // Chuyển đổi trạng thái hiển thị
        miniCart.style.display = miniCartVisible ? 'block' : 'none'; // Cập nhật hiển thị
        updateCartDisplay(); // Cập nhật hiển thị giỏ hàng
    }


</script>
<style>
    .footer-top {
        display: flex; /* Sử dụng flexbox để căn chỉnh */
        justify-content: space-around; /* Giãn cách đều giữa các mục */
        padding: 10px 0; /* Khoảng cách trên và dưới */
        margin-bottom: 20px; /* Khoảng cách dưới để tách khỏi nội dung footer */
        text-align: center; /* Căn giữa nội dung */

    }

    .footer-top h1 a {
        text-decoration: none;


    }

    .footer-item {
        margin: 0 15px; /* Khoảng cách giữa các mục */
        font-weight: bold; /* Chữ đậm */
    }

    /* Các phần khác của footer giữ nguyên */
    .footer {
        margin-top: 30px;
        background-color: whitesmoke;
        color: black;
        padding: 30px 50px;
    }

    .footer-content {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        flex-wrap: wrap;
    }

    .footer-content > div {
        flex: 1;
        margin-right: 20px;
        min-width: 200px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
    }

    .footer-content > div:last-child {
        margin-right: 0;
    }

    .company-info, .quick-links, .social-media, .newsletter {
        margin-bottom: 15px;
    }

    .quick-links ul li a:hover,
    .social-media a:hover {
        color: darkred;
    }

    h3 {
        margin-bottom: 10px;
        color: black;
    }

    ul {
        padding-left: 20px;
        color: black;
    }

    ul li {
        list-style: none;
        color: black;
    }

    ul li a {
        text-decoration: none;
        color: black;
    }

    .social-media a {
        margin-right: 10px;
        color: black;
        text-decoration: none;
    }

    .newsletter form {
        display: flex;
        flex-direction: row;
        gap: 10px;
        align-items: center;
    }

    .newsletter input[type="email"] {
        padding: 8px;
        font-size: 14px;
        width: 220px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    .newsletter input[type="email"]:focus {
        border-color: #f4a261;
    }

    .newsletter button {
        padding: 8px 15px;
        font-size: 13px;
        background-color: #f4a261;
        border: none;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
    }

    .newsletter button:hover {
        background-color: #e38e3e;
    }

    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            align-items: flex-start;
        }

        .footer-content > div {
            margin-right: 0;
            margin-bottom: 20px;
        }

        .newsletter form {
            flex-direction: column;
            align-items: flex-start;
        }

        .newsletter input[type="email"] {
            width: 100%;
        }

        .newsletter button {
            width: 100%;
        }
    }

    .footer-bottom {
        text-align: center;
        margin-top: 20px;
        font-size: 18px;
        color: black;
    }

    .heart-container {
        position: relative;
        display: inline-block;
        padding-top: 1px;
    }

    .heart-icon1 {
        width: 15px; /* Kích thước của biểu tượng trái tim */
        height: 15px;
        cursor: pointer;
    }

    /* Định dạng dòng chữ "Tin đăng đã lưu" */
    .hover-text {
        position: absolute;
        top: 30px; /* Điều chỉnh vị trí theo ý muốn */
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.7); /* Màu nền của dòng chữ */
        color: #fff;
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 14px;
        white-space: nowrap;
        opacity: 0; /* Ẩn dòng chữ */
        transition: opacity 0.3s ease; /* Hiệu ứng hiển thị mượt */
        pointer-events: none; /* Vô hiệu hóa sự kiện trên hover-text */
    }

    /* Khi hover vào biểu tượng trái tim, hiển thị dòng chữ */
    .heart-container:hover .hover-text {
        opacity: 1;
    }
</style>

</body>
</html>
