<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f1f3f6;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .login-container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 360px;
        text-align: center;
    }
    .login-container h1 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #2874f0;
    }
    .login-container .input-container {
        position: relative;
        margin-bottom: 20px;
    }
    .login-container label {
        position: absolute;
        top: 50%;
        left: 10px;
        transform: translateY(-50%);
        background-color: #ffffff;
        padding: 0 5px;
        color: #999;
        transition: 0.3s;
    }
    .login-container input[type="text"]:focus + label,
    .login-container input[type="password"]:focus + label,
    .login-container input[type="text"]:valid + label,
    .login-container input[type="password"]:valid + label {
        top: -10px;
        left: 10px;
        font-size: 12px;
        color: #2874f0;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: calc(100% - 20px);
        padding: 10px;
        border: 1px solid #ced0da;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
    }
    .login-container input[type="submit"] {
        margin-top: 20px;
        padding: 12px;
        background-color: #2874f0;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        width: 100%;
        box-sizing: border-box;
        transition: background-color 0.3s ease;
    }
    .login-container input[type="submit"]:hover {
        background-color: #f85a1a;
    }
    .login-container .register-link {
        margin-top: 20px;
        display: block;
        color: #2874f0;
        text-decoration: none;
        font-size: 14px;
    }
    .login-container .register-link:hover {
        text-decoration: underline;
    }
    .alert {
        color: red;
        margin-bottom: 10px;
        font-size: 14px;
    }
    .forgot-password-container {
        text-align: center;
        margin-top: 20px;
    }
    .forgot-password-container a {
        color: #2874f0;
        font-size: 14px;
        text-decoration: none;
    }
    .forgot-password-container a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="<%=request.getContextPath()%>/login" method="post">
            <c:if test="${not empty errorMessage}">
                <div class="alert">${errorMessage}</div>
            </c:if>
            <div class="input-container">
                <input type="text" id="username" name="username" required />
                <label for="username">Username/Email/Phone</label>
            </div>
            <div class="input-container">
                <input type="password" id="password" name="password" required />
                <label for="password">Password</label>
            </div>
            <input type="submit" value="Submit" />
            <div class="forgot-password-container">
                <a href="<%=request.getContextPath()%>/forgot-password">Forgot Password?</a>
            </div>
            <div class="forgot-password-container">
                <a href="<%=request.getContextPath()%>/register">Don't have an account? Create one</a>
            </div>
        </form>
    </div>
</body>
</html>
