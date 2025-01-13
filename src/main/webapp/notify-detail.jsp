<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Dao.CommentDAO" %>
<%@ page import="Dao.ReviewDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="Entity.Comment" %>
<%@ page import="Entity.Review" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Thông Báo Bất Động Sản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 70%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .property-detail {
            margin-bottom: 30px;
        }

        .property-detail img {
            max-width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }

        .property-detail p {
            font-size: 16px;
            line-height: 1.6;
            margin: 5px 0;
        }

        .property-detail strong {
            color: #333;
        }

        .reviews, .comments {
            margin-top: 30px;
        }

        .review, .comment {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
            margin-bottom: 15px;
        }

        .review-rating {
            font-weight: bold;
            color: #f39c12;
        }

        .comment p, .review p {
            margin: 5px 0;
            font-size: 14px;
        }

        .comment strong, .review strong {
            font-weight: bold;
            color: #333;
        }

        .comment {
            background-color: #f9f9f9;
            padding-left: 15px;
        }

        .review {
            background-color: #f1f1f1;
            padding-left: 15px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-link:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<div class="container">
    <%
        // Lấy ID bất động sản từ tham số URL dưới dạng String
        String propertyId = request.getParameter("property_id");

        // Kiểm tra xem propertyId có hợp lệ không
        if (propertyId == null || propertyId.isEmpty()) {
            out.println("<p>Thông tin bất động sản không hợp lệ.</p>");
            return;
        }

        // Lấy chi tiết bất động sản từ database, sử dụng propertyId là String
        PropertyDAO propertyDao = new PropertyDAO();
        Property1 property = propertyDao.getPropertyById(propertyId);  // Giả sử getPropertyById nhận String

        if (property == null) {
            out.println("<p>Bất động sản không tồn tại.</p>");
            return;
        }
    %>

    <div class="property-detail">
        <h2><%= property.getTitle() %></h2>
        <p><strong>Địa chỉ:</strong> <%= property.getAddress() %></p>
        <p><strong>Giá:</strong> <%= property.getPrice() %></p>
        <p><strong>Trạng thái:</strong>
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
        </p>


        <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>" alt="Image">
    </div>

    <%
        // Lấy danh sách bình luận
        CommentDAO commentDao = new CommentDAO();
        List<Comment> comments = commentDao.getCommentsByPropertyId(propertyId);

        // Lấy danh sách đánh giá
        ReviewDAO reviewDao = new ReviewDAO();
        List<Review> reviews = reviewDao.getReviewsByPropertyId(Integer.parseInt(propertyId));
    %>

    <!-- Bình luận -->
    <div class="comments">
        <h3>Bình luận</h3>
        <%
            if (comments != null && !comments.isEmpty()) {
                for (Comment comment : comments) {
        %>
        <div class="comment">
            <p><strong>Người dùng:</strong> <%= comment.getUserId() %></p>
            <p><strong>Bình luận:</strong> <%= comment.getContent() %></p>
            <p><strong>Ngày:</strong> <%= comment.getCommentDate() %></p>
        </div>
        <%
                }
            } else {
                out.println("<p>Không có bình luận nào.</p>");
            }
        %>
    </div>

    <!-- Đánh giá -->
    <div class="reviews">
        <h3>Đánh giá</h3>
        <%
            if (reviews != null && !reviews.isEmpty()) {
                for (Review review : reviews) {
        %>
        <div class="review">
            <p><strong>Đánh giá:</strong> <%= review.getRating() %>/5</p>
            <p><strong>Nhận xét:</strong> <%= review.getReview() %></p>
            <p><strong>Ngày:</strong> <%= review.getCreatedAt() %></p>
        </div>
        <%
                }
            } else {
                out.println("<p>Không có đánh giá nào.</p>");
            }
        %>
    </div>

    <%
        // Lấy userId từ session
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            out.println("<p>Không xác định được người dùng.</p>");
            return;
        }
    %>

    <!-- Quay lại danh sách bất động sản -->
    <a href="notify-for-post.jsp?userId=<%= userId %>" class="back-link">Quay lại danh sách bất động sản</a>

</div>

</body>
</html>
