<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .profile-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
            overflow: hidden;
        }
        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .profile-info {
            margin-top: 30px;
            text-align: left;
        }
        .profile-info p {
            margin-bottom: 15px;
            font-size: 18px;
        }
        .profile-info label {
            font-weight: bold;
            margin-right: 10px;
        }
        .change-password {
            margin-top: 40px;
            text-align: left;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        .change-password h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 15px;
        }
        .change-password form {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
        }
        .change-password input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .change-password input[type="submit"] {
            padding: 12px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .change-password input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2>User Profile</h2>
        <div class="profile-info">
            <c:if test="${not empty user}">
                <p><label>Username:</label> ${user.username}</p>
                <p><label>Name:</label> ${user.name}</p>
                <p><label>Email:</label> ${user.email}</p>
                <p><label>Phone:</label> ${user.phone}</p>
            </c:if>
            <c:if test="${empty user}">
                <p>User not found.</p>
            </c:if>
        </div>

    </div>
</body>
</html>
