<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href=" css/villa-sale.css">

</head>

<body>
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


            <a href="login.html" class="btn">
                <h3>Đăng nhập</h3>
            </a>
            <a href="register.html" class="btn">
                <h3>Đăng ký</h3>
            </a>
            <a href="post-status.html" class="btn">
                <h3>Đăng tin</h3>
            </a>
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
        <div class="header-bottom" style="height:60px;margin-top: 0 ">

            <div class="store-name">
                <h1><a href="index.html">
                    <span class="color1">HOME</span>
                    <span class="color2">LANDER</span> <!-- Đổi từ VINA BOOK sang VINA BĐS -->
                </a></h1>
            </div>


            <nav>
                <ul>
                    <li><a href="property-for-sale.html">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="apartment-sale.html" >Bán căn hộ chung cư</a></li>
                            <li><a href="house-sale.html">Bán nhà riêng</a></li>
                            <li><a href="villa-sale.html" style="color: #e03c31;">Bán nhà biệt thự liền kề</a></li>
                            <li><a href="street_houses-sale.html">Bán nhà mặt phố</a></li>
                            <li><a href="farm_resort-sale.html">Bán trang trại, khu nghỉ dưỡng</a></li>
                            <li><a href="warehouses_factories-sale.html">Bán kho , nhà xưởng</a></li>
                            <li><a href="other_real_estate-sale.html">Bán loại bất động sản khác</a></li>
                        </ul>
                    </li>
                    <li><a href="property-for-rent.html">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="apartment-rental.html">Cho thuê căn hộ chung cư</a></li>
                            <li><a href="house-rental.html">Cho thuê nhà riêng</a></li>
                            <li><a href="villa-rental.html">Cho thuê nhà biệt thự, liền kề</a></li>
                            <li><a href="street_houses-rental.html">Cho thuê nhà mặt phố</a></li>
                            <li><a href="accommodation-rental.html">Cho thuê phòng trọ , nhà trọ</a></li>
                            <li><a href="office-rental.html">Cho thuê văn phòng</a></li>
                            <li><a href="other_real_estate-rental.html">Cho thuê loại bất động sản khác</a></li>
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
                <img src="../jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>

        </div>
    </div>


</header>

