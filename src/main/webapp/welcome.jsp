<%@ page import="Entity.Property" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="Entity.CartItem" %>

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

        <%
            Integer userId = (Integer) session.getAttribute("userId");
            String username = (String) session.getAttribute("username");
            boolean isLoggedIn = userId != null;
        %>

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
            <!-- Display login and registration options if not logged in -->
            <a href="login.jsp" class="btn">
                <h3>Đăng nhập</h3>
            </a>
            <a href="register.jsp" class="btn">
                <h3>Đăng ký</h3>
            </a>
            <% } %>

            <!-- "Post Status" button, visible to both logged-in and non-logged-in users -->
            <a href="post-status.html" class="btn">
                <h3>Đăng tin</h3>
            </a>
        </div>

        <a href="javascript:void(0)" id="floating-cart" class="floating-cart" onclick="toggleMiniCart()"
           style="border: 1px solid #ccc; border-radius: 100%; position: fixed; bottom: 20px; right: 20px; z-index: 999;">
            <img src="jpg/heart%20(1).png" style="width: 30px!important; height: 30px !important;" alt="Giỏ hàng" class="cart-icon">
            <div class="item-count" id="item-count">0</div>
            <div class="mini-cart" id="mini-cart" style="display: none;">
                <h4>Bất động sản đã lưu</h4>
                <ul id="cart-items">
                    <li>Đang tải...</li>
                </ul>
                <button id="go-to-cart" onclick="goToCart()">Đi tới xem bất động sản đã lưu</button>
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
                                    <button onclick="removeItem(${item.propertyId})" class="btn btn-sm btn-danger ml-3">
                                        <i class="fas fa-trash-alt"></i> Xóa
                                    </button>
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

            function removeItem(propertyId) {
                const confirmation = confirm("Bạn có chắc chắn muốn xóa sản phẩm này?");
                if (!confirmation) return;

                fetch('/removeCartItem', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: `propertyId=${propertyId}`  // Pass propertyId here
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert(data.message);

                            // Update the cart item count
                            const itemCountElement = document.getElementById('item-count');
                            let itemCount = parseInt(itemCountElement.innerText) - 1;
                            itemCountElement.innerText = itemCount;

                            // Remove the item from the cart display
                            const itemElement = document.getElementById(`cart-item-${propertyId}`);
                            if (itemElement) itemElement.remove();

                            // If the cart is empty, display the "empty cart" message
                            const cartItemsContainer = document.getElementById('cart-items');
                            if (itemCount === 0) {
                                cartItemsContainer.innerHTML = '<li>Giỏ hàng trống</li>';
                            }
                        } else {
                            alert(data.message || "Không thể xóa sản phẩm.");
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert("Có lỗi xảy ra. Vui lòng thử lại.");
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
                    <li><a href="forsale">Nhà Đất Bán</a>
                        <ul>
                            <li><a href="#">Thông tin bán nhà đất</a></li>
                            <li><a href="#">Mua bán bất động sản</a></li>
                            <li><a href="#">Nhà đất giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="forrent">Nhà Đất Cho Thuê</a>
                        <ul>
                            <li><a href="#">Thông tin cho thuê nhà đất</a></li>
                            <li><a href="#">Thuê nhà nguyên căn</a></li>
                            <li><a href="#">Thuê căn hộ giá rẻ</a></li>
                        </ul>
                    </li>
                    <li><a href="Project">Dự Án</a>
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

    <div class="slideshow-container">
        <div class="mySlides fade">
            <img src="jpg/1.webp" alt="Banner 1">
        </div>
        <div class="mySlides fade">
            <img src="jpg/1.webp" alt="Banner 2">
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
            <img src="jpg/HaNoi.jpg" alt="Image">
            <h3><a href="#">Đất Hà Nội tăng giá mạnh </a></h3>
            <p class="summary">Hà Nội có tiền cũng không mua đất đuược?...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>
        <div class="news-item">
            <img src="jpg/HCM.jpg" alt="Image">
            <h3><a href="#">HCM ngày càng xấu đi trong mắt du khách nuước ngoài</a></h3>
            <p class="summary">Người nước ngoài kêu ca về du lịch...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>
        <div class="news-item">
            <img src="jpg/binhduong.jpg" alt="Image">
            <h3><a href="#">Bình Dương thành phố mới</a></h3>
            <p class="summary">Thành phố trong thành phố...</p>
            <span class="date">Ngày đăng: 01/01/2024</span>
        </div>


    </div>


</div>


<div class="product-section">
    <h2>Bất động sản dành cho bạn</h2>


    <%
        String message = (String) session.getAttribute("message");
        if (message != null) {
    %>
    <!-- Dimming Overlay -->
    <div id="overlay"></div>

    <!-- Message Alert -->
    <div class="alert alert-info" id="alertMessage">
        <%= message %>
    </div>

    <style>
        /* Dimming Overlay */
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
            z-index: 9998; /* Behind the alert message */
            opacity: 0;
            pointer-events: none; /* Make sure the overlay doesn't block interactions */
            transition: opacity 0.5s ease-in-out;
        }

        /* Alert Message */
        #alertMessage {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999; /* Ensure it appears above the overlay */
            width: 80%;
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
            font-size: 16px;
            padding: 15px;
            background-color: grey; /* Bootstrap's primary color for visibility */
            color: #fff; /* White text for contrast */
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.5s ease-out;
            opacity: 1;
        }

        /* Fade-in effect for alert message */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        /* Fade-out effect for alert message */
        @keyframes fadeOut {
            from {
                opacity: 1;
            }
            to {
                opacity: 0;
                transform: translate(-50%, -60%);
            }
        }

        /* Style for hiding the alert message */
        #alertMessage.hide {
            animation: fadeOut 1s forwards;
        }

    </style>

    <script>
        // Display the overlay and alert message
        document.getElementById("overlay").style.opacity = 1;

        // Automatically hide the alert message and overlay after a few seconds
        setTimeout(function() {
            var alertMessage = document.getElementById("alertMessage");
            var overlay = document.getElementById("overlay");
            alertMessage.classList.add("hide"); // Fade out the alert message
            overlay.style.opacity = 0; // Fade out the overlay
            setTimeout(function() {
                // Remove the message and overlay completely after fade-out is done
                alertMessage.style.display = 'none';
                overlay.style.display = 'none';
            }, 1000); // Wait for the fade-out animation to complete
        }, 3000); // Hide after 3 seconds
    </script>

    <%
            // Optionally remove the message after displaying it to prevent it from showing on the next page load
            session.removeAttribute("message");
        }
    %>


    <div class="product-list">
        <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            if (properties != null && !properties.isEmpty()) {
                int index = 0;
                for (Property property : properties) {
        %>
        <div class="product-item" <%= index >= 8 ? "style='display: none;'" : "" %> >
           <span onclick="location.href='property-detail.jsp?id=<%= property.getId() %>'"
                 style="cursor: pointer; color: blue; text-decoration: none;">
                <img src="<%= property.getImageUrl() %>" alt="<%= property.getTitle() %>" class="product-image">
                <h3><%= property.getTitle() %></h3>
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

            <!-- Form to add product to cart using a heart icon -->
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
        <%
                    index++;
                }
            }
        %>
    </div>
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
                <h3><%= property.getTitle() %>
                </h3>
                <p><%= property.getDescription() %>
                </p>
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

