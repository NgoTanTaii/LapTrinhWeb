<%

    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<%@ page import="Controller.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tài Khoản</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/4.0.1/css/fixedHeader.dataTables.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            max-width: 1200px;
            margin: auto;
        }

        .sidebar {
            width: 200px;
            background-color: #333;
            color: white;
            padding: 20px;
            border-radius: 5px 0 0 5px;
            height: auto;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin-bottom: 15px;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        .sidebar ul li a:hover {
            text-decoration: underline;
        }

        .main-content {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 0 5px 5px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 100px;
        }

        .dashboard-header h2 {
            margin: 0;
        }

        .add-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
        }

        .user-table th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
        }

        .delete-button {
            background-color: #f8d7da;
            color: #721c24;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #f5c6cb;
        }

        .update-button {
            background-color: #e2e3e5;
            color: #383d41;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .update-button:hover {
            background-color: #d6d8db;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="home-manager">Quản lý sản phẩm</a></li>
            <li><a href="top-property.jsp">Quản lý sản phẩm bán chạy</a></li>
            <li><a href="home-manager">Quản lý nhà phân phối</a></li>
            <li><a href="top-user-manager">Quản lý top 5 khách</a></li>
            <li><a href="top-employee-manager.jsp">Quản lý top 5 nhân viên</a></li>
            <li><a href="orders">Quản lý đơn đặt hàng</a></li>
            <li><a href="comments-manager.jsp">Quản lý bình luận</a></li>

        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="dashboard-header">
            <h2>Quản lý tài khoản</h2>
<%--            <a href="add-user.jsp" class="add-button">Thêm Người Dùng Mới</a>--%>
        </div>

        <table id="example" class="display user-table" style="width:100%">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên Người Dùng</th>
                <th>Email</th>
                <th>Vai Trò</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Lấy danh sách người dùng từ servlet
                List<User> users = (ArrayList<User>) request.getAttribute("users");
                String loggedInUsername = (String) request.getAttribute("loggedInUsername"); // Username của admin đang đăng nhập

                if (users != null && !users.isEmpty()) {
                    for (User o : users) {
            %>
            <tr>
                <form action="users" method="POST">
                    <td><input type="hidden" name="id" value="<%= o.getId() %>"><%= o.getId() %>
                    </td>
                    <td><%= o.getUsername() %>
                    </td> <!-- Hiển thị tên người dùng dưới dạng văn bản -->
                    <td><%= o.getEmail() %>
                    </td> <!-- Hiển thị email dưới dạng văn bản -->
                    <td>
                        <select name="role" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>>
                            <option value="user" <%= o.getRole().equalsIgnoreCase("user") ? "selected" : "" %>>user
                            </option>
                            <option value="admin" <%= o.getRole().equalsIgnoreCase("admin") ? "selected" : "" %>>admin
                            </option>
                        </select>
                    </td>
                    <td>
                        <button type="submit" name="action" value="update"
                                <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>
                                class="update-button">Cập nhật
                        </button>
                        <button type="submit" name="action" value="delete"
                                <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>
                                onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này không?')"
                                class="delete-button">Xóa
                        </button>
                    </td>
                </form>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center;">Không có người dùng nào.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#example').DataTable();
    });
</script>

</body>
</html>
