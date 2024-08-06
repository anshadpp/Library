<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sample.user.dashboard.util.Base64Util" %>

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
        .navbar, .footer {
            background-color: #2874f0;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }
        .navbar a, .footer a {
            color: white;
            text-decoration: none;
            padding: 10px;
            transition: background-color 0.3s ease;
        }
        .navbar a:hover, .footer a:hover {
            background-color: #1e60d5;
        }
        .navbar .search-container {
            display: flex;
            justify-content: center;
            flex-grow: 1;
        }
        .navbar .search-container form {
            display: flex;
            width: 50%;
        }
        .navbar .search-container input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ced0da;
            border-radius: 4px 0 0 4px;
            font-size: 14px;
        }
        .navbar .search-container input[type="submit"] {
            padding: 8px;
            border: none;
            background-color: #fb641b;
            color: white;
            cursor: pointer;
            border-radius: 0 4px 4px 0;
            font-size: 14px;
        }
        .navbar .search-container input[type="submit"]:hover {
            background-color: #f85a1a;
        }
        .navbar .icon {
            display: flex;
            align-items: center;
        }
        .navbar .icon i {
            font-size: 20px;
            margin-right: 5px;
        }
        .main-container {
            display: flex;
            justify-content: flex-end;
            margin: 20px;
        }
        .shelf-container {
            width: 25%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-right: 20px;
            padding: 20px;
        }
        .shelf-container h2 {
            text-align: center;
            color: #fb641b;
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 2px solid #fb641b;
            padding-bottom: 10px;
        }
        .shelf-container .grid-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }
        .shelf-container .grid-item {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
            width: calc(50% - 15px);
            box-sizing: border-box;
        }
        .shelf-container .grid-item img {
            max-width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .shelf-container .grid-item h3 {
            font-size: 16px;
            color: #333;
            margin: 10px 0;
        }
        .shelf-container .grid-item p {
            font-size: 12px;
            color: #777;
        }
        .dashboard-container {
            flex: 1;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: left;
            color: #2874f0;
            font-size: 32px;
            margin-bottom: 20px;
            border-bottom: 2px solid #2874f0;
            padding-bottom: 10px;
        }
        .filter-sort-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 8px;
        }
        .filter-container, .sort-container {
            display: flex;
            align-items: center;
        }
        .filter-container select, .sort-container select {
            padding: 10px;
            border: 1px solid #ced0da;
            border-radius: 4px;
            font-size: 14px;
            margin: 0 10px;
            cursor: pointer;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }
        .filter-container select:hover, .sort-container select:hover {
            border-color: #2874f0;
        }
        .filter-container label, .sort-container label {
            font-size: 16px;
            color: #333;
        }
        .grid-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .grid-item {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            width: calc(25% - 20px);
            box-sizing: border-box;
        }
        .grid-item img {
            max-width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .grid-item h3 {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }
        .grid-item p {
            font-size: 14px;
            color: #777;
        }
        .footer {
            margin-top: 20px;
        }
        /* Drawer styles */
		/* Drawer styles */
		.drawer {
		    position: fixed;
		    top: 0;
		    right: 0;
		    width: 250px;
		    height: 100%;
		    background-color: #2874f0;
		    color: white;
		    padding: 20px;
		    display: none; /* Hidden by default */
		    flex-direction: column;
		    align-items: flex-start;
		    box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
		    z-index: 1000;
		}
		
		.drawer a {
		    padding: 10px;
		    text-decoration: none;
		    color: white;
		    width: 100%;
		    text-align: left;
		    margin: 5px 0;
		}
		
		.drawer a:hover {
		    background-color: #1e60d5;
		}
		
		.drawer-toggle-label {
		    cursor: pointer;
		    display: flex;
		    align-items: center;
		}
		
		.drawer-toggle-label span {
		    font-size: 18px;
		    margin-left: 10px;
		}
		
		.drawer-toggle-label i {
		    font-size: 24px;
		}
		
		/* Ensure the drawer toggle is always visible */
		.drawer-toggle {
		    display: block;
		}
		/* Add these styles to your CSS file or <style> block */
		.chatbot {
		    position: fixed;
		    bottom: 20px;
		    right: 20px;
		    background-color: #2874f0;
		    color: white;
		    border-radius: 50%;
		    width: 60px;
		    height: 60px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    cursor: pointer;
		    font-size: 24px;
		    z-index: 1000;
		}
		
		.chat-window {
		    position: fixed;
		    bottom: 90px;
		    right: 20px;
		    background-color: white;
		    border-radius: 8px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
		    width: 300px;
		    display: none;
		    flex-direction: column;
		}
		
		.chat-header {
		    background-color: #2874f0;
		    color: white;
		    padding: 10px;
		    border-radius: 8px 8px 0 0;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.chat-header h3 {
		    margin: 0;
		    font-size: 16px;
		}
		
		.chat-body {
		    padding: 10px;
		    height: 200px;
		    overflow-y: auto;
		    display: flex;
		    flex-direction: column;
		    gap: 10px;
		}
		
		.chat-footer {
		    padding: 10px;
		    border-top: 1px solid #ddd;
		    display: flex;
		    gap: 5px;
		    flex-direction: column;
		}
		
		.chat-footer select {
		    padding: 8px;
		    border: 1px solid #ced0da;
		    border-radius: 4px;
		}
		
		.chat-footer button {
		    background-color: #2874f0;
		    color: white;
		    padding: 8px 12px;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.chat-footer button:hover {
		    background-color: #1e60d5;
		}
		
		.message.user {
		    align-self: flex-end;
		    background-color: #2874f0;
		    color: white;
		    padding: 8px 12px;
		    border-radius: 8px;
		    max-width: 80%;
		}
		
		.message.bot {
		    align-self: flex-start;
		    background-color: #f1f1f1;
		    color: #333;
		    padding: 8px 12px;
		    border-radius: 8px;
		    max-width: 80%;
		}
		
		.close-icon {
		    cursor: pointer;
		    font-size: 18px;
		}
		
		.loading {
		    color: #2874f0;
		    font-style: italic;
		}

    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function openDetails(bookId) {
            const userId = '${id}';
            if (userId) {
                window.location.href = 'details?bookId=' + bookId + '&userId=' + userId;
            } else {
                window.location.href = 'details?bookId=' + bookId;
            }
        }
        function handleSearch(event) {
            event.preventDefault();
            const query = document.getElementById('searchQuery').value;
            window.location.href = '<%= request.getContextPath() %>/search?query=' + query;
        }
        function handleFilterChange(event) {
            const category = event.target.value;
            window.location.href = '<%= request.getContextPath() %>/dashboard?category=' + category;
        }
        function handleSortChange(event) {
            const sort = event.target.value;
            window.location.href = '<%= request.getContextPath() %>/dashboard?sort=' + sort;
        }
        function toggleDrawer() {
            const drawer = document.querySelector('.drawer');
            drawer.style.display = drawer.style.display === 'flex' ? 'none' : 'flex';
        }

        document.addEventListener('click', function(event) {
            const drawer = document.querySelector('.drawer');
            const drawerToggle = document.querySelector('.drawer-toggle-label');

            if (!drawer.contains(event.target) && !drawerToggle.contains(event.target)) {
                drawer.style.display = 'none';
            }
        });
        function openPdf(bookId, userId) {
            if (!userId) {
                alert('User ID is missing. Please log in.');
                return;
            }

            fetch('<%= request.getContextPath() %>/LastReadPageServlet?userId=' + encodeURIComponent(userId) + '&bookId=' + encodeURIComponent(bookId))
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text();
                })
                .then(lastPage => {
                    // Redirect to the PDF viewer page with the bookId and lastPage as query parameters
                    window.location.href = '<%= request.getContextPath() %>/viewPdf.jsp?id=' + encodeURIComponent(bookId) + '&page=' + encodeURIComponent(lastPage) + '&userId=' + encodeURIComponent(userId);
                })
                .catch(error => {
                    console.error('Error fetching last read page:', error);
                    alert('An error occurred while fetching the last read page. Please try again.');
                });
        }
     // Add this script to your <script> block or external JS file
       document.addEventListener('DOMContentLoaded', () => {
    const chatbotBtn = document.getElementById('chatbot-btn'); // Updated to match new ID
    const chatWindow = document.getElementById('chat-window');
    const chatBody = document.getElementById('chat-body');
    const closeChatBtn = document.getElementById('close-chat');
    const sendBtn = document.getElementById('send-btn');
    const questionSelect = document.getElementById('question-select');

    chatbotBtn.addEventListener('click', () => {
        chatWindow.style.display = 'flex'; // Display the chat window
    });

    closeChatBtn.addEventListener('click', () => {
        chatWindow.style.display = 'none'; // Hide the chat window
    });

    sendBtn.addEventListener('click', sendMessage);

    function sendMessage() {
        const selectedQuestion = questionSelect.value;
        if (selectedQuestion === '') return;

        addMessage('user', selectedQuestion);
        questionSelect.value = '';

        fetch('/sample/BotServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'question=' + encodeURIComponent(selectedQuestion),
        })
        .then(response => response.text())
        .then(data => {
            addMessage('bot', data);
        })
        .catch(error => {
            console.error('Error:', error);
            addMessage('bot', 'Something went wrong. Please try again.');
        });
    }

    function addMessage(sender, message) {
        const messageElement = document.createElement('div');
        messageElement.classList.add('message', sender);
        messageElement.textContent = message;
        chatBody.appendChild(messageElement);
        chatBody.scrollTop = chatBody.scrollHeight;
    }
});


    </script>
    <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">

