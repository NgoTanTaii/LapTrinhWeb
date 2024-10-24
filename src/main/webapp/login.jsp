<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="160944412642-19q2brhebfkldu328eu3kji6il30vk0k.apps.googleusercontent.com">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .login-form-container {
            max-width: 500px;
            margin: auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .login-form {
            display: flex;
            flex-direction: column;

        }

        .login-form h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-form label {
            margin-bottom: 5px;
        }

        .login-form input {
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 280px;
        }

        .btn {
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .submit-btn {
            background-color: red; /* Màu đỏ */
            color: white; /* Chữ trắng */
            border: none; /* Không viền */
        }

        .submit-btn:hover {
            background-color: darkred; /* Màu đỏ đậm khi hover */
        }

        .btn-facebook, .btn-google {
            background-color: white; /* Nền trắng */
            color: black; /* Chữ đen */
            border: 1px solid #ccc; /* Viền nhẹ */
            margin: 5px 0; /* Khoảng cách giữa các nút */
            display: flex; /* Sử dụng flexbox để căn chỉnh nội dung */
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: center; /* Căn giữa theo chiều ngang */
        }

        .btn-facebook i, .btn-google i {
            margin-right: 8px; /* Khoảng cách giữa biểu tượng và chữ */
        }

        .btn-facebook i {
            color: #3b5998; /* Màu xanh cho Facebook */
        }

        .btn-google i {
            color: #db4437; /* Màu đỏ cho Google */
        }

        .social-login {
            text-align: center;
            margin: 20px 0;
        }

        .error-message {
            color: red;
            text-align: center;
        }

        .link {
            text-align: center;
            margin-top: 20px;
        }
    </style>

</head>
<body>

<div class="login-form-container">
    <div class="login-form">
        <h2>Đăng nhập để tiếp tục</h2>
        <form action="login" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username"
                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                   required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="btn submit-btn">Đăng nhập</button>
        </form>

        <!-- Thông báo lỗi nếu có -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p class="error-message"><%= errorMessage %>
        </p>
        <%
            }
        %>

        <div class="social-login">
            <p>Hoặc đăng nhập bằng:</p>
            <button class="btn btn-facebook">
                <i class="fab fa-facebook-f"></i> Facebook
            </button>
            <button class="btn btn-google" id="googleSignInBtn" onclick="onSignIn()">
                <i class="fab fa-google"></i> Google
            </button>
        </div>

        <div class="link">
            <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a> | <a href="forgot-password.jsp">Quên mật
                khẩu?</a></p>
        </div>
    </div>
</div>
<script>
    function onSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        var id_token = googleUser.getAuthResponse().id_token;

        // Send the ID token to your server for verification
        fetch('loginWithGoogle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ id_token: id_token })
        }).then(response => {
            return response.json();
        }).then(data => {
            if (data.success) {
                // Redirect on successful login
                window.location.href = 'dashboard.jsp'; // Change to your dashboard URL
            } else {
                // Handle errors (display an error message)
                document.querySelector('.error-message').innerText = data.message;
            }
        });
    }
</script>

</body>
</html>
