<%@ page import="Entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session == null || session.getAttribute("role") == null ||
            (!"admin".equals(session.getAttribute("role")) && !"manager".equals(session.getAttribute("role")))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="css/admin.css"> <!-- Thêm link đến CSS -->
    <style>
        /* Có thể thêm CSS tùy chỉnh ở đây nếu cần */
        .product-images img {
            width: 100px; /* Kích thước hình ảnh */
            height: auto; /* Giữ tỷ lệ hình ảnh */
            margin-right: 10px;
        }
        /* Modal styles */
        .modal {
            display: none; /* Ẩn modal theo mặc định */
            position: fixed;
            z-index: 1; /* Ở trên cùng */
            left: 0;
            top: 0;
            width: 100%; /* Toàn bộ màn hình */
            height: 100%; /* Toàn bộ màn hình */
            overflow: auto; /* Nếu quá nhiều nội dung */
            background-color: rgb(0,0,0); /* Màu nền */
            background-color: rgba(0,0,0,0.4); /* Đổ mờ */
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% từ trên và tự động căn giữa */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Chiều rộng modal */
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="">Doanh thu thứ</a></li>
            <li><a href="">Doanh thu tháng</a></li>
            <li><a href="">Hóa đơn</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="products.jsp">Quản lý sản phẩm</a></li> <!-- Cập nhật link -->
            <li><a href="">Top 10 sản phẩm</a></li>
            <li><a href="#">Top 5 khách hàng</a></li>
            <li><a href="#">Quản lý nhà cung cấp</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h2>Danh sách sản phẩm</h2>

        <table class="product-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Hình ảnh</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Product> productList = (ArrayList<Product>) request.getAttribute("productList");
                if (productList != null) {
                    for (Product product : productList) {
            %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getProductName() %></td>
                <td><%= product.getPrice() %> VND</td>
                <td><%= product.getQuantity() %></td>
                <td class="product-images">
                    <img src="<%= product.getImageUrl1() != null ? product.getImageUrl1() : "default.jpg" %>" alt="Image 1">
                    <img src="<%= product.getImageUrl2() != null ? product.getImageUrl2() : "default.jpg" %>" alt="Image 2">
                </td>
                <td>
                    <a href="edit-product.jsp?id=<%= product.getId() %>">Sửa</a> |
                    <a href="delete-product.jsp?id=<%= product.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')">Xóa</a> |
                    <button onclick="openModal('<%= product.getId() %>', '<%= product.getImageUrl1() %>', '<%= product.getImageUrl2() %>')">Chỉnh sửa hình ảnh</button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6">Không có sản phẩm nào.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal for editing image URLs -->
<div id="imageModal" class="modal">
    <div class="modal-content">
        <span onclick="closeModal()" style="float:right;cursor:pointer;">&times;</span>
        <h2>Chỉnh sửa đường dẫn hình ảnh</h2>
        <form id="imageForm" action="update-image" method="post">
            <input type="hidden" id="productId" name="productId">
            <label for="imageUrl1">Đường dẫn hình ảnh 1:</label>
            <input type="text" id="imageUrl1" name="imageUrl1"><br>

            <label for="imageUrl2">Đường dẫn hình ảnh 2:</label>
            <input type="text" id="imageUrl2" name="imageUrl2"><br>

            <input type="submit" value="Cập nhật">
        </form>
    </div>
</div>

<script>
    function openModal(productId, imageUrl1, imageUrl2) {
        document.getElementById('productId').value = productId;
        document.getElementById('imageUrl1').value = imageUrl1;
        document.getElementById('imageUrl2').value = imageUrl2;
        document.getElementById('imageModal').style.display = "block";
    }

    function closeModal() {
        document.getElementById('imageModal').style.display = "none";
    }

    // Đóng modal khi nhấp ra ngoài
    window.onclick = function(event) {
        if (event.target == document.getElementById('imageModal')) {
            closeModal();
        }
    }
</script>
</body>
</html>
