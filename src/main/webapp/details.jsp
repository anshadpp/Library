<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Details</title>
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
        .book-details-container {
            display: flex;
            padding: 20px;
            margin: 20px auto;
            max-width: 1000px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .book-image {
            position: relative;
            flex: 1;
            text-align: center;
        }
        .book-image img {
            max-width: 100%;
            border-radius: 8px;
            cursor: zoom-in;
        }
        .zoom-result {
            display: none;
            position: absolute;
            right: -400px;
            top: 0;
            width: 400px;
            height: 400px;
            border: 1px solid #ddd;
            background-color: #fff;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .zoom-result img {
            position: absolute;
            max-width: none;
        }
        .book-details {
            flex: 2;
            padding-left: 20px;
        }
        .book-details h1, .book-details h2, .book-details p {
            margin: 10px 0;
        }
        .category-badge {
            display: inline-block;
            background-color: #ff9800;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .price {
            font-size: 24px;
            color: #28a745;
            margin: 10px 0;
            font-weight: bold;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .action-button {
            background-color: #2874f0;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .action-button:hover {
            background-color: #1e60d5;
        }
        .footer {
            margin-top: 20px;
        }
        /* Custom Popup Styles */
        .popup-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .popup {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 80%;
        }
        .popup h3 {
            margin-bottom: 20px;
        }
        .popup-buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .popup-button {
            flex: 1;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .popup-button.confirm {
            background-color: #28a745;
            color: white;
        }
        .popup-button.cancel {
            background-color: #2874f0;
            color: white;
        }
        .popup-button:hover {
            opacity: 0.9;
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

        /* Star Rating Styles */
        
    </style>
    <script>
        function addToWishlist(bookId) {
            const userId = '${id}';
            if (!userId) {
                window.location.href = '<%= request.getContextPath() %>/login.jsp';
            } else {
                window.location.href = 'addToWishlist?bookId=' + bookId + '&userId=' + userId;
            }
        }

        function buyBook(bookId) {
            const userId = '${id}';
            if (!userId) {
                window.location.href = '<%= request.getContextPath() %>/login.jsp';
            } else {
                document.getElementById('popup-background').style.display = 'flex';
                document.getElementById('confirm-buy').onclick = function() {
                    window.location.href = 'buyBook?bookId=' + bookId + '&userId=' + userId;
                };
            }
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

        function closePopup() {
            document.getElementById('popup-background').style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function() {
            var mainImage = document.querySelector('.book-image img');
            var zoomResult = document.querySelector('.zoom-result');
            var zoomResultImg = zoomResult.querySelector('img');
            
            mainImage.addEventListener('mouseenter', function() {
                zoomResult.style.display = 'block';
                zoomResultImg.src = this.src;
            });
            
            mainImage.addEventListener('mousemove', function(event) {
                var bounds = this.getBoundingClientRect();
                var x = event.pageX - bounds.left - window.scrollX;
                var y = event.pageY - bounds.top - window.scrollY;
                var zoomX = x * (zoomResultImg.naturalWidth / bounds.width);
                var zoomY = y * (zoomResultImg.naturalHeight / bounds.height);
                zoomResultImg.style.left = -zoomX + zoomResult.offsetWidth / 2 + 'px';
                zoomResultImg.style.top = -zoomY + zoomResult.offsetHeight / 2 + 'px';
            });

            mainImage.addEventListener('mouseleave', function() {
                zoomResult.style.display = 'none';
            });
        });

    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                    <a href="wishlist?id=${id}" class="icon"><i class="fa fa-heart"></i> Wishlist</a>
                    <a href="shelf?id=${id}" class="icon"><i class="fas fa-book" style="margin-right: 5px;"></i> Shelf</a>
                    <button type="button" class="btn btn-outline-danger logout-btn">
                        <i class="fa fa-sign-out-alt"></i> Logout
                    </button>
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="book-details-container">
        <div class="book-image">
            <img src="data:image/jpeg;base64,${book.imageFileAsBase64}" alt="Book Image">
            <div class="zoom-result">
                <img src="data:image/jpeg;base64,${book.imageFileAsBase64}" alt="Zoomed Book Image">
            </div>
        </div>
        <div class="book-details">
            <h1>${book.bookName}</h1>
            <h2>by ${book.authorName}</h2>
            <div class="category-badge">${book.category}</div>
            <p>${book.description}</p>
            <div class="price">$${book.price}</div>
            <div class="action-buttons">
                <button class="action-button" onclick="addToWishlist(${book.id})">Add to Wishlist</button>
                <button class="action-button" onclick="buyBook(${book.id})">Buy</button>
            </div>
            <!-- Star Rating Section -->
            <!-- Display overall rating -->
             <%-- <div class="star-rating">
                <h3>Overall Rating: </h3>
                <!-- Rating form -->
                <form action="rateBook" method="post" class="rating-form">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="userId" value="${id}">
                    <input type="hidden" name="rating" id="rating" value="0">
                    <div class="stars-container">
                        <span class="stars" data-rating="1">&#9733;</span>
                        <span class="stars" data-rating="2">&#9733;</span>
                        <span class="stars" data-rating="3">&#9733;</span>
                        <span class="stars" data-rating="4">&#9733;</span>
                        <span class="stars" data-rating="5">&#9733;</span>
                    </div>
                    <button class="action-button" type="submit">Rate this book</button>
                </form>
            </div>  --%>
        </div>
    </div>
    <!-- Custom Buy Confirmation Popup -->
    <div id="popup-background" class="popup-background">
        <div class="popup">
            <h3>Are you sure you want to buy this book?</h3>
            <div class="popup-buttons">
                <button id="confirm-buy" class="popup-button confirm">Buy</button>
                <button class="popup-button cancel" onclick="closePopup()">Cancel</button>
            </div>
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
