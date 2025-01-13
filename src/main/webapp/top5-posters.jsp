<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 5 Người Đăng Bài Nhiều Nhất</title>

    <!-- Thêm CSS cho DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

    <!-- Thêm JavaScript cho DataTables -->
    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8"
            src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

    <!-- Thêm CSS cho bảng -->
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ddd;
        }


        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .back-link {
            margin-bottom: 20px;

        }

        .back-link a {
            margin-bottom: 20px;
            text-align: left;
            text-decoration: none;
        }

        .back-link :hover {
            color: #000;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Top 5 Người Đăng Bài Nhiều Nhất</h2>

<!-- Liên kết quay lại trang admin.jsp -->
<div class="back-link">
    <a href="admin.jsp">Quay lại trang Quản trị</a>
</div>

<%
    // Gọi DAO để lấy danh sách top 5 người đăng bài
    PropertyDAO propertyDao = new PropertyDAO();
    List<Map<String, Object>> topPosters = propertyDao.getTopPosterPosts(); // Gọi phương thức từ DAO

    // Kiểm tra danh sách kết quả có dữ liệu không
    if (topPosters != null && !topPosters.isEmpty()) {
%>

<table id="topPostersTable">
    <thead>
    <tr>
        <th>Số Lượng Bài Đăng</th>
        <th>Tên Người Đăng</th>
        <th>Mã Người Đăng</th>
        <th>Mail</th>
        <th>Số điện thoai</th>



    </tr>
    </thead>
    <tbody>
    <%
        // Duyệt qua danh sách topPosters và hiển thị
        for (Map<String, Object> poster : topPosters) {
    %>
    <tr>
        <td><%= poster.get("post_count") %>
        </td>

        <td><%= poster.get("poster_name") %>
        </td>
        <td><%= poster.get("poster_id") %>
        </td>
        <td><%= poster.get("poster_email") %>
        </td>
        <td><%= poster.get("poster_phone") %>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<%
} else {
%>
<p>Không có dữ liệu.</p>
<%
    }
%>

<!-- Khởi tạo DataTables cho bảng -->
<script type="text/javascript">
    $(document).ready(function () {
        $('#topPostersTable').DataTable();
    });
</script>

</body>
</html>
