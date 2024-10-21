<%@ page import="Controller.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tài khoản</title>
    <link rel="stylesheet" href="css/admin.css">
    <style>
        /* Tùy chỉnh thêm cho trang user.jsp */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .dashboard-header h2 {
            margin-left: 20px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
        }

        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .user-table th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }

        .user-table tr:hover {
            background-color: #f1f1f1;
        }

        .user-table td a {
            color: #007bff;
            text-decoration: none;
        }

        .user-table td a:hover {
            text-decoration: underline;
        }

        .form-actions {
            text-align: center;
            margin-top: 20px;
        }

        .form-actions button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-actions button:hover {
            background-color: #0056b3;
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
            <li><a href="#">Hóa đơn</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="products">Quản lý sản phẩm</a></li>
            <li><a href="">Top 10 sản phẩm</a></li>
            <li><a href="#">Top 5 khách hàng</a></li>
            <li><a href="#">Quản lý nhà cung cấp</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="dashboard-header">
            <h2>Quản lý tài khoản</h2>
        </div>

        <table class="user-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên đăng nhập</th>
                <th>Email</th>
                <th>Vai trò</th>
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
                    <td><input type="text" name="username" value="<%= o.getUsername() %>" readonly></td>
                    <td><input type="email" name="email" value="<%= o.getEmail() %>" readonly></td>
                    <td>
                        <select name="role" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %> >
                            <option value="user" <%= o.getRole().equalsIgnoreCase("user") ? "selected" : "" %>>user
                            </option>
                            <option value="admin" <%= o.getRole().equalsIgnoreCase("admin") ? "selected" : "" %>>admin
                            </option>
                        </select>
                    </td>
                    <td>
                        <button type="submit" name="action"
                                value="update" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>>Cập
                            nhật
                        </button>
                        <button type="submit" name="action"
                                value="delete" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>
                                onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này không?')">Xóa
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

</body>
</html>
