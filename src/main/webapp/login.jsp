<!DOCTYPE html>
<html lang="vi">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Google Sign-In Meta -->
    <meta name="google-signin-client_id"
          content="161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com">

    <style>
        .login-form-container {
            max-width: 500px;
            margin: auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: gainsboro;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            width: 60%;
            margin: auto;
        }

        .login-form h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-form label {
            margin-bottom: 5px;
        }

        .login-form input {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            width: 95%;
        }

        .btn {
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #ccc;
            width: 100%;
        }

        .submit-btn {
            border-radius: 5px;
            height: 40px;
            width: 100%;
            background-color: red;
            color: white;
            border: none;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .submit-btn:hover {
            background-color: darkred;
        }

        .btn-facebook {
            background-color: white;
            color: black;
            margin: 5px 0;
        }

        .btn-facebook i {
            margin-right: 8px;
            color: #3b5998;
        }

        .social-login {
            text-align: center;
            margin: 20px 0;
        }

        .link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="login-form-container">
    <div class="login-form" style="width: 70%">
        <h2>Đăng nhập để tiếp tục</h2>
        <form action="login" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="submit-btn">Đăng nhập</button>
        </form>

        <!-- Error message display -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p class="error-message" style="color: red;"><%= errorMessage %>
        </p>
        <%
            }
        %>

        <div class="social-login">
            <p>Hoặc đăng nhập bằng:</p>
            <button class="btn btn-facebook" onclick="checkLoginState()">
                <i class="fab fa-facebook-f" style="margin-right: 45px"></i> Đăng nhập bằng Facebook
            </button>
            <div id="g_id_onload"
                 data-client_id="161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com"
                 data-login_uri="http://localhost:8080/Batdongsan/loginWithGoogle">
            </div>
            <div class="g_id_signin" data-type="standard"></div>
        </div>

        <div class="link">
            <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a> | <a href="forgot-password.jsp">Quên mật
                khẩu?</a></p>
        </div>
    </div>
</div>

<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://connect.facebook.net/en_US/sdk.js"></script>
<script>
    window.fbAsyncInit = function () {
        FB.init({
            appId: '1773989986680875',
            cookie: true,
            xfbml: true,
            version: 'v15.0'
        });
    };

    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

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

    function fetchUserData() {
        FB.api('/me', {fields: 'id,name,email'}, function (response) {
            // Lấy thông tin từ response, bao gồm tên người dùng
            const username = response.name;

            // Gửi tên người dùng qua một request POST
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/LoginServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send(`facebookId=${response.id}&name=${response.name}&email=${response.email}`);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    window.location.href = "welcome"; // Chuyển hướng sau khi đăng nhập thành công
                }
            };
        });
    }
</script>


<script>
    // Google Sign-In setup
    google.accounts.id.initialize({
        client_id: "161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com",
        callback: handleCredentialResponse
    });

    // Handle the response from Google
    function handleCredentialResponse(response) {
        fetch('/loginWithGoogle', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: `credential=${response.credential}`
        })
            .then(res => res.text())
            .then(data => {
                console.log('Login successful', data);
                window.location.href = "welcome"; // Redirect after successful login
            })
            .catch(error => console.error("Error:", error));
    }

    // Render the Google Sign-In button
    google.accounts.id.renderButton(
        document.getElementById("g_id_onload"),
        { theme: "outline", size: "large" }
    );

    google.accounts.id.prompt();
</script>


</body>
</html>