<%--<script>--%>
<%--    let cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || []; // Load cart from sessionStorage--%>
<%--    let miniCartVisible = false; // Track mini cart visibility--%>

<%--    // Fetch cart items from the database when the user logs in--%>
<%--    const fetchCartItems = async () => {--%>
<%--        const userId = sessionStorage.getItem('userId');--%>
<%--        alert("Giá trị cuả userId là : " + userId);--%>
<%--        if (userId) {--%>
<%--            try {--%>
<%--                const response = await fetch(`/getCartItems?userId=${userId}`);--%>
<%--                const data = await response.json();--%>
<%--                if (data.success) {--%>
<%--                    cartItems = data.cartItems;--%>
<%--                    updateSessionStorage();--%>
<%--                    updateCartDisplay();--%>
<%--                }--%>
<%--            } catch (error) {--%>
<%--                console.error("Failed to fetch cart items:", error);--%>
<%--            }--%>
<%--        }--%>
<%--    };--%>


<%--    const addToFavorites = async (id, title, price, area, imageUrl, address) => {--%>
<%--        // Check if the item is already in the cart--%>
<%--        if (cartItems.find(item => item.id === id)) {--%>
<%--            alert("Bất động sản này đã được quan tâm!");--%>
<%--        } else {--%>
<%--            const product = { id, title, price: parseFloat(price), area, imageUrl, address, quantity: 1 };--%>
<%--            cartItems.push(product);--%>
<%--            updateSessionStorage();--%>
<%--            updateCartDisplay();--%>
<%--            showMiniCart();--%>

<%--            try {--%>
<%--                // Send the cart item to the server--%>
<%--                const response = await fetch('/addToCart', {--%>
<%--                    method: 'POST',--%>
<%--                    headers: {--%>
<%--                        'Content-Type': 'application/json'--%>
<%--                    },--%>
<%--                    body: JSON.stringify({--%>
<%--                        userId: userId, // Ensure userId is passed correctly--%>
<%--                        cartItem: product--%>
<%--                    })--%>
<%--                });--%>
<%--                const result = await response.json();--%>

<%--                if (result.success) {--%>
<%--                    console.log("Cart item added successfully.");--%>
<%--                } else {--%>
<%--                    console.error("Error adding cart item:", result.message);--%>
<%--                    alert("Error adding to cart: " + result.message);--%>
<%--                }--%>
<%--            } catch (error) {--%>
<%--                console.error("Có lỗi xảy ra:", error);--%>
<%--                alert("Có lỗi xảy ra khi thêm vào giỏ hàng.");--%>
<%--            }--%>
<%--        }--%>
<%--    };--%>


