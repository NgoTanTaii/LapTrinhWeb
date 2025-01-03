
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<header class="header">
    <div class="header-top" style="width: 100%; position: sticky; top: 0; z-index: 1000;">
        <div class="header-left">

            <div class="contact-item">
                <img src="jpg/phone-call.png" class="icon">
                <span>098 664 1965</span>
            </div>
            <div class="contact-item">
                <img src="jpg/email.png" class="icon">
                <span>khoangoquan@gmail.com</span>
            </div>
            <div class="contact-item">

                <img src="jpg/location.png" class="icon">
                <span>123 Đường 12, Quận 9, TP.HCM</span>
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

        </script>

        <style>
            .cart-item-image {
                width: 50px;
                height: 50px;
                margin-right: 10px;
            }

            .cart-item-details {
                display: flex;
                flex-direction: column;
            }

            .cart-item-details h5 {
                margin: 0;
                font-size: 16px;
            }

            .cart-item-details p {
                margin: 2px 0;
            }

            .cart-item-details button {
                margin-top: 5px;
                padding: 4px 8px;
                cursor: pointer;
                background-color: #ff4d4f;
                color: white;
                border: none;
                border-radius: 4px;
            }

        </style>


    </div>


    <div class="menu">
        <div class="header-bottom">
            <div class="store-name">
                <h1>
                    <a href="">
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
    <script>
        function toggleDropdown(dropdownClass) {
            const dropdown = document.querySelector(`.${dropdownClass}`);
            dropdown.classList.toggle('hidden');
        }
    </script>

    <script src="JS/script.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Khi người dùng gõ vào ô tìm kiếm hoặc ô địa chỉ, thực hiện tìm kiếm ngay lập tức
            $('#search, #city').on('keyup', function () {
                // Lấy giá trị của các trường tìm kiếm
                var searchText = $('#search').val();
                var city = $('#city').val();

                // Kiểm tra nếu ô tìm kiếm không trống mới gửi yêu cầu Ajax
                if (searchText.length > 0 || city.length > 0) {
                    $.ajax({
                        url: 'SearchServlet',  // Địa chỉ servlet xử lý tìm kiếm
                        type: 'POST',
                        data: {
                            search: searchText,
                            city: city
                        },
                        success: function (response) {
                            // Hiển thị kết quả trả về trong phần product-list
                            $('#search-results').html(response);
                        },
                        error: function () {
                            $('#search-results').html('<p>Lỗi trong quá trình tìm kiếm.</p>');
                        }
                    });
                } else {
                    // Nếu không có gì để tìm kiếm, xóa kết quả hiển thị
                    $('#search-results').html('');
                }
            });
        });

    </script>
</header>

<body>

</body>
</html>
