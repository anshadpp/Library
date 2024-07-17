<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Library Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #2874f0;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px;
            transition: background-color 0.3s ease;
        }
        .navbar a:hover {
            background-color: #1e60d5;
        }
        .dashboard-container {
            padding: 20px;
            margin: 20px auto;
            max-width: 800px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
            color: #333;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .view-pdf-btn {
            padding: 10px 20px;
            background-color: #fb641b;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .view-pdf-btn:hover {
            background-color: #f35627;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div></div> <!-- Placeholder for left-aligned items -->
        <div>
            <a href="profile?username=${username}">Profile</a>
            <a href="<%= request.getContextPath() %>/login.jsp">Logout</a>
        </div>
    </div>
    <div class="dashboard-container">
        <h1>Library Dashboard</h1>
        <table>
            <thead>
                <tr>
                    <th>Name of Book</th>
                    <th>Author Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.book_name}</td>
                        <td>${book.author_name}</td>
                        <td>
                            <a class="view-pdf-btn" href="${book.pdf_file_path}" target="_blank">View PDF</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
