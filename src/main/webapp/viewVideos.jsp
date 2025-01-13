<%@ page import="Entity.Video" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Videos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .video-container {
            margin: 20px 0;
        }

        video {
            max-width: 100%;
            max-height: 400px;
        }

        .video-info {
            text-align: center;
            margin-top: 10px;
            font-size: 16px;
            color: #333;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Video List</h2>

    <%
        // Nhận danh sách video từ request
        List<Video> videos = (List<Video>) request.getAttribute("videos");
        if (videos != null && !videos.isEmpty()) {
            for (Video video : videos) {
    %>
    <div class="video-container">
        <!-- Hiển thị video -->
        <video controls>
            <source src="<%= request.getContextPath() + "/uploads/" + video.getVideoUrl() %>" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        <div class="video-info">
            <p>Property ID: <%= video.getPropertyId() %></p>
            <p>Video URL: <a href="<%= request.getContextPath()  + video.getVideoUrl() %>" target="_blank"><%= video.getVideoUrl() %></a></p>
        </div>
    </div>
    <%
        }
    } else {
    %>
    <p>No videos found.</p>
    <%
        }
    %>
</div>

</body>
</html>
