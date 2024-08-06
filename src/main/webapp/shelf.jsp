<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sample.user.dashboard.util.Base64Util" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Shelf</title>
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
        .shelf-container {
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
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
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function openDetails(bookId, userId) {
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
    </script>
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
        <div class="drawer-toggle">
            <label class="drawer-toggle-label" onclick="toggleDrawer()">
                <i class="fa fa-bars"></i>
            </label>
        </div>
        <div class="drawer">
            <c:choose>
                <c:when test="${not empty id}">
                    <a href="profile?id=${id}" class="icon"><i class="fa fa-user"></i> Profile</a>
                    <a href="<%= request.getContextPath() %>/uploadBook?id=${id}" class="icon"><i class="fa fa-upload"></i> Upload</a>
                    <%-- <a href="<%= request.getContextPath() %>/logout" class="icon"><i class="fa fa-sign-out-alt"></i> Logout</a> --%>
                    <a href="wishlist?id=${id}" class="icon"><i class="fa fa-heart"></i> Wishlist</a>
                    <a href="shelf?id=${id}" class="icon"><i class="fas fa-book" style="margin-right: 5px;"></i> Shelf</a>
                    <button type="button" class="btn btn-outline-danger logout-btn">
						    <i class="fa fa-sign-out-alt"></i> Logout
					</button>
                    
                </c:when>
                <c:otherwise>
                    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="shelf-container">
        <h1>My Shelf</h1>
        <div class="grid-container">
            <c:if test="${not empty userBooks}">
                <c:forEach var="book" items="${userBooks}">
                    <div class="grid-item">
                        <img src="data:image/jpeg;base64,${Base64Util.encode(book.imageFile)}" alt="${book.bookName}" onclick="openDetails(${book.id}, '${id}')">
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
