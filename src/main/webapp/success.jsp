<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
<h2>Welcome, ${sessionScope.username}!</h2>
<form action="logout" method="post">
    <input type="submit" value="Logout">
</form>
</body>
</html>
