<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Dao.PropertyBystatusDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/property-for-sale.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Title</title>
    <style>
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

        /* CSS ở đây */
        body {
            font-family: Arial, sans-serif;

        }

        .container1 {
            padding: 15px;
            margin-bottom: 30px;
            border: 1px solid black;
            width: 60%;
            border-radius: 5px;
            margin-top: 30px;
            margin-left: 135px;
            display: flex; /* Sử dụng flexbox cho cấu trúc */
            justify-content: space-between; /* Để căn giữa các phần tử */
            gap: 20px; /* Khoảng cách giữa phần nội dung và phần lọc */
        }

        .left-content {
            flex: 2; /* Chiếm 2 phần không gian */
        }

        .filter-container {
            position: absolute; /* Đặt nó tuyệt đối trong body */
            top: 440px; /* Khoảng cách từ trên xuống */
            right: 120px; /* Khoảng cách từ bên phải */
            width: 200px; /* Chiều rộng cho phần lọc */
            background-color: #f9f9f9; /* Màu nền cho phần lọc */
            padding: 15px; /* Padding cho phần lọc */
            border-radius: 10px; /* Bo góc cho phần lọc */

        }

        .price-options {
            list-style-type: none; /* Loại bỏ dấu đầu dòng */
            padding: 0; /* Xóa padding */
            margin: 10px 0; /* Margin cho danh sách */
        }

        .price-options li {
            margin-bottom: 5px; /* Khoảng cách giữa các mục */
            padding: 3px; /* Thêm padding cho mỗi mục */
            cursor: pointer; /* Chỉ con trỏ thành hình bàn tay */
            transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu */
        }

        .price-options li:hover {
            color: silver;
        }


        /* Thêm một lớp để hiển thị giá đã chọn (nếu cần) */
        .selected {
            background-color: #d4edda; /* Màu nền cho tùy chọn đã chọn */
        }

        .filter-group {
            display: flex; /* Hiển thị các nút lọc theo hàng ngang */
            gap: 10px; /* Khoảng cách giữa các nút lọc */
            margin-bottom: 20px; /* Khoảng cách dưới cùng cho nhóm nút lọc */
        }

        .filter-btn {

            padding: 10px 15px; /* Padding cho các nút lọc */
            background-color: #f0f0f0; /* Màu nền cho các nút lọc */
            border: none; /* Không có đường viền */
            cursor: pointer; /* Con trỏ chuột khi hover vào nút */
            display: flex; /* Hiển thị các nút theo hàng ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        .filter-btn i {
            margin-right: 5px; /* Khoảng cách bên phải cho biểu tượng */
        }

        .form-group {
            margin-bottom: 15px; /* Khoảng cách dưới cùng cho nhóm nhập liệu */
        }

        .filter-container1 {
            position: absolute; /* Đặt nó tuyệt đối trong body */
            top: 990px; /* Khoảng cách từ trên xuống */
            right: 120px; /* Khoảng cách từ bên phải */
            width: 200px; /* Chiều rộng cho phần lọc */
            background-color: #f9f9f9; /* Màu nền cho phần lọc */
            padding: 15px; /* Padding cho phần lọc */
            border-radius: 10px; /* Bo góc cho phần lọc */
        }

        label {
            display: block; /* Hiển thị label như một khối */
            margin-bottom: 5px; /* Khoảng cách dưới cùng cho label */
        }

        select {
            width: 100%; /* Đặt chiều rộng của select là 100% */
            padding: 8px; /* Padding cho select */
        }


    </style>
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
        <%
            boolean isLoggedIn = session.getAttribute("username") != null;
            String username = (String) session.getAttribute("username");
        %>

        <div class="header-right" style="margin-top: 10px">
            <% if (isLoggedIn) { %>
            <a href="account.jsp" class="btn user-name-link">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 150px;">
                    Hello, <%= username %>
                </h3>
            </a>

            <a href="javascript:void(0)" id="logoutButton" class="btn logout-btn"
               onclick="document.getElementById('logoutForm').submit();">
                <h3>Đăng xuất</h3>
            </a>

            <!-- Hidden Form to Logout -->
            <form id="logoutForm" action="logout" method="POST" style="display: none;">
                <button type="submit" style="display: none;"></button> <!-- This button will not be visible -->
            </form>
            <% } else { %>
            <a href="login.jsp" class="btn">
                <h3>Đăng nhập</h3>
            </a>
            <a href="register.jsp" class="btn">
                <h3>Đăng ký</h3>
            </a>
            <% } %>
            <a href="create-poster.jsp" class="btn">
                <h3>Đăng tin</h3>
            </a>
        </div>
        <style>
            /* CSS cho hiệu ứng hover và làm nổi bật liên kết */
            .user-name-link h3 {
                display: inline-block;
                cursor: pointer; /* Thêm con trỏ tay để người dùng biết đây là liên kết có thể click */
                transition: color 0.3s ease, background-color 0.3s ease;
            }

            /* Thêm hiệu ứng hover */
            .user-name-link:hover h3 {
                color: #fff;
                background-color: wheat; /* Màu nền khi hover */
                padding: 5px 10px; /* Thêm khoảng cách để làm nổi bật */
                border-radius: 5px; /* Bo góc */
            }

        </style>
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

        </script>    </div>

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
                <ul class="u-lo">
                    <!-- Mục Nhà Đất Hot -->
                    <li><a href="property-hot.jsp">Nhà Đất Hot</a>
                        <ul>
                            <li><a href="#">Nhà đất bán hot</a></li>
                            <li><a href="#">Nhà đất cho thuê hot</a></li>
                            <li><a href="#">Nhà đất dự án hot</a></li>
                        </ul>
                    </li>
                    <!-- Mục Nhà Đất Bán -->
                    <li><a href="forsale">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Thông tin bán nhà đất</a></li>
                            <li><a href="#">Mua bán bất động sản</a></li>
                            <li><a href="#">Nhà đất giá rẻ</a></li>
                        </ul>
                    </li>
                    <!-- Mục Nhà Đất Cho Thuê -->
                    <li><a href="forrent">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Thông tin cho thuê nhà đất</a></li>
                            <li><a href="#">Thuê nhà nguyên căn</a></li>
                            <li><a href="#">Thuê căn hộ giá rẻ</a></li>
                        </ul>
                    </li>
                    <!-- Mục Dự Án -->
                    <li><a href="Project">Dự Án</a>
                        <ul>
                            <li><a href="#">Các dự án nổi bật</a></li>
                            <li><a href="#">Dự án nhà ở</a></li>
                            <li><a href="#">Dự án chung cư</a></li>
                        </ul>
                    </li>
                    <!-- Mục Tin Tức -->
                    <li><a href="news.jsp">Tin Tức</a>
                        <ul>
                            <li><a href="#">Tin thị trường</a></li>
                            <li><a href="#">Xu hướng bất động sản</a></li>
                            <li><a href="#">Phân tích và đánh giá</a></li>
                        </ul>
                    </li>
                    <!-- Mục Wiki BĐS -->
                    <li><a href="wiki.jsp">Wiki BĐS</a>
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
</header>
<div class="slideshow-container">
    <div class="mySlides fade">
        <img src="jpg/1%20(1).webp" alt="Banner 1">
    </div>
    <div class="mySlides fade">
        <img src="jpg/1%20(1).webp" alt="Banner 2">
    </div>
