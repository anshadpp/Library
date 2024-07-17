<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .register-container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        text-align: center;
    }
    .register-container h1 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #333333;
    }
    .register-container table {
        width: 100%;
    }
    .register-container td {
        padding: 10px;
    }
    .register-container input[type="text"],
    .register-container input[type="password"],
    .register-container input[type="email"],
    .register-container input[type="tel"] {
        width: calc(100% - 20px);
        padding: 8px;
        border: 1px solid #cccccc;
        border-radius: 4px;
    }
    .register-container input[type="submit"] {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }
    .register-container input[type="submit"]:hover {
        background-color: #45a049;
    }
    .error-message {
        color: red;
        margin-bottom: 10px;
    }
    .login-link {
        margin-top: 10px;
        font-size: 14px;
    }
</style>
</head>
<body>
<div class="register-container">
    <h1>User Registration Form</h1>
    <form action="<%= request.getContextPath() %>/register" method="post">
        <table>
            <tr>
                <td><label for="name">Name</label></td>
                <td><input type="text" id="name" name="name" required /></td>
            </tr>
            <tr>
                <td><label for="username">Username</label></td>
                <td><input type="text" id="username" name="username" required /></td>
            </tr>
            <tr>
                <td><label for="email">Email</label></td>
                <td><input type="email" id="email" name="email" required /></td>
            </tr>
            <tr>
                <td><label for="phone">Phone</label></td>
                <td><input type="tel" id="phone" name="phone" required /></td>
            </tr>
            <tr>
                <td><label for="password">Password</label></td>
                <td><input type="password" id="password" name="password" required /></td>
            </tr>
        </table>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
        <input type="submit" value="Submit" />
    </form>
    <div class="login-link">
        Already have an account? <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    </div>
</div>
</body>
</html>
