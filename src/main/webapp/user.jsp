<%@ page import="Controller.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tài khoản</title>

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
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
            height: 100px; /* Chiều cao của phần tử cha (có thể điều chỉnh) */
        }

        .dashboard-header h2 {
            margin: 0; /* Bỏ margin mặc định */
        }


        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            height: 50px;

        }

        .user-table th {
            background-color: #4CAF50;
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

        .update-button {
            text-decoration: underline; /* Gạch chân */

            background-color: transparent; /* Không có nền */
            border: none; /* Bỏ viền */
            cursor: pointer; /* Con trỏ khi rê chuột */
        }

        .update-button:hover {
            color: blue;
        }

        .delete-button {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 12px;
            text-decoration: none;
            cursor: pointer;
        }

        .user-table td input,
        .user-table td select {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
            width: calc(100% - 10px);
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <%--            <li><a href="">Doanh thu thứ</a></li>--%>
            <%--            <li><a href="">Doanh thu tháng</a></li>--%>
            <%--            <li><a href="#">Hóa đơn</a></li>--%>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="home-manager">Quản lý bất động sản</a></li>
            <li><a href="">Top 10 bất động sản</a></li>
            <%--            <li><a href="#">Top 5 khách hàng</a></li>--%>
            <%--            <li><a href="#">Quản lý nhà cung cấp</a></li>--%>
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
                        <select name="role" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>>
                            <option value="user" <%= o.getRole().equalsIgnoreCase("user") ? "selected" : "" %>>user
                            </option>
                            <option value="admin" <%= o.getRole().equalsIgnoreCase("admin") ? "selected" : "" %>>admin
                            </option>
                        </select>
                    </td>
                    <td>
                        <button type="submit" name="action"
                                value="update" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>
                                class="update-button">Cập nhật
                        </button>
                        <button type="submit" name="action"
                                value="delete" <%= o.getUsername().equals(loggedInUsername) ? "disabled" : "" %>
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

</body>
</html>