</div>
<div class="search-container">
    <form class="search-form" id="search-form" method="post" action="SearchServlet">
        <input type="text" id="search" placeholder="Tìm kiếm sản phẩm..." name="search" required>
        <input type="text" id="city" placeholder="Tìm kiếm theo địa chỉ..." name="city">
        <button type="submit">Tìm Kiếm</button>
    </form>
</div>


<div class="product-section">
    <div class="product-list" id="search-results">
        <!-- Các sản phẩm sẽ được hiển thị tại đây -->
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleButton = document.getElementById('toggleButton');
        let isExpanded = false; // Trạng thái để theo dõi việc mở rộng hay thu gọn

        // Lắng nghe sự kiện submit của form tìm kiếm
        document.getElementById('search-form').addEventListener('submit', function(event) {
            event.preventDefault(); // Ngừng hành động mặc định của form (submit)

            const searchText = document.getElementById('search').value;
            const city = document.getElementById('city').value;

            // Gửi yêu cầu tìm kiếm qua AJAX
            fetch('SearchServlet', {
                method: 'POST',
                body: new URLSearchParams({
                    search: searchText,
                    city: city
                }),
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            })
                .then(response => response.text())
                .then(data => {
                    document.getElementById('search-results').innerHTML = data;
                    initProductToggle(); // Sau khi nhận dữ liệu từ server, khởi tạo lại chức năng toggle
                });
        });

        // Hàm toggle sản phẩm
        function initProductToggle() {
            const products = document.querySelectorAll('.product-item');
            let isExpanded = false;

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
                    products.forEach((product, index) => {
                        if (index >= 8) {
                            product.style.display = 'none'; // Ẩn các sản phẩm ngoài 8 sản phẩm đầu tiên
                        }
                    });
                    toggleButton.textContent = 'Xem thêm'; // Đổi lại thành "Xem thêm"
                } else {
                    products.forEach(product => product.style.display = 'block'); // Hiển thị tất cả sản phẩm
                    toggleButton.textContent = 'Ẩn bớt'; // Đổi thành "Ẩn bớt"
                }

                isExpanded = !isExpanded;

                // Cuộn mượt mà về đầu phần sản phẩm
                document.querySelector('.product-section').scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            });
        }
    });