<%--    // const saveCartToDatabase = () => {--%>
<%--    //     const userId = sessionStorage.getItem('userId');--%>
<%--    //     if (userId) {--%>
<%--    //         fetch('/saveCart', {--%>
<%--    //             method: 'POST',--%>
<%--    //             headers: { 'Content-Type': 'application/json' },--%>
<%--    //             body: JSON.stringify({ userId, cartItems })--%>
<%--    //         })--%>
<%--    //             .then(response => response.json())--%>
<%--    //             .then(data => {--%>
<%--    //                 if (data.success) {--%>
<%--    //                     console.log("Giỏ hàng đã được lưu vào cơ sở dữ liệu.");--%>
<%--    //                 } else {--%>
<%--    //                     console.error("Lỗi khi lưu giỏ hàng.");--%>
<%--    //                 }--%>
<%--    //             })--%>
<%--    //             .catch(error => console.error("Có lỗi xảy ra:", error));--%>
<%--    //     }--%>
<%--    // };--%>

<%--    // Update session storage with the latest cart data--%>
<%--    const updateSessionStorage = () => {--%>
<%--        sessionStorage.setItem('cartItems', JSON.stringify(cartItems));--%>
<%--    };--%>

<%--    // Redirect to the cart page--%>
<%--    const goToCart = () => {--%>
<%--        window.location.href = 'cart.jsp';--%>
<%--    };--%>

<%--    // Update the cart display in the mini cart--%>
<%--    const updateCartDisplay = () => {--%>
<%--        const itemCount = document.querySelector('.item-count');--%>
<%--        const cartList = document.getElementById('cart-items');--%>
<%--        cartList.innerHTML = cartItems.length === 0 ? '<li>Bạn chưa có bất động sản đã lưu.</li>' : '';--%>

<%--        cartItems.forEach(item => {--%>
<%--            const listItem = document.createElement('li');--%>
<%--            listItem.innerHTML = `--%>
<%--                <img src="${item.imageUrl}" alt="${item.title}" width="40" height="40">--%>
<%--                <div class="item-info">--%>
<%--                    <h4>${item.title}</h4>--%>
<%--                    <p>Địa chỉ: ${item.address}</p>--%>
<%--                    <p>Diện tích: ${item.area} m²</p>--%>
<%--                    <span>Giá: ${item.price.toLocaleString()} tỷ</span>--%>
<%--                </div>--%>
<%--                <button onclick="removeFromCart('${item.id}')">Xóa</button>--%>
<%--            `;--%>
<%--            cartList.appendChild(listItem);--%>
<%--        });--%>

<%--        itemCount.innerText = cartItems.length; // Update item count--%>
<%--    };--%>

<%--    // Show mini cart when adding an item--%>
<%--    const showMiniCart = () => {--%>
<%--        document.querySelector('.mini-cart').style.display = 'block';--%>
<%--        updateCartDisplay();--%>
<%--    };--%>

<%--    // Remove item from the cart--%>
<%--    const removeFromCart = id => {--%>
<%--        cartItems = cartItems.filter(item => item.id !== id);--%>
<%--        updateSessionStorage();--%>
<%--        updateCartDisplay();--%>
<%--    };--%>

<%--    // Logout function that clears cart and session data--%>
<%--    const logout = () => {--%>
<%--        sessionStorage.removeItem('cartItems');--%>
<%--        const userId = sessionStorage.getItem('userId');--%>
<%--        if (userId) {--%>
<%--            fetch('/logout', {--%>
<%--                method: 'POST',--%>
<%--                headers: {'Content-Type': 'application/json'},--%>
<%--                body: JSON.stringify({userId})--%>
<%--            })--%>
<%--                .then(response => {--%>
<%--                    if (response.ok) {--%>
<%--                        console.log("Giỏ hàng đã được xóa khỏi cơ sở dữ liệu.");--%>
<%--                    } else {--%>
<%--                        console.error("Không thể xóa giỏ hàng từ cơ sở dữ liệu.");--%>
<%--                    }--%>
<%--                })--%>
<%--                .catch(error => console.error("Có lỗi xảy ra khi xóa giỏ hàng:", error));--%>
<%--        }--%>
<%--        window.location.href = 'homes';--%>
<%--    };--%>

<%--    // Toggle mini cart visibility--%>
<%--    const toggleMiniCart = () => {--%>
<%--        const miniCart = document.querySelector('.mini-cart');--%>
<%--        miniCartVisible = !miniCartVisible;--%>
<%--        miniCart.style.display = miniCartVisible ? 'block' : 'none';--%>
<%--        updateCartDisplay();--%>
<%--    };--%>

<%--    // Event listeners--%>
<%--    document.querySelector("#logoutButton").addEventListener("click", logout);--%>
<%--    document.addEventListener("DOMContentLoaded", () => {--%>
<%--        const userId = sessionStorage.getItem("userId");--%>
<%--        if (userId) {--%>
<%--            fetchCartItems(); // Load cart items if user is logged in--%>
<%--        }--%>
<%--        updateCartDisplay(); // Initialize cart display on page load--%>
<%--    });--%>

<%--</script>--%>
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
