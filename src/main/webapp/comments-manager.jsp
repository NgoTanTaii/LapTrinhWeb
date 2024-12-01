<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.CommentDAO, Entity.Comment, java.util.List" %>

<%
    // Check admin role
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }

    // Initialize CommentDAO and retrieve all comments
    CommentDAO commentDAO = new CommentDAO();
    List<Comment> comments = commentDAO.getAllComments(); // You may need to create this method in CommentDAO
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Comment Management</title>
    <link rel="stylesheet" href="css/admin.css">
    <style>
        /* CSS giữ nguyên như bạn đã tạo */
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
            flex-direction: column;
        }

        .sidebar {
            width: 200px;
            background-color: #333;
            color: white;
            padding: 20px;
            border-radius: 5px 0 0 5px;
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

        h2 {
            text-align: left;
            color: #333;
            margin-bottom: 20px;
        }

        .back-link {
            margin-bottom: 20px;
            text-align: right;
        }

        .property-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .property-table th, .property-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .property-table th {
            background-color: #eee;
            color: black;
            text-align: center; /* Căn giữa tiêu đề */
        }


        .property-table td {
            text-align: center; /* Căn giữa nội dung cột */
        }

        .property-table img {
            max-width: 100px;
            height: auto;
            border-radius: 5px;
        }

        button {
            padding: 5px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #d32f2f;
        }

    </style>

</head>
<body>

<div class="container">
    <h2>Danh sách bình luận</h2>

    <div class="back-link">
        <a href="admin.jsp">Quay lại trang Quản trị</a>
    </div>

    <table class="property-table" border="1" cellpadding="10" cellspacing="0">
        <thead>
        <tr>
            <th> Tên nguời bình luận </th>
            <th>Nội dung</th>
            <th>Ngày</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (comments != null && !comments.isEmpty()) {
                for (Comment comment : comments) {
        %>
        <tr>
            <td><%= comment.getUserName() != null ? comment.getUserName() : "Unknown" %></td>
            <td><%= comment.getContent() %></td>
            <td><%= comment.getCommentDate() %></td>
            <td>
                <form action="DeleteCommentServlet" method="post" style="display:inline;">
                    <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                    <input type="hidden" name="redirectPage" value="commentsManager">
                    <button type="submit" onclick="return confirm('Are you sure you want to delete this comment?');">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align:center;">No comments available.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