</script>

<script src="JS/script.js"></script>

<%
    PropertyBystatusDAO propertyDAO = new PropertyBystatusDAO();
    // Fetch properties where status is "2" (i.e., rental properties)
    List<Property1> properties = propertyDAO.getPropertiesByStatus("2");
%>

<div class="container1">
    <div class="left-content">
        <p class="breadcrumbs">Cho thuê / Tất cả BĐS trên toàn quốc</p>
        <h1>Cho thuê nhà đất trên toàn quốc</h1>
        <p>Hiện có <strong><%= propertyDAO.countPropertiesByStatus("2") %></strong> bất động sản cho thuê.</p>
    </div>
</div>

<div class="main">
    <div class="property-list">
        <%
            // Check if there are any properties
            if (properties != null && !properties.isEmpty()) {
                // Loop through each property
                for (Property1 property : properties) {
        %>
        <style>
            .property-link:hover {
                opacity: 0.8;
            }
        </style>
        <a href="property-detail.jsp?id=<%= property.getId() %>" class="property-link" style="text-decoration: none">
            <div class="container1">
                <div class="property-container">
                    <img src="<%= property.getImageUrl() %>" alt="Hình ảnh bất động sản" class="property-image">
                    <div class="property-details">
                        <h2 class="property-title">
                            <i class="fas fa-building"></i> <%= property.getTitle() %>
                        </h2>

                        <p class="property-price">
                            <i class="fas fa-dollar-sign"></i> <%= property.getPrice() %> triệu
                        </p>

                        <p class="property-area">
                            <i class="fas fa-ruler-combined"></i> <%= property.getArea() %> m²
                        </p>

                        <p class="property-address">
                            <i class="fas fa-map-marker-alt"></i> <%= property.getAddress() %>
                        </p>

                        <p class="property-description">
                            <i class="fas fa-info-circle"></i> <%= property.getDescription() %>
                        </p>
                    </div>
                </div>
            </div>
        </a>
        <%
            } // End of for loop
        } else {
        %>
        <p>Không có bất động sản nào cho thuê.</p> <!-- No rental properties message -->
        <%
            }
        %>
    </div>
</div>


