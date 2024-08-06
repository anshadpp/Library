<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f1f3f6;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .forgot-password-container {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        text-align: left;
    }
    .forgot-password-container h1 {
        margin-bottom: 25px;
        font-size: 22px;
        color: #333;
        font-weight: 600;
    }
    .form-group {
        position: relative;
        margin-bottom: 20px;
    }
    .form-group label {
        position: absolute;
        top: -10px;
        left: 8px;
        background-color: white;
        padding: 0 5px;
        font-size: 12px;
        color: #2874f0;
        pointer-events: none;
    }
    .form-group input[type="text"],
    .form-group input[type="password"] {
        width: 100%;
        padding: 10px 10px 10px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
        transition: border-color 0.3s ease;
        outline: none;
    }
    .form-group input:focus,
    .form-group input:not(:placeholder-shown) {
        border-color: #2874f0;
    }
    .forgot-password-container input[type="submit"] {
        margin-top: 20px;
        padding: 12px 0;
        background-color: #2874f0;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        text-transform: uppercase;
        width: 100%;
        transition: background-color 0.3s ease;
    }
    .forgot-password-container input[type="submit"]:hover {
        background-color: #0b60d2;
    }
    .error-message {
        color: #d32f2f;
        margin-bottom: 15px;
        font-size: 14px;
    }
    .password-container {
        position: relative;
    }
    .password-strength {
        font-weight: bold;
        font-size: 14px;
        margin-top: 5px;
    }
    .strength-weak {
        color: red;
    }
    .strength-medium {
        color: orange;
    }
    .strength-strong {
        color: green;
    }
</style>
</head>
<body>
<div class="forgot-password-container">
    <h1>Forgot Password</h1>
    <form action="<%= request.getContextPath() %>/forgot-password" method="post">
        <div class="form-group">
            <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required />
            <label for="username">Username</label>
        </div>

        <% if (request.getAttribute("securityQuestion") != null) { %>
        <div class="form-group">
            <input type="text" id="securityAnswer" name="securityAnswer" placeholder="<%= request.getAttribute("securityQuestion") %>" required />
            <label for="securityAnswer">Security Answer</label>
        </div>
        <div class="form-group password-container">
            <input type="password" id="newPassword" name="newPassword" required oninput="checkPasswordStrength()" />
            <label for="newPassword">New Password</label>
            <div id="password-strength" class="password-strength"></div>
        </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>

        <input type="submit" value="Submit" />
    </form>
</div>

<script>
    // Check password strength
    function checkPasswordStrength() {
        const password = document.getElementById('newPassword').value;
        const strengthText = document.getElementById('password-strength');
        let strength = 'Weak';

        if (password.length >= 8) {
            if (/[a-z]/.test(password) && /[A-Z]/.test(password) && /\d/.test(password) && /[^a-zA-Z\d]/.test(password)) {
                strength = 'Strong';
            } else if (/[a-zA-Z]/.test(password) && /\d/.test(password) && /[^a-zA-Z\d]/.test(password)) {
                strength = 'Medium';
            }
        }

        if (strength === 'Weak') {
            strengthText.textContent = 'Password Strength: Weak';
            strengthText.className = 'password-strength strength-weak';
        } else if (strength === 'Medium') {
            strengthText.textContent = 'Password Strength: Medium';
            strengthText.className = 'password-strength strength-medium';
        } else if (strength === 'Strong') {
            strengthText.textContent = 'Password Strength: Strong';
            strengthText.className = 'password-strength strength-strong';
        }
    }
</script>

</body>
</html>
