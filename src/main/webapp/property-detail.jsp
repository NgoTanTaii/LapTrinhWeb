<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.PosterDAO" %>
<%@ page import="Entity.Poster" %>
<%@ page import="Entity.Comment" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="Dao.CommentDAO" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<link rel="stylesheet" href="css/property-detail.css">
<meta charset="UTF-8">
<title>Property Details</title>
<head>
    <style>
        .heart-icon {
            position: absolute;
            bottom: 5px; /* Di chuyển trái tim xuống góc dưới */
            right: 5px; /* Đặt trái tim ở góc phải */
            z-index: 10; /* Đảm bảo trái tim nằm trên tất cả các phần tử khác */
            cursor: pointer;
            margin-bottom: 2px;
            margin-right: 10px;
        }

        .heart-icon img {
            width: 20px !important; /* Kích thước nhỏ hơn của trái tim */
            height: 20px !important; /* Kích thước nhỏ hơn của trái tim */
            transition: transform 0.3s ease, filter 0.3s ease; /* Hiệu ứng chuyển động */


        }

        .heart-icon:hover img {
            transform: scale(1.2); /* Phóng to biểu tượng trái tim khi hover */
            filter: brightness(1.5); /* Tăng độ sáng khi hover */
        }

        .floating-cart {
            position: fixed; /* Đảm bảo vị trí cố định trên trang */
            bottom: 20px; /* Khoảng cách với mép dưới trang */
            right: 20px; /* Khoảng cách với mép phải của trang */
            width: 40px !important; /* Giảm chiều rộng của biểu tượng giỏ hàng */
            height: 40px !important; /* Giảm chiều cao của biểu tượng giỏ hàng */
            background-color: transparent; /* Màu nền của biểu tượng */
            border-radius: 50%; /* Biểu tượng có hình tròn */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng nhẹ để nổi bật */
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000; /* Đảm bảo nằm trên các thành phần khác */
            cursor: pointer;
            transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu khi hover */
        }

        /* Khi hover vào floating-cart */
        .floating-cart:hover {
            background-color: transparent;
            transform: scale(1.1);
        }

        /* Style cho biểu tượng giỏ hàng (cart-icon) */
        .floating-cart .cart-icon {
            width: 40px; /* Giảm kích thước icon */
            height: 40px;
            object-fit: contain; /* Đảm bảo ảnh vừa khung mà không bị méo */
        }

        /* Hiển thị mini-cart khi hover vào floating-cart */
        .floating-cart:hover .mini-cart {
            display: block; /* Hiển thị mini-cart khi hover */
        }

        /* Style cho mini-cart */
        .mini-cart {
            display: none; /* Mặc định ẩn mini-cart */
            position: absolute;
            bottom: 80px; /* Đặt mini-cart ngay trên biểu tượng giỏ hàng */
            right: 0;
            width: 250px; /* Giảm chiều rộng của mini-cart */
            max-height: 400px; /* Giới hạn chiều cao để tránh quá dài */
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng nhẹ */
            overflow-y: auto; /* Cho phép cuộn khi nội dung quá dài */
            padding: 10px;
        }

        /* Style cho danh sách sản phẩm trong mini-cart */
        .mini-cart ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .mini-cart li {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .mini-cart li img {
            width: 40px; /* Kích thước hình ảnh nhỏ hơn */
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 10px;
        }

        .mini-cart .item-info {
            font-size: 14px;
        }

        .mini-cart .item-info h4 {
            margin: 0;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis; /* Thêm dấu "..." khi tên sách quá dài */
        }

        .item-count {
            position: absolute;
            top: 5px; /* Vị trí từ đầu biểu tượng giỏ hàng */
            right: 5px; /* Vị trí từ bên phải biểu tượng giỏ hàng */
            background-color: red; /* Màu nền */
            color: white; /* Màu chữ */
            border-radius: 50%; /* Hình tròn */
            width: 20px; /* Chiều rộng */
            height: 20px; /* Chiều cao */
            display: flex;
            justify-content: center; /* Canh giữa */
            align-items: center; /* Canh giữa */
            font-size: 12px; /* Kích thước chữ */
            font-weight: bold; /* Đậm chữ */
        }

        .bottom-banner {
            width: 56%; /* Kích thước của banner */
            margin-left: 135px; /* Canh giữa và tạo khoảng cách */
            margin-top: 50px;
        }

        .bottom-banner img {
            width: 63%; /* Chiều rộng đầy đủ */
            border-radius: 5px; /* Bo góc cho banner */
            padding-right: 50px;
        }

        .property-features {
            margin-top: 30px;
            width: 52%; /* Kích thước của banner */
            margin-left: 135px; /* Canh giữa và tạo khoảng cách */

            padding: 15px; /* Padding cho phần đặc điểm */
            border: 1px solid #ccc; /* Viền cho phần đặc điểm */
            border-radius: 5px; /* Bo góc cho phần đặc điểm */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Đổ bóng cho phần đặc điểm */
        }

        .features-container {
            display: flex; /* Sử dụng Flexbox để chia cột */
            justify-content: space-between; /* Tạo khoảng cách đều giữa các cột */
        }

        .features-column {
            width: 48%; /* Chiều rộng của mỗi cột */
        }

        .feature-item {
            display: flex; /* Sử dụng Flexbox cho mỗi mục */
            align-items: center; /* Căn giữa theo chiều dọc */
            margin-bottom: 10px; /* Khoảng cách giữa các mục */
            padding: 5px 0; /* Thêm padding trên và dưới để căn chỉnh */
        }

        .feature-icon {
            font-size: 24px; /* Kích thước biểu tượng */
            margin-right: 20px; /* Khoảng cách giữa biểu tượng và nội dung */

            flex-shrink: 0; /* Đảm bảo biểu tượng không bị co lại */
        }

        /* Đảm bảo nội dung trong các mục được căn chỉnh đều */
        .feature-item span {
            display: flex; /* Sử dụng Flexbox cho span */
            justify-content: space-between; /* Căn đều giữa label và giá trị */
            width: 100%; /* Đảm bảo chiều rộng đầy đủ */
        }

        .property-features h3 {
            margin-bottom: 10px; /* Khoảng cách dưới tiêu đề */
        }

        .property-features ul {
            list-style-type: none; /* Xóa dấu chấm đầu dòng */
            padding: 0; /* Xóa padding mặc định */
        }

        .property-features li {
            margin-bottom: 8px; /* Khoảng cách giữa các mục trong danh sách */
            display: flex; /* Hiển thị các mục dưới dạng dòng */
        }

        .property-features strong {
            margin-right: 10px; /* Khoảng cách giữa tiêu đề và giá trị */
            color: #333; /* Màu sắc cho tiêu đề */
        }

        .feature-icon {
            font-size: 24px; /* Điều chỉnh kích thước biểu tượng */
            margin-right: 10px; /* Khoảng cách giữa biểu tượng và nội dung */

        }

        .map-container {
            width: 52%;
            margin-left: 135px;
            border: 1px solid #ccc; /* Đường viền cho phần bản đồ */
            border-radius: 5px; /* Bo góc cho phần bản đồ */
            overflow: hidden; /* Ẩn đi các phần viền ra ngoài */
            margin-top: 30px;
        }

        .map-container h3 {
            padding: 10px; /* Khoảng cách cho tiêu đề bản đồ */
            background-color: #f8f8f8; /* Nền cho tiêu đề */
            width: 100%;
            margin: 0; /* Không có khoảng cách bên ngoài */
            border-bottom: 1px solid #ccc; /* Đường viền dưới cho tiêu đề */
        }

        .additional-info {
            margin-top: 50px;
            width: 52%;
            border: 1px solid #ccc; /* Đường viền cho phần thông tin bổ sung */
            border-radius: 5px; /* Bo góc cho phần thông tin bổ sung */
            margin-left: 135px; /* Khoảng cách trên và dưới */
            padding: 15px; /* Khoảng cách bên trong */
            background-color: #f9f9f9; /* Màu nền cho phần thông tin bổ sung */
        }

        .additional-info h3 {
            margin: 0 0 10px 0; /* Khoảng cách dưới tiêu đề */
            font-size: 1.2em; /* Kích thước chữ tiêu đề */
        }

        .info-container {
            display: flex; /* Sử dụng flexbox để xếp hàng dọc */
            flex-direction: row; /* Xếp hàng theo chiều dọc */
        }

        .info-item {
            display: flex; /* Sử dụng flexbox để căn chỉnh icon và text */
            align-items: center; /* Căn giữa theo chiều dọc */
            margin-bottom: 10px; /* Khoảng cách giữa các mục thông tin */
            font-size: 0.9em; /* Kích thước chữ nhỏ hơn */
        }

        .info-icon {
            margin-right: 10px; /* Khoảng cách giữa icon và text */
            color: #007bff; /* Màu sắc cho các icon */
        }

        .copyright {
            width: 52%;
            margin-left: 135px;
            margin-top: 40px; /* Khoảng cách trên cho phần bản quyền */
            padding: 10px; /* Padding bên trong */
            text-align: center; /* Căn giữa nội dung */
            font-size: 0.8em; /* Kích thước chữ nhỏ hơn */
            color: #555; /* Màu chữ */
            border-top: 1px solid #ccc; /* Đường viền trên */
            background-color: #f9f9f9; /* Màu nền nhẹ cho phần bản quyền */
        }
    </style>
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

        <%
            boolean isLoggedIn = session.getAttribute("username") != null;
            String username = (String) session.getAttribute("username");
        %>
        <script>
            const isLoggedIn = <%= isLoggedIn %>; // Chuyển trạng thái đăng nhập thành biến JavaScript
        </script>

        <div class="header-right" style="margin-top: 10px">
            <% if (isLoggedIn) { %>
            <a href="account.jsp" class="btn">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 150px;">
                    Hello, <%= username %>
                </h3>
            </a>

            <a href="javascript:void(0)" id="logoutButton" class="btn" onclick="document.getElementById('logoutForm').submit();">
                <h3>Đăng xuất</h3>
            </a>

            <!-- Hidden Form to Logout -->
            <form id="logoutForm" action="logout" method="POST" style="display: none;">
                <button type="submit" style="display: none;"></button> <!-- This button will not be visible -->
            </form>
            <% } else { %>
            <a href="login.jsp" class="btn"><h3>Đăng nhập</h3></a>
            <a href="register.jsp" class="btn"><h3>Đăng ký</h3></a>
            <% } %>
            <a href="post-status.html" class="btn"><h3>Đăng tin</h3></a>
        </div>

    </div>

    <a href="javascript:void(0)" id="floating-cart" class="floating-cart" onclick="toggleMiniCart()"
       style="border: 1px solid #ccc; border-radius: 50%; position: fixed; bottom: 20px; right: 20px; z-index: 999; padding: 10px; background-color: white;">
        <img src="jpg/heart%20(1).png" style="width: 30px; height: 30px;" alt="Giỏ hàng" class="cart-icon">
        <div class="item-count" id="item-count"
             style="position: absolute; top: 0; right: 0; background-color: red; color: white; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; font-size: 12px;">
            0
        </div>
        <div class="mini-cart" id="mini-cart"
             style="display: none; position: absolute; bottom: 50px; right: 0; width: 250px; background-color: #fff; border: 1px solid #ccc; border-radius: 8px; padding: 15px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
            <h4 style="margin-top: 0;">Bất động sản đã lưu</h4>
            <ul id="cart-items" style="list-style-type: none; padding: 0; margin: 10px 0;">
                <!-- Mỗi sản phẩm có một form để xóa -->
                <li id="mini-cart-item-1">
                    <div style="display: flex; align-items: center; margin-bottom: 10px;">

                        <form action="removeMiniCartItem" method="POST" style="display: inline;">
                            <input type="hidden" name="propertyId" value="1">
                            <button type="submit" class="btn btn-sm btn-danger ml-3"
                                    style="border: none; background-color: red; color: white; padding: 5px; border-radius: 4px; cursor: pointer;">
                                <i class="fas fa-trash-alt"></i> Xóa
                            </button>
                        </form>
                    </div>
                </li>
                <!-- Thêm các mục khác tương tự với ID và giá trị khác nhau -->
            </ul>
            <button id="go-to-cart" onclick="goToCart()"
                    style="width: 100%; padding: 10px; background-color: #007bff; color: #fff; border: none; border-radius: 4px; cursor: pointer;">
                Đi tới xem bất động sản đã lưu
            </button>
        </div>
    </a>

    <script>
        // Tự động tải số lượng sản phẩm trong giỏ hàng khi trang được tải
        document.addEventListener("DOMContentLoaded", function () {
            loadCartCount(); // Gọi hàm để tải số lượng mục trong giỏ hàng
        });

        // Toggle Mini Cart visibility
        function toggleMiniCart() {
            var miniCart = document.getElementById('mini-cart');
            if (miniCart.style.display === 'none' || miniCart.style.display === '') {
                miniCart.style.display = 'block';
                loadCartItems(); // Load cart items khi mở mini-cart
            } else {
                miniCart.style.display = 'none';
            }
        }

        // Hàm tải số lượng sản phẩm trong giỏ hàng
        function loadCartCount() {
            fetch('http://localhost:8080/Batdongsan/getMiniCart', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('item-count').innerText = data.itemCount;
                    } else {
                        document.getElementById('item-count').innerText = 0;
                    }
                })
                .catch(error => {
                    console.error('Error loading cart count:', error);
                    document.getElementById('item-count').innerText = 0;
                });
        }

        // Redirect to Cart Page
        function goToCart() {
            window.location.href = 'cart.jsp';  // Thay đổi nếu cần
        }

        // Load Cart Items via AJAX
        function loadCartItems() {
            fetch('http://localhost:8080/Batdongsan/getMiniCart', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
                .then(response => response.json())
                .then(data => {
                    const cartItemsContainer = document.getElementById('cart-items');
                    cartItemsContainer.innerHTML = '';

                    if (data.success) {
                        document.getElementById('item-count').innerText = data.itemCount;

                        if (data.cartItems.length > 0) {
                            data.cartItems.forEach(item => {
                                const li = document.createElement('li');
                                li.id = `cart-item-${item.propertyId}`;

                                li.innerHTML = `
                            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                <img src="${item.imageUrl}" alt="${item.title}" class="cart-item-image" style="width: 50px; height: 50px; margin-right: 10px;">
                                <div>
                                    <h5>${item.title}</h5>
                                    <p style="color:darkred">Giá: ${item.price} tỷ</p>
                                    <p style="color:darkred">Diện tích: ${item.area} m²</p>
                                    <p>Địa chỉ: ${item.address}</p>
                                    <p>Số lượng: ${item.quantity}</p>
                 <!-- Form xóa sản phẩm -->
<form action="removeMiniCartItem" method="POST" style="display: inline;">
    <input type="hidden" name="propertyId" value="${item.propertyId}">
    <button type="submit" class="btn btn-sm btn-danger ml-3" style="border: none; background-color: red; color: white; padding: 5px; border-radius: 4px; cursor: pointer;">
        <i class="fas fa-trash-alt"></i> Xóa
    </button>
</form>


                                </div>
                            </div>
                        `;
                                cartItemsContainer.appendChild(li);
                            });
                        } else {
                            cartItemsContainer.innerHTML = '<li>Giỏ hàng trống</li>';
                        }
                    } else {
                        cartItemsContainer.innerHTML = `<li>${data.message}</li>`;
                    }
                })
                .catch(error => {
                    console.error('Error loading cart items:', error);
                    document.getElementById('cart-items').innerHTML = '<li>Đã xảy ra lỗi khi tải giỏ hàng.</li>';
                });
        }

    </script>

    <div class="menu">
        <div class="header-bottom" style="height:60px;margin-top: 0">
            <div class="store-name">
                <h1>
                    <a href="<%= isLoggedIn ? "welcome" : "homes" %>">
                        <span class="color1">HOME</span>
                        <span class="color2">LANDER</span>
                    </a>
                </h1>
            </div>


            <nav>
                <ul>
                    <li><a href="#nhadatban">Nhà Đất Bán</a></li>
                    <li><a href="#nhadatchochue">Nhà Đất Cho Thuê</a></li>
                    <li><a href="#duan">Dự Án</a></li>
                    <li><a href="#tintuc">Tin Tức</a></li>
                    <li><a href="#wikibds">Wiki BĐS</a></li>
                </ul>
            </nav>

            <div class="contact-info">
                <img src="jpg/phone-call.png" alt="Phone Icon" class="phone-icon">
                <span class="phone-number">0123 456 789</span>
            </div>
        </div>
    </div>
</header>
<%
    String propertyId = request.getParameter("id");
    PropertyDAO propertyDAO = new PropertyDAO();
    Property1 property = propertyDAO.getPropertyById(propertyId);

    // Fetch thumbnails from the property_images table
    List<String> thumbnailUrls = propertyDAO.getThumbnailUrls(propertyId);

    if (property == null) {
        out.println("<h2>Property not found</h2>");
    } else {
%>

<div class="container" style="max-width:80% ">
    <div class="property-detail">
        <h2><%= property.getTitle() %>
        </h2>


        <img id="mainImage" class="main-image"
             src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
             alt="<%= property.getTitle() %>">

        <div class="thumbnails">

            <div class="thumbnail"
                 onclick="changeMainImage('<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>')">
                <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                     alt="Thumbnail">
            </div>

            <%
                if (thumbnailUrls != null && !thumbnailUrls.isEmpty()) {
                    int displayedCount = Math.min(thumbnailUrls.size(), 20); // Giảm số lượng thumbnail còn lại xuống 4
                    for (int i = 0; i < displayedCount; i++) {
                        String thumbnailUrl = thumbnailUrls.get(i);
            %>
            <div class="thumbnail" onclick="changeMainImage('<%= thumbnailUrl %>')">
                <img src="<%= thumbnailUrl %>" alt="Thumbnail">
            </div>
            <%
                    }
                }
            %>
        </div>
        <%
            // Lấy địa chỉ từ property
            String address2 = property.getAddress();
            String formattedAddress = address2.replace(" ", "+"); // Thay khoảng trắng bằng dấu +

            // Tạo URL nhúng Google Maps không có API key
            String mapUrl = "https://www.google.com/maps?q=" + formattedAddress + "&output=embed";
        %>
        <p><i class="fas fa-map-marker-alt"></i> <%= property.getAddress() %>
        </p>
        <p style="color: darkred"><i class="fas fa-money-bill-wave"></i> <%= property.getPrice() %> tỷ</p>
        <p style="color: darkred"><i class="fas fa-ruler-combined"></i> <%= property.getArea() %> m²</p>
        <p><i class="fas fa-info-circle"></i><%= property.getDescription() %>
        </p>

        </p>
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
        <div class="alert alert-info" style="color: darkred;padding-top: 30px;font-size: 30px   "><i class="fas fa-info-circle"></i>
            <%= message %>
        </div>
        <%
                // Optionally remove the message after displaying it
                session.removeAttribute("message");
            }
        %>

        <form action="addToCart" method="post" style="display: inline;">
            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
            <input type="hidden" name="title" value="<%= property.getTitle() %>">
            <input type="hidden" name="price" value="<%= property.getPrice() %>">
            <input type="hidden" name="area" value="<%= property.getArea() %>">
            <input type="hidden" name="imageUrl" value="<%= property.getImageUrl() %>">
            <input type="hidden" name="address" value="<%= property.getAddress() %>">

            <!-- Heart icon as submit button -->
            <button type="submit" class="heart-icon" style="border: none; background: transparent; padding: 0;">
                <img src="jpg/heartred.png" alt="Heart Icon" class="heart-image">
            </button>
        </form>

    </div>

    <style>
        .container {
            max-width: 800px; /* Đặt chiều rộng tối đa cho container */
            margin: 0 auto; /* Center container */
        }

        .property-detail {
            position: relative;
            overflow: hidden; /* Ẩn phần vượt ra ngoài */
            margin-bottom: 20px; /* Khoảng cách giữa property-detail và sản phẩm liên quan */
        }

        .main-image {
            max-width: 100%; /* Đảm bảo hình ảnh không bị tràn ra ngoài */
            height: auto; /* Giữ tỉ lệ hình ảnh */
        }

        .thumbnails {
            display: flex; /* Sử dụng flexbox để hiển thị ngang */
            overflow-x: auto; /* Cho phép cuộn ngang */
            margin-top: 10px; /* Khoảng cách giữa hình ảnh lớn và thumbnails */
        }

        .thumbnail {
            flex: 0 0 auto; /* Không cho phép thumbnail co lại */
            width: 100px; /* Chiều rộng của mỗi thumbnail */
            margin-right: 10px; /* Khoảng cách giữa các thumbnail */
            cursor: pointer;
        }

        .thumbnail img {
            width: 100%; /* Đảm bảo hình ảnh phù hợp với thumbnail */
        }

        .related-properties {
            margin-top: 20px;
        }

        .related-properties-container {
            display: flex;
            overflow-x: auto; /* Cho phép cuộn ngang cho sản phẩm liên quan */
            height: 300px; /* Chiều cao cố định cho sản phẩm liên quan */
        }

        .related-property {
            flex: 0 0 auto; /* Không cho phép co lại */
            width: 200px; /* Chiều rộng của mỗi sản phẩm liên quan */
            margin-right: 10px;
            text-align: center;
        }

        .related-property img {
            max-width: 100%;
            height: auto; /* Giữ tỉ lệ hình ảnh */
        }
    </style>

    <script>
        function changeMainImage(url) {
            document.getElementById('mainImage').src = url; // Thay đổi hình ảnh chính
        }

        const thumbnailsContainer = document.querySelector('.thumbnails');
        thumbnailsContainer.addEventListener('scroll', function () {

        });
    </script>


    <%

        PosterDAO posterDAO = new PosterDAO();
        Poster poster = posterDAO.getPosterByPropertyId(Integer.parseInt(propertyId));

        if (poster == null) {
            out.println("<h2>Poster information not found</h2>");
        } else {
    %>

    <div class="sender-info">
        <h3>Thông tin người đăng</h3>
        <div class="sender-image">
            <img src="<%= poster.getImgUrl() %>"
                 alt="Người đăng" class="sender-avatar">
        </div>
        <div class="info-box">
            <span id="sender-name"><%= poster.getName() %></span>
        </div>
        <div class="info-box">
            <span class="icon" style="margin-bottom: 12px;">✉️</span>
            <span id="sender-email"><%= poster.getMail() %></span>
        </div>
        <div class="info-box">
            <span class="icon" style="margin-bottom: 12px;">📱</span>
            <span id="sender-zalo">https://zalo.me/<%= poster.getPhone() %></span>
        </div>
    </div>

    <% } %>

</div>


<%--<div class="property-features">--%>
<%--    <h3>Đặc điểm bất động sản</h3>--%>
<%--    <div class="features-container">--%>
<%--        <div class="features-column">--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-border-all feature-icon"></i>--%>
<%--                <span><strong>Mặt tiền:</strong> <%= property.getFrontWidth() %> m</span>--%>
<%--            </div>--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-road feature-icon"></i>--%>
<%--                <span><strong>Đường vào:</strong> <%= property.getRoadWidth() %> m</span>--%>
<%--            </div>--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-building feature-icon"></i>--%>
<%--                <span><strong>Số tầng:</strong> <%= property.getFloors() %> tầng</span>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="features-column">--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-bed feature-icon"></i>--%>
<%--                <span><strong>Số phòng ngủ:</strong> <%= property.getBedrooms() %> phòng</span>--%>
<%--            </div>--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-bath feature-icon"></i>--%>
<%--                <span><strong>Số toilet:</strong> <%= property.getBathrooms() %> phòng</span>--%>
<%--            </div>--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-file-alt feature-icon"></i>--%>
<%--                <span><strong>Pháp lý:</strong> <%= property.getLegalStatus() %></span>--%>
<%--            </div>--%>
<%--            <div class="feature-item">--%>
<%--                <i class="fas fa-couch feature-icon"></i>--%>
<%--                <span><strong>Nội thất:</strong> Đầy đủ</span>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="bottom-banner">
    <img src="jpg/bank-loan-offer-banner-web.jpg" alt="Banner quảng cáo" style="width: 100%; border-radius: 5px;">
</div>

<div class="map-container">
    <h3>Bản đồ vị trí bất động sản</h3>
    <iframe
            src="<%=mapUrl%>"
            width="100%"
            height="300"
            style="border:5px;"
            allowfullscreen=""
            loading="lazy"></iframe>
</div>


<div class="additional-info">
    <h3>Thông tin bổ sung</h3>
    <div class="info-container">
        <div class="info-item">
            <i class="fas fa-calendar-alt info-icon"></i>
            <span><strong>Ngày đăng:</strong> 22/10/2024</span>
        </div>
        <div class="info-item">
            <i class="fas fa-calendar-times info-icon"></i>
            <span><strong>Ngày hết hạn:</strong> 01/11/2024</span>
        </div>
        <div class="info-item">
            <i class="fas fa-info-circle info-icon"></i>
            <span><strong>Loại tin:</strong> Tin thường</span>
        </div>
        <div class="info-item">
            <i class="fas fa-hashtag info-icon"></i>
            <span><strong>Mã tin:</strong> 41288902</span>
        </div>
    </div>
</div>

<%
    // Giả sử bạn đã có thông tin chi tiết của bất động sản
    // Lấy địa chỉ để tìm các sản phẩm cùng thành phố
    String address = property.getAddress();
    String[] addressParts = address.split(","); // Tách địa chỉ theo dấu phẩy
    String city = addressParts[addressParts.length - 1].trim(); // Lấy tên thành phố (phần cuối cùng)


    // Lấy các sản phẩm cùng thành phố
    PropertyDAO propertyDAO1 = new PropertyDAO();
    List<Property1> relatedProperties = propertyDAO1.getPropertiesByCity(city); // Phương thức để lấy các sản phẩm cùng thành phố
%>

<div class="related-properties" style="width:63%">
    <h3>Các sản phẩm liên quan</h3>

    <div class="related-properties-container" id="relatedProductsContainer">
        <%
            if (relatedProperties != null && !relatedProperties.isEmpty()) {
                for (Property1 relatedProperty : relatedProperties) {

        %>
        <div class="related-property">
            <a href="property-detail.jsp?id=<%= relatedProperty.getId() %>"
               style="text-decoration: none; color: inherit;">

                <img src="<%= relatedProperty.getImageUrl() %>" alt="Sản phẩm <%= relatedProperty.getTitle() %>">
                <h4><%= relatedProperty.getTitle() %>
                </h4>
                <p style="display: flex; justify-content: space-between; color: red;">
                    <span>Giá: <%= relatedProperty.getPrice() %> tỷ</span>
                    <span>Diện tích: <%= relatedProperty.getArea() %> m²</span>
                </p>
                <p style="display: flex; align-items: center;">
                    <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                         style="width: 16px; height: 16px; margin-right: 5px;">
                    Địa chỉ: <%= relatedProperty.getAddress() %>
                </p>
            </a>
        </div>
        <%
            }
        } else {
        %>
        <p>Không có sản phẩm nào liên quan từ cùng thành phố.</p>
        <%
            }
        %>

        <div class="more-products">
            <button id="scrollLeftBtn"> <</button>
            <button id="scrollRightBtn">️ ></button>
        </div>
    </div>
</div>

<script>
    const container = document.getElementById('relatedProductsContainer');

    document.getElementById('scrollLeftBtn').addEventListener('click', function () {
        container.scrollBy({
            top: 0,
            left: -200, // Cuộn 200px sang trái
            behavior: 'smooth'
        });
    });

    document.getElementById('scrollRightBtn').addEventListener('click', function () {
        container.scrollBy({
            top: 0,
            left: 200, // Cuộn 200px sang phải
            behavior: 'smooth'
        });
    });
</script>

<%

    String address1 = property.getAddress();
    String[] addressParts1 = address1.split(",");
    String city1 = addressParts1[addressParts1.length - 1].trim(); // Lấy tên thành phố (phần cuối cùng)

    // Khởi tạo DAO
    PropertyDAO propertyDAO2 = new PropertyDAO();
    List<Property1> highestPriceProperties = propertyDAO2.getHighestPriceProperties(city1, 3); // Lấy 3 sản phẩm có giá cao nhất
    List<Property1> largestAreaProperties = propertyDAO2.getLargestAreaProperties(city1, 3); // Lấy 3 sản phẩm có diện tích lớn nhất
%>

<div class="related-properties" style="width:63%">
    <h3>Các sản phẩm bạn có thể sẽ quan tâm</h3>
    <div class="related-properties-container" id="relatedProductsContainer1">

        <%
            for (Property1 property1 : highestPriceProperties) {
        %>
        <div class="related-property">
            <a href="property-detail.jsp?id=<%= property1.getId() %>" style="text-decoration: none; color: inherit;">

                <img src="<%= property1.getImageUrl() %>" alt="Sản phẩm <%= property1.getTitle() %>">
                <h4><%= property1.getTitle() %>
                </h4>
                <p style="display: flex; justify-content: space-between; color: red;">
                    <span>Giá: <%= property1.getPrice() %> tỷ</span>
                    <span>Diện tích: <%= property1.getArea() %> m²</span>
                </p>
                <p style="display: flex; align-items: center;">
                    <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                         style="width: 16px; height: 16px; margin-right: 5px;">
                    Địa chỉ: <%= property1.getAddress() %>
                </p>
            </a>
        </div>
        <%
            }
        %>

        <%
            for (Property1 property2 : largestAreaProperties) {
        %>
        <div class="related-property">
            <a href="property-detail.jsp?id=<%= property2.getId() %>" style="text-decoration: none; color: inherit;">

                <img src="<%= property2.getImageUrl() %>" alt="Sản phẩm <%= property2.getTitle() %>">
                <h4><%= property2.getTitle() %>
                </h4>
                <p style="display: flex; justify-content: space-between; color: red;">
                    <span>Giá: <%= property2.getPrice() %> tỷ</span>
                    <span>Diện tích: <%= property2.getArea() %> m²</span>
                </p>
                <p style="display: flex; align-items: center;">
                    <img src="jpg/location.png" alt="Location Icon" class="location-icon"
                         style="width: 16px; height: 16px; margin-right: 5px;">
                    Địa chỉ: <%= property2.getAddress() %>
                </p>
            </a>

        </div>
        <%
            }
        %>

        <div class="more-products">
            <button id="scrollLeftBtn1"> <</button>
            <button id="scrollRightBtn1">️ ></button>
        </div>
    </div>
</div>


<script>
    const container1 = document.getElementById('relatedProductsContainer1');

    document.getElementById('scrollLeftBtn1').addEventListener('click', function () {
        container1.scrollBy({
            top: 0,
            left: -200, // Cuộn 200px sang trái
            behavior: 'smooth'
        });
    });

    document.getElementById('scrollRightBtn1').addEventListener('click', function () {
        container1.scrollBy({
            top: 0,
            left: 200, // Cuộn 200px sang phải
            behavior: 'smooth'
        });
    });
</script>


<!-- Form for Adding Comments (only shown if logged in) -->
<% if (isLoggedIn) { %>
<div class="comment-section">
    <h3>Để lại bình luận của bạn:</h3>
    <form action="SubmitCommentServlet" method="POST">
        <input type="hidden" name="productId" value="<%= request.getParameter("id") %>">
        <textarea name="comment" rows="5" placeholder="Nhập bình luận của bạn..." required></textarea>
        <button type="submit">Gửi bình luận</button>
    </form>
</div>
<% } else { %>
<div class="login-prompt">
    <p style=" margin-left: 135px;margin-top: 30px">Vui lòng <a href="login.jsp">đăng nhập</a> để có thể để lại bình
        luận.</p>
</div>
<% } %>


<%
    String propertyIdParam = request.getParameter("id");
    String loggedInUsername = (String) session.getAttribute("username"); // Get logged-in username from session
    String role = (String) session.getAttribute("role"); // Get role from session
    List<Comment> comments = new ArrayList<>();

    if (propertyIdParam != null) {
        try {
            CommentDAO commentDAO = new CommentDAO();
            comments = commentDAO.getCommentsByPropertyId(propertyId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="existing-comments">
    <h3>Bình luận:</h3>

    <%
        if (comments != null && !comments.isEmpty()) {
            for (Comment comment : comments) {
                // Check if the logged-in user is the comment author (by username) or an admin
                boolean canDelete = "admin".equals(role) ||
                        (loggedInUsername != null && loggedInUsername.equals(comment.getUserName()));
    %>
    <div class="comment">
        <p>
            <strong><%= comment.getUserName() != null ? comment.getUserName() : "Unknown User" %>
            </strong>
            - <%= comment.getCommentDate() %>
                <% if (canDelete) { %>
            <!-- Show delete button if the user is admin or the comment's author -->
        <form action="DeleteCommentServlet" method="post" style="display:inline;">
            <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
            <input type="hidden" name="propertyId" value="<%= propertyIdParam %>">
            <button type="submit" onclick="return confirm('Are you sure you want to delete this comment?');">Delete
            </button>
        </form>
        <% } %>
        </p>
        <p><%= comment.getContent() %>
        </p>
    </div>
    <%
        }
    } else {
    %>
    <p>Chưa có bình luận nào.</p>
    <% } %>
</div>


</div>


<style>
    /* Styling for the comments section */
    .existing-comments {
        margin-left: 135px;
        width: 100%;
        max-width: 600px;
        margin-top: 30px;
        padding: 20px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-family: Arial, sans-serif;
    }

    .existing-comments h3 {
        font-size: 24px;
        color: #333;
        border-bottom: 2px solid #ddd;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    .comment {

        padding: 15px;
        margin-bottom: 15px;
        border-bottom: 1px solid #ddd;
    }

    .comment:last-child {
        border-bottom: none;
    }

    .comment p {
        margin: 5px 0;
        color: #333;
        line-height: 1.4;
    }

    .comment strong {
        color: #0077cc;
        font-weight: bold;
    }

    .comment .date {
        color: #999;
        font-size: 12px;
        margin-left: 10px;
    }

    .no-comments {
        font-size: 16px;
        color: #666;
        text-align: center;
        padding: 20px 0;
    }

</style>


<style>
    .comment-section {
        margin-top: 20px;
        margin-left: 135px;
        max-width: 53%;
    }

    textarea {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }

    .login-prompt p {
        color: #f00;
    }

</style>

<div class="copyright">
    <p>© Mọi quyền thuộc về Homelander. Mọi thông tin liên quan vui lòng liên hệ với chúng tôi.</p>
</div>


<style>
    .related-properties {
        margin-top: 10px; /* Giảm khoảng cách giữa các phần */
        padding-left: 135px; /* Khoảng cách với lề trái */
        position: relative; /* Để định vị các nút */

    }


    .related-properties-container {
        display: flex;
        overflow-x: auto; /* Ẩn thanh cuộn mặc định */
        height: 250px; /* Chiều cao cố định cho sản phẩm liên quan */
        padding-bottom: 10px; /* Khoảng cách cho nút cuộn */


    }

    .related-properties-container::-webkit-scrollbar {
        height: 0px; /* Chiều cao của thanh cuộn */
    }

    .related-property {
        flex: 0 0 auto; /* Không cho phép co lại */
        width: 200px; /* Chiều rộng của mỗi sản phẩm liên quan */
        margin-right: 10px;
        text-align: left;
        overflow: visible; /* Cho phép hình ảnh hiển thị bên ngoài */
        border: 1px solid gainsboro;
        border-radius: 10px;
        position: relative; /* Để z-index có hiệu lực */
        transition: transform 0.3s; /* Thêm hiệu ứng chuyển tiếp */
    }

    .related-property:hover {
        transform: translateY(-5px); /* Nổi lên trên 5px */
        z-index: 15; /* Đưa sản phẩm lên trên cùng để không bị che khuất */
    }


    .related-property img {
        padding: 10px;
        width: 100%; /* Đảm bảo hình ảnh phù hợp với kích thước chứa */
        height: auto; /* Tự động điều chỉnh chiều cao */
        border: 2px solid transparent; /* Border mặc định là trong suốt */
        border-radius: 20px; /* Bo tròn góc cho hình ảnh */
        transition: border-color 0.3s; /* Hiệu ứng chuyển tiếp cho border */
    }

    .more-products {
        position: absolute; /* Định vị tuyệt đối */
        top: 0; /* Căn lên cùng với tiêu đề */
        right: 0; /* Căn bên phải */
        padding-bottom: 5px;
    }

    #scrollLeftBtn, #scrollRightBtn {
        background-color: whitesmoke; /* Màu nền cho nút */
        color: black; /* Màu chữ */
        border: none; /* Không có đường viền */
        padding: 5px; /* Khoảng cách bên trong */
        cursor: pointer; /* Con trỏ khi di chuột qua */
        border-radius: 5px; /* Bo tròn góc */
        font-size: 14px; /* Kích thước chữ */
        margin-left: 5px; /* Khoảng cách giữa các nút */
    }

    #scrollLeftBtn:hover, #scrollRightBtn:hover {
        background-color: wheat; /* Màu nền khi di chuột qua */
    }
</style>


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


<%
    }
%>