<div class="filter-container">
    <h4>Lọc Theo Khoảng Giá</h4>
    <form id="priceFilterForm">
        <div class="form-group">
            <label>Chọn khoảng giá:</label>
            <ul class="price-options">
                <li data-value="thoa-thuan" class="price-option">Thỏa thuận</li>
                <li data-value="duoi-500" class="price-option">Dưới 5  triệu</li>
                <li data-value="500-800" class="price-option">5 - 8 triệu</li>
                <li data-value="800-1ty" class="price-option">8 triệu - 10 triệu</li>
                <li data-value="1-2ty" class="price-option">10 - 20 triệu</li>
                <li data-value="2-3ty" class="price-option">20 - 30 triệu</li>
                <li data-value="3-5ty" class="price-option">30 - 50 triệu</li>
                <li data-value="5-7ty" class="price-option">50 - 70 triệu</li>
                <li data-value="7-10ty" class="price-option">70 - 100 triệu</li>
                <li data-value="10-20ty" class="price-option">100 - 200 triệu</li>
                <li data-value="20-30ty" class="price-option">200 - 300 triệu</li>
                <li data-value="30-40ty" class="price-option">300 - 400 triệu</li>
                <li data-value="40-60ty" class="price-option">400 - 600 triệu</li>
                <li data-value="tren-60" class="price-option">Trên 600 triệu</li>
            </ul>
        </div>
        <button type="submit">Lọc</button>
    </form>
</div>
<div class="filter-container1">
    <h4>Lọc Theo Diện Tích</h4>
    <form id="areaFilterForm">
        <div class="form-group">
            <label>Chọn diện tích:</label>
            <ul class="price-options">
                <li data-value="duoi-30" class="price-option">Dưới 30 m²</li>
                <li data-value="30-50" class="price-option">30 - 50 m²</li>
                <li data-value="50-80" class="price-option">50 - 80 m²</li>
                <li data-value="80-100" class="price-option">80 - 100 m²</li>
                <li data-value="100-120" class="price-option">100 - 120 m²</li>
                <li data-value="120-150" class="price-option">120 - 150 m²</li>
                <li data-value="150-200" class="price-option">150 - 200 m²</li>
                <li data-value="200-300" class="price-option">200 - 300 m²</li>
                <li data-value="300-400" class="price-option">300 - 400 m²</li>
                <li data-value="400-500" class="price-option">400 - 500 m²</li>
                <li data-value="tren-500" class="price-option">Trên 500 m²</li>
            </ul>
        </div>
        <button type="submit">Lọc</button>
    </form>
</div>


<style>
    /* Thiết lập form hiển thị sản phẩm */
    .property-container {
        display: flex;
        align-items: flex-start;
        border: 1px solid #ccc;
        border-radius: 8px;
        width: 100%;

        padding: 16px;

        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Thiết lập hình ảnh sản phẩm */
    .property-image {
        width: 200px;
        height: 150px;
        border-radius: 8px;
        margin-right: 16px;
        object-fit: cover;
    }

    /* Thiết lập nội dung bên phải */
    .property-details {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
        max-width: 350px;
    }

    /* Thiết lập tiêu đề sản phẩm */
    .property-title {
        font-size: 20px;
        font-weight: bold;
        margin: 0;
        color: #333;
    }

    /* Thiết lập các chi tiết sản phẩm */
    .property-price,
    .property-area,
    .property-address {
        font-size: 16px;
        margin: 0;
        color: #666;
    }

    .property-price {
        color: #e74c3c;
        font-weight: bold;
    }

</style>

<script>
    document.querySelectorAll('.price-option').forEach(item => {
        item.addEventListener('click', event => {
// Bỏ chọn tất cả các mục trước đó
            document.querySelectorAll('.price-option').forEach(option => {
                option.classList.remove('selected'); // Xóa lớp 'selected'
            });

// Thêm lớp 'selected' cho tùy chọn hiện tại
            item.classList.add('selected');

// Có thể lưu giá trị đã chọn nếu cần
            const selectedValue = item.getAttribute('data-value');
            console.log("Giá đã chọn:", selectedValue);
        });
    });
</script>


<!-- Footer -->
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
