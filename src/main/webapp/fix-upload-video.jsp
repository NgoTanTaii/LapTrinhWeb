<%@ page import="Dao.VideoDAO" %>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Lấy propertyId từ tham số yêu cầu (URL)
    String propertyId = request.getParameter("property_id");

    // Kiểm tra nếu propertyId không tồn tại
    if (propertyId == null || propertyId.trim().isEmpty()) {
        out.println("<p>Không tìm thấy ID bất động sản.</p>");
        return;
    }

    // Khởi tạo VideoDAO và lấy videoUrl dựa trên propertyId
    VideoDAO videoDAO = new VideoDAO();
    String videoUrl = videoDAO.getVideoUrlByPropertyId(propertyId);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Video</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        form label {
            margin-top: 10px;
            font-weight: bold;
        }

        form input[type="file"] {
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
        }

        form button:hover {
            background-color: #45a049;
        }

        #videoPreview, #existingVideoContainer {
            margin-top: 20px;
        }

        #videoPreview video, #existingVideoContainer video {
            max-width: 100%;
            max-height: 240px; /* Kích thước nhỏ hơn cho video */
            display: none;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        #videoDurationMessage {
            color: red;
            display: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 90%;
            }
        }

        /* Styles cho các nút hành động */
        .action-buttons {
            margin-top: 20px;
            text-align: center;
        }

        .action-buttons form, .action-buttons a.btn {
            display: inline-block;
            margin: 5px;
        }

        .action-buttons button, .action-buttons a.btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
        }

        .action-buttons button:hover, .action-buttons a.btn:hover {
            background-color: #45a049;
        }

        .share-button.facebook {
            background-color: #3b5998;
        }

        .share-button.zalo {
            background-color: #0078FF;
        }

        .view-button {
            background-color: #FF4500;
        }

        .share-button.facebook:hover {
            background-color: #2d4373;
        }

        .share-button.zalo:hover {
            background-color: #005bb5;
        }

        .view-button:hover {
            background-color: #e03e00;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Upload Video</h2>
    <form action="uploadVideo" method="post" enctype="multipart/form-data">
        <!-- Nhập ID sản phẩm (propertyId sẽ được lấy từ URL và điền vào đây) -->
        <input type="hidden" id="productId" name="productId" value="<%= propertyId %>" required>

        <!-- Chọn video -->
        <label for="videoFile">Chọn video (dưới 30s) :</label>
        <input type="file" id="videoFile" name="videoFile" accept="video/*" required onchange="previewVideo(event)">

        <!-- Nút upload -->
        <button type="submit">Đăng Video</button>
    </form>

    <!-- Video Preview Section (Video mới được chọn) -->
    <div id="videoPreview">
        <h3>Xem trước Video mới:</h3>
        <video id="newVideo" controls></video>
        <p id="videoDurationMessage">Video duration must be less than 60 seconds.</p>
    </div>

    <!-- Existing Video Section (Video đã tải lên trước đó) -->
    <div id="existingVideoContainer">
        <% if (videoUrl != null && !videoUrl.isEmpty()) { %>
        <h3>Video Bất Động Sản Hiện Có:</h3>
        <video id="existingVideo" controls>
            <source src="<%= request.getContextPath() + "/" + videoUrl %>" type="video/mp4">
            Trình duyệt của bạn không hỗ trợ thẻ video.
        </video>
        <div class="action-buttons">
            <!-- Nút Xem Video BĐS -->
            <form action="<%= request.getContextPath() + "/" + videoUrl %>" method="get" target="_blank">
                <button type="submit" class="view-button">
                    Xem Video về BĐS
                </button>
            </form>
        </div>
        <% } else { %>
        <p>Chưa có video cho bất động sản này.</p>
        <% } %>
    </div>

</div>

<script>
    // Hàm xem trước video trước khi upload
    function previewVideo(event) {
        var file = event.target.files[0]; // Lấy file video được chọn
        var videoElement = document.getElementById('newVideo');
        var videoDurationMessage = document.getElementById('videoDurationMessage');

        // Ẩn thông báo lỗi trước
        videoDurationMessage.style.display = 'none';

        if (file) {
            var reader = new FileReader();

            reader.onload = function (e) {
                videoElement.style.display = 'block'; // Hiển thị phần tử video
                videoElement.src = e.target.result; // Đặt nguồn video là file được chọn

                videoElement.onloadedmetadata = function () {
                    var duration = videoElement.duration; // Thời lượng video tính bằng giây
                    if (duration > 60) {
                        videoDurationMessage.style.display = 'block'; // Hiển thị thông báo lỗi
                        videoElement.style.display = 'none'; // Ẩn video preview
                        event.target.value = ''; // Xóa input file
                        alert("Video của bạn dài hơn 60 giây. Vui lòng chọn lại video.");
                    }
                };
            };

            reader.readAsDataURL(file); // Đọc file dưới dạng Data URL
        }
    }

    // Hàm lấy tham số từ URL (nếu cần)
    function getUrlParameter(name) {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }
</script>

</body>
</html>
