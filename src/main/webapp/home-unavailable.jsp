<%
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bất động sản chờ duỵêt</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
<style>
    .back-link:hover{
        color: red;
    }
</style>
</head>
<body>
<div class="container">
    <div class="main-content">
        <h2>Bất động sản không khả dụng</h2>
        <div id="notification"></div>
        <div class="back-link" style="margin-bottom: 20px">
            <a href="admin.jsp">Quay lại trang Quản trị</a>
        </div>
        <table id="propertyTable" class="display property-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Địa chỉ</th>
                <th>Diện tích (m²)</th>
                <th>Hình ảnh</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Property1> properties = (List<Property1>) request.getAttribute("properties");
                if (properties != null && !properties.isEmpty()) {
                    for (Property1 property : properties) {
            %>


            <tr id="property-row-<%= property.getId() %>">
                <td><%= property.getId() %>
                </td>
                <td><%= property.getTitle() %>
                </td>
                <td><%= property.getPrice() %> tỷ</td>
                <td><%= property.getAddress() %>
                </td>
                <td><%= property.getArea() %> m²</td>
                <td>
                    <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                         alt="Image" width="100">
                </td>
                <td>
                    <button onclick="approveProperty(<%= property.getId() %>)">Duyệt</button>
                    <button onclick="deleteProperty(<%= property.getId() %>)">Xóa</button>  <!-- Nút Xóa -->
                </td>


            </tr>


            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7" style="text-align: center;">Không có bất động sản nào không khả dụng.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<script>
    function approveProperty(propertyId) {
        // Gửi yêu cầu AJAX đến Servlet để duyệt
        fetch(`approveProperty?action=approve&property_id=${propertyId}`)
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    // Hiển thị thông báo thành công
                    const notification = document.getElementById('notification');
                    notification.innerHTML = "<p style='color: green;'>Bất động sản đã được duyệt thành công!</p>";

                    // Xóa dòng của bất động sản khỏi bảng
                    const row = document.getElementById(`property-row-${propertyId}`);
                    if (row) row.remove();

                    // Ẩn thông báo sau 3 giây
                    setTimeout(() => {
                        notification.innerHTML = '';
                    }, 3000);
                } else {
                    // Hiển thị thông báo lỗi
                    const notification = document.getElementById('notification');
                    notification.innerHTML = "<p style='color: red;'>Có lỗi xảy ra. Vui lòng thử lại.</p>";

                    // Ẩn thông báo sau 3 giây
                    setTimeout(() => {
                        notification.innerHTML = '';
                    }, 3000);
                }
            })
            .catch(error => {
                // Hiển thị thông báo lỗi
                const notification = document.getElementById('notification');
                notification.innerHTML = "<p style='color: red;'>Có lỗi xảy ra. Vui lòng thử lại.</p>";

                // Ẩn thông báo sau 3 giây
                setTimeout(() => {
                    notification.innerHTML = '';
                }, 3000);
            });
    }

    function deleteProperty(propertyId) {
        // Xác nhận hành động với người dùng
        if (!confirm('Bạn có chắc chắn muốn xóa bất động sản này không?')) {
            return;
        }

        // Gửi yêu cầu AJAX đến Servlet để xóa
        fetch(`approveProperty?action=delete&property_id=${propertyId}`)
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    // Hiển thị thông báo thành công
                    const notification = document.getElementById('notification');
                    notification.innerHTML = "<p style='color: green;'>Bất động sản đã được xóa thành công!</p>";

                    // Xóa dòng của bất động sản khỏi bảng
                    const row = document.getElementById(`property-row-${propertyId}`);
                    if (row) row.remove();

                    // Ẩn thông báo sau 3 giây
                    setTimeout(() => {
                        notification.innerHTML = '';
                    }, 3000);
                } else {
                    // Hiển thị thông báo lỗi
                    const notification = document.getElementById('notification');
                    notification.innerHTML = "<p style='color: red;'>Có lỗi xảy ra. Vui lòng thử lại.</p>";

                    // Ẩn thông báo sau 3 giây
                    setTimeout(() => {
                        notification.innerHTML = '';
                    }, 3000);
                }
            })
            .catch(error => {
                // Hiển thị thông báo lỗi
                const notification = document.getElementById('notification');
                notification.innerHTML = "<p style='color: red;'>Có lỗi xảy ra. Vui lòng thử lại.</p>";

                // Ẩn thông báo sau 3 giây
                setTimeout(() => {
                    notification.innerHTML = '';
                }, 3000);
            });
    }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#propertyTable').DataTable({
            "pageLength": 10,
            "language": {
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ mục",
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "Sau",
                    "previous": "Trước"
                },
                "zeroRecords": "Không tìm thấy kết quả phù hợp",
                "infoEmpty": "Không có dữ liệu",
                "infoFiltered": "(lọc từ _MAX_ mục)"
            }
        });
    });
</script>
</body>
</html>
