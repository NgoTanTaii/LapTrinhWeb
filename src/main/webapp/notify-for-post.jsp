<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Bài Đăng</title>
    <style>
        /* CSS styles as mentioned earlier */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        .action-links a {
            margin: 0 10px;
            text-decoration: none;
            color: #007bff;
        }

        .action-links a:hover {
            text-decoration: underline;
        }

        .delete-link {
            color: red;
        }

        .delete-link:hover {
            color: darkred;
        }
    </style>
</head>
<body>

<%
    // Kiểm tra quyền của người dùng trong session
    String userRole = (String) session.getAttribute("role");
    Integer sessionUserId = (Integer) session.getAttribute("userId");

    // Kiểm tra xem người dùng có phải là admin không
    String userIdParam = request.getParameter("userId");
    if (userRole == null || (userRole.equals("admin") && userIdParam == null)) {
        response.sendRedirect("error.jsp"); // Nếu không phải admin và không có userId, chuyển hướng tới trang lỗi
        return;
    }

    // Kiểm tra nếu là admin thì có thể thay đổi userId
    Integer userId = (userRole.equals("admin") && userIdParam != null) ? Integer.parseInt(userIdParam) : sessionUserId;

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Truy vấn các bài đăng của người dùng này
    PropertyDAO propertyDao = new PropertyDAO();
    List<Property1> properties = propertyDao.getPropertiesByUserId(userId);

    // Hiển thị danh sách bất động sản
    if (properties != null && !properties.isEmpty()) {
%>
<table>
    <thead>
    <tr>
        <th>Tên</th>
        <th>Địa Chỉ</th>
        <th>Giá</th>
        <th>Trạng Thái</th>
        <th>Hình ảnh</th>
        <th>Hành Động</th> <!-- Cột hành động -->
    </tr>
    </thead>
    <tbody>
    <%
        for (Property1 property : properties) {
            // Lấy số lượng thông báo (bình luận) và đánh giá cho bất động sản
            int commentCount = propertyDao.getCommentCountByPropertyId(property.getId());
            int reviewCount = propertyDao.getReviewCountByPropertyId(property.getId());
    %>
    <tr>
        <td><%= property.getTitle() %>
        </td>
        <td><%= property.getAddress() %>
        </td>
        <td><%= property.getPrice() %>
        </td>
        <td>
            <%
                String status = property.getStatus();
                if ("1".equals(status)) {
                    out.print("Bán");
                } else if ("2".equals(status)) {
                    out.print("Cho thuê");
                } else if ("3".equals(status)) {
                    out.print("Dự án");
                } else {
                    out.print("Chưa xác định");
                }
            %>
        </td>

        <td>
            <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>" alt="Image"
                 width="100">
        </td>
        <td class="action-links">
            <a href="notify-detail.jsp?property_id=<%= property.getId() %>">
                Xem thông báo về bất động sản
                (<%= commentCount %> bình luận, <%= reviewCount %> đánh giá)
            </a>
            <form action="properties" method="POST" style="display: inline;">
                <input type="hidden" name="id" value="<%= property.getId() %>">
            </form>
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
<p>Chưa có bài đăng nào.</p>
<%
    }
%>

<!-- Thêm dòng quay lại trang tài khoản -->
<p><a href="account.jsp?userId=<%= userId %>">Quay lại trang tài khoản</a></p>

</body>
</html>
