<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Form</title>
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
    .login-container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 300px;
        text-align: center;
    }
    .login-container h1 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #333333;
    }
    .login-container table {
        width: 100%;
    }
    .login-container td {
        padding: 10px;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: calc(100% - 20px);
        padding: 8px;
        border: 1px solid #cccccc;
        border-radius: 4px;
    }
    .login-container input[type="submit"] {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }
    .login-container input[type="submit"]:hover {
        background-color: #45a049;
    }
    .login-container .register-link {
        margin-top: 20px;
        display: block;
        color: #4CAF50;
        text-decoration: none;
    }
    .login-container .register-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
 <div class="login-container">
  <h1>Welcome</h1>
  <form action="<%=request.getContextPath()%>/login" method="post">
   <table>
    <tr>
     <td><label for="username">UserName</label></td>
     <td><input type="text" id="username" name="username" /></td>
    </tr>
    <tr>
     <td><label for="password">Password</label></td>
     <td><input type="password" id="password" name="password" /></td>
    </tr>
   </table>
   <input type="submit" value="Submit" />
   <a class="register-link" href="<%=request.getContextPath()%>/register">Don't have an account? Create one</a>
  </form>
 </div>
</body>
</html>

