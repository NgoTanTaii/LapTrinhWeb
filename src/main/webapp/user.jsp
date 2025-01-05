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
            background-color: blue;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
        }
.add-button:hover {
    background-color: #007bff;
    color: white;
    text-decoration: none;
}
        .user-table th {
            color: black;
            text-transform: uppercase;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ddd;
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


    <!-- Main content -->
    <div class="main-content">
        <div class="dashboard-header">
            <h2>Quản lý tài khoản</h2>
            <a href="add-user.jsp" class="add-button">Thêm Người Dùng Mới</a>
        </div>

        <div class="back-link">
            <a href="admin.jsp">Quay lại trang Quản trị</a>
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
                        <button type="button"
                                onclick="window.location.href='http://localhost:8080/Batdongsan/user-posts.jsp?userId=<%= o.getId() %>'"
                                <%= o.getId() %>
                                class="delete-button">
                            Xem bds đã đăng
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
    $(document).ready(function() {
        // Khởi tạo DataTable cho bảng có id 'example'
        $('#example').DataTable();
    });
</script>

</body>
</html>
