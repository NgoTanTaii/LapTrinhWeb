<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
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

        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }

        #videoPreview {
            margin-top: 20px;
        }

        #videoPreview video {
            max-width: 100%;
            max-height: 300px;
            display: none;
        }

        #videoDurationMessage {
            color: red;
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Upload Video</h2>
    <form action="uploadVideo" method="post" enctype="multipart/form-data">
        <!-- Nhập ID sản phẩm (propertyId sẽ được lấy từ URL và điền vào đây) -->
        <label for="productId" class="hidden"></label>
        <input type="text" hidden="hidden" id="productId" name="productId" required><br><br>

        <!-- Chọn video -->
        <label for="videoFile">Chọn video (dưới 30s) :</label>
        <input type="file" id="videoFile" name="videoFile" accept="video/*" required onchange="previewVideo(event)"><br><br>

        <!-- Nút upload -->
        <button type="submit">Đăng Video</button>
    </form>

    <!-- Video Preview Section -->
    <div id="videoPreview">
        <video id="video" controls style="display: none;"></video>
        <p id="videoDurationMessage">Video duration must be less than 60 seconds.</p>
    </div>
</div>

<script>
    // Hàm lấy tham số từ URL
    function getUrlParameter(name) {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Lấy 'property_id' từ URL và điền vào form
    document.getElementById('productId').value = getUrlParameter('property_id');

    // Hàm xem trước video trước khi upload
    function previewVideo(event) {
        var file = event.target.files[0];  // Get the selected video file
        var videoElement = document.getElementById('video');
        var videoDurationMessage = document.getElementById('videoDurationMessage');
        var reader = new FileReader();

        // Hide error message if video duration is valid
        videoDurationMessage.style.display = 'none';

        reader.onload = function (e) {
            videoElement.style.display = 'block';  // Show the video element
            videoElement.src = e.target.result;    // Set video source to the selected file

            videoElement.onloadedmetadata = function () {
                // Check the video duration
                var duration = videoElement.duration;  // Video duration in seconds
                if (duration > 60) {
                    videoDurationMessage.style.display = 'block';  // Show error message
                    videoElement.style.display = 'none';  // Hide the video preview
                    event.target.value = '';  // Clear file input
                }
            };
        };

        reader.readAsDataURL(file);  // Read the file as Data URL
    }
</script>

</body>
</html>