<!-- Nội dung chính -->
<main class="content">
    <!-- Container for Posts -->
    <div class="product-container">
        <h2>Danh sách nhà biệt thự liền kề dành cho bạn</h2>
        <!-- Sản phẩm 1 -->
        <div class="product">
            <img src=" ../jpg/img65.jpg" alt="Nhà 1">
            <div class="product-description">
                <p>GIẢM NGAY 4 TỶ KHI MUA SHOP SAN HÔ - VIEW BIỂN , ĐỐI DIỆN 15 TOÀ CC GIÁ 14 TỶ - VHOCP2- 0346 748 ***</p>
            </div>
            <div class="product-price">Giá: 14 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 84 m²</p>
                <p>Địa chỉ: The Empire - Vinhomes Ocean Park 2, Long Hưng, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 2 -->
        <div class="product">
            <img src=" ../jpg/img66.jpg" alt="Nhà 2">
            <div class="product-description">
                <p>Bán gấp căn shophouse Sao Biển 67,5 m2 sát chung cư Masterise, full nội thất, CK 32%, LS 0% 2 năm</p>
            </div>
            <div class="product-price">Giá: 9,55 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 67,5 m²</p>
                <p>Địa chỉ: Dự án The Empire - Vinhomes Ocean Park 2, Xã Long Hưng, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 3 -->
        <div class="product">
            <img src=" ../jpg/img67.jpg" alt="Nhà 3">
            <div class="product-description">
                <p>Tổng hợp hàng VIP trục đường lớn 20-35m, căn góc, shophouse kinh doanh vị trí đẹp. LH 0967 333 ***</p>
            </div>
            <div class="product-price">Giá: 15,5 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 90 m²</p>
                <p>Địa chỉ: Dự án The Empire - Vinhomes Ocean Park 2, Xã Long Hưng, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 4 -->
        <div class="product">
            <img src=" ../jpg/img68.jpg" alt="Nhà 4">
            <div class="product-description">
                <p>Quỹ căn CN giá kịch trần, đỉnh nóc 11/2024: PK Cọ Xanh, Sao Biển, Hải Âu, Chà là diện tích 48-63m2
                </p>
            </div>
            <div class="product-price">Giá: 6,15 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 48 m²</p>
                <p>Địa chỉ: Dự án The Empire - Vinhomes Ocean Park 2, Xã Long Hưng, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 5 -->
        <div class="product">
            <img src=" ../jpg/img69.jpg" alt="Nhà 5">
            <div class="product-description">
                <p>Nhận booking đợt 1 Vinhomes Đan Phượng - Trực tiếp Chủ đầu tư - Đầu tháng 12 ra hàng</p>
            </div>
            <div class="product-price">Giá: 16,2 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 72 m² </p>
                <p>Địa chỉ: Vinhomes Wonder Park, Tân Hội, Đan Phượng, Hà Nội</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 6 -->
        <div class="product">
            <img src=" ../jpg/img70.jpg" alt="Nhà 6">
            <div class="product-description">
                <p>Biệt thự Cọ Xanh 4. Trung tâm sống xanh mới Oceanpark. 128m2 5 tầng, nhà đẹp phong thủy tôt</p>
            </div>
            <div class="product-price">Giá: 16 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 128 m²</p>
                <p>Địa chỉ: Dự án The Empire - Vinhomes Ocean Park 2, Xã Long Hưng, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 7 -->
        <div class="product">
            <img src=" ../jpg/img71.jpg" alt="Nhà 7">
            <div class="product-description">
                <p>Chỉ 2,3 tỷ mua ngay căn shop Ánh Dương Vin OCP3 cận phố kề biển gần trường học đầu tư cam kết thắng
                </p>
            </div>
            <div class="product-price">Giá: 7,4 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 54 m²</p>
                <p>Địa chỉ: Dự án The Crown - Vinhomes Ocean Park 3, Xã Nghĩa Trụ, Văn Giang, Hưng Yên
                </p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 8 -->
        <div class="product">
            <img src=" ../jpg/img72.jpg" alt="Nhà 8">
            <div class="product-description">
                <p>Bán nhà biệt thự hàng hiếm tại The Crown - Vinhomes Ocean Park 3, giá 7,7 tỷ VND, 54m2</p>
            </div>
            <div class="product-price">Giá: 7,7 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 54 m²</p>
                <p>Địa chỉ: The Crown - Vinhomes Ocean Park 3, Đường Phố Biển 4, Xã Nghĩa Trụ, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 9 -->
        <div class="product">
            <img src=" ../jpg/img73.jpg" alt="Nhà 9">
            <div class="product-description">
                <p>Chính thức mở bán siêu phẩm The Aristo - chiết khấu 2X% ++, miễn lãi 36 tháng. LH: 0986 786 ***
                </p>
            </div>
            <div class="product-price">Giá: 40 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 120 m²</p>
                <p>Địa chỉ: Dự án The Manor Central Park, Đường Nghiêm Xuân Yêm, Phường Đại Kim, Hoàng Mai, Hà Nội
                </p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 10 -->
        <div class="product">
            <img src=" ../jpg/img74.jpg" alt="Nhà 10">
            <div class="product-description">
                <p>Bán liền kề 54m2 Vinhomes Ocean Park 3 giá 7.5 tỷ, ngay công viên nước trung tâm dự án</p>
            </div>
            <div class="product-price">Giá: 7,5 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 54 m² VNĐ</p>
                <p>Địa chỉ: Dự án The Crown - Vinhomes Ocean Park 3, Xã Nghĩa Trụ, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 11 -->
        <div class="product">
            <img src=" ../jpg/img75.jpg" alt="Nhà 11">
            <div class="product-description">
                <p>Mở bán Siêu phẩm Biệt thự VVIP mặt sông, mặt Vịnh dự án Waterpoint với chính sách siêu khủng!</p>
            </div>
            <div class="product-price">Giá: 18 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 300 m²</p>
                <p>Địa chỉ: Khu đô thị Waterpoint, Tỉnh lộ 824, An Thạnh, Bến Lức, Long An</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>

        <!-- Sản phẩm 12 -->
        <div class="product">
            <img src=" ../jpg/img76.jpg" alt="Nhà 12">
            <div class="product-description">
                <p>GIẢM NGAY 4 TỶ KHI MUA SHOP SAN HÔ - VIEW BIỂN , ĐỐI DIỆN 15 TOÀ CC GIÁ 14 TỶ - VHOCP2- 0346 748 ***</p>
            </div>
            <div class="product-price">Giá: 14 tỷ VNĐ</div>
            <div class="product-details">
                <p>Diện tích: 84 m²</p>
                <p>Địa chỉ: The Empire - Vinhomes Ocean Park 2, Long Hưng, Văn Giang, Hưng Yên</p>
            </div>
            <a href="chi-tiet-san-pham.html" class="view-details">Xem chi tiết</a>
        </div>
    </div>
</main>

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
</body>

</html>