<!-- Bootstrap JavaScript Bundle with Popper -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $('.logout-btn').click(function() {
        $('#logoutModal').modal('show');
    });
});
</script>

    
</head>
<body>
    <div class="navbar">
        <div>
            <a href="/sample/dashboard"><i class="fas fa-home"></i> Home</a>
        </div>
        <div class="search-container">
            <form onsubmit="handleSearch(event)">
                <input type="text" id="searchQuery" name="query" placeholder="Search books..." required>
                <input type="submit" value="Search">
            </form>
        </div>
        <div class="drawer-toggle">
		    <c:choose>
		        <c:when test="${not empty id}">
		            <label class="drawer-toggle-label" onclick="toggleDrawer()">
		                <i class="fa fa-bars"></i>
		            </label>
		        </c:when>
		        <c:otherwise>
		            <a href="<%= request.getContextPath() %>/login.jsp">
		                <i class="fa fa-sign-in-alt"></i> Login
		            </a>
		        </c:otherwise>
		    </c:choose>
		</div>
        <div class="drawer">
            <c:choose>
                <c:when test="${not empty id}">
                    <a href="profile?id=${id}" class="icon"><i class="fa fa-user"></i> Profile</a>
                    <a href="<%= request.getContextPath() %>/uploadBook?id=${id}" class="icon"><i class="fa fa-upload"></i> Upload</a>
                    <%-- <a href="<%= request.getContextPath() %>/logout" class="icon logout-link"><i class="fa fa-sign-out-alt"></i> Logout</a> --%>
                    <a href="wishlist?id=${id}" class="icon"><i class="fa fa-heart"></i> Wishlist</a>
                    <a href="shelf?id=${id}" class="icon"><i class="fas fa-book" style="margin-right: 5px;"></i> Shelf</a>
                    <button type="button" class="btn btn-outline-danger logout-btn">
						    <i class="fa fa-sign-out-alt"></i> Logout
					</button>
                    
                </c:when>
                
            </c:choose>
        </div>
    </div>
    <div class="main-container">
        <div class="shelf-container">
            <!-- Shelf items from My Shelf page -->
            <h2>Your Shelf</h2>
            <div class="grid-container">
                <c:if test="${not empty userBooks}">
                    <c:forEach var="book" items="${userBooks}">
                        <div class="grid-item">
                            <img src="data:image/jpeg;base64,${Base64Util.encode(book.imageFile)}" alt="${book.bookName}" onclick="openPdf(${book.id}, '${id}')">
                            <h3>${book.bookName}</h3>
                            <p>by ${book.authorName}</p>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty userBooks}">
                    <p>No books in your shelf.</p>
                </c:if>
            </div>
        </div>
        <div class="dashboard-container">
            <h1>Library Dashboard</h1>
            <div class="filter-sort-container">
                <div class="filter-container">
                    <label for="categoryFilter">Filter by Category:</label>
                    <select id="categoryFilter" onchange="handleFilterChange(event)">
                        <option value="">Select a category</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category}">${category}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="sort-container">
                    <label for="sort">Sort by:</label>
                    <select id="sort" onchange="handleSortChange(event)">
                        <option value="">Select an option</option>
                        <option value="title_asc">Title (A-Z)</option>
                        <option value="title_desc">Title (Z-A)</option>
                        <option value="author_asc">Author (A-Z)</option>
                        <option value="author_desc">Author (Z-A)</option>
                    </select>
                </div>
            </div>
            <div class="grid-container">
                <c:forEach var="book" items="${books}">
                    <div class="grid-item">
                        <img src="data:image/jpeg;base64,${Base64Util.encode(book.imageFile)}" alt="${book.bookName}" onclick="openDetails(${book.id})">
                        <h3>${book.bookName}</h3>
                        <p>by ${book.authorName}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    

    <!-- Chatbot Window -->
    <div class="chatbot" id="chatbot-btn">
    <i class="fa fa-comments"></i>
</div>

<!-- Chatbot Window -->
<div class="chat-window" id="chat-window">
    <div class="chat-header">
        <h3>Library Bot</h3>
        <span class="close-icon" id="close-chat">&times;</span>
    </div>
    <div class="chat-body" id="chat-body"></div>
    <div class="chat-footer">
        <select id="question-select">
            <option value="" disabled selected>Select a question...</option>
            <option value="How to view Previous uploads?">How to view Previous uploads?</option>
            <option value="How to buy a book?">How to buy a book?</option>
            <option value="How to upload a book?">How to upload a book?</option>
            <option value="How to contact support?">How to contact support?</option>
        </select>
        <button id="send-btn">Send</button>
    </div>
</div>

    
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Do you really want to logout?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
</div>
    
    <div class="footer">
        <div>
            <p>&copy; 2024 Your Library. All rights reserved.</p>
        </div>
        <div>
            <a href="contact.jsp">Contact Us</a>
            <a href="about.jsp">About</a>
        </div>
    </div>
</body>
</html>
