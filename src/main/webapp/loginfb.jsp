<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập bằng Facebook</title>
</head>
<body>

<!-- Nút đăng nhập bằng Facebook -->
<div id="fb-root"></div>
<button onclick="checkLoginState();">Đăng nhập bằng Facebook</button>

<script>
    // Khởi tạo SDK của Facebook
    window.fbAsyncInit = function () {
        FB.init({
            appId: '1773989986680875', // Thay thế bằng ID ứng dụng của bạn
            cookie: true,
            xfbml: true,
            version: 'v15.0'
        });
        FB.AppEvents.logPageView();
    };

    // Tải SDK của Facebook không đồng bộ
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {
            return;
        }
        js = d.createElement(s);
        js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    // Hàm kiểm tra trạng thái đăng nhập của người dùng
    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

    // Hàm xử lý sau khi trạng thái đăng nhập thay đổi
    function statusChangeCallback(response) {
        if (response.status === 'connected') {
            fetchUserData();
        } else {
            FB.login(function (response) {
                if (response.authResponse) {
                    fetchUserData();
                }
            }, {scope: 'public_profile,email'});
        }
    }

    // Hàm lấy dữ liệu người dùng từ Facebook
    function fetchUserData() {
        FB.api('/me', {fields: 'id,name,email'}, function (response) {
            console.log('Thông tin người dùng:', response);

            // Gửi thông tin người dùng đến server để xử lý đăng nhập
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/YourLoginServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send(`facebookId=${response.id}&name=${response.name}&email=${response.email}`);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Chuyển hướng đến trang welcome.jsp
                    window.location.href = "/welcome";
                }
            };
        });
    }
</script>

</body>
</html>
