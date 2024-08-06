<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sample.user.dashboard.util.Base64Util" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Wishlist</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
        .wishlist-container {
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
            position: relative;
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
        .remove-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            cursor: pointer;
            text-align: center;
            line-height: 30px;
            font-size: 16px;
        }
        .remove-btn:hover {
            background-color: #d32f2f;
        }
        .footer {
            margin-top: 20px;
        }
        /* Custom Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            border-radius: 8px;
            text-align: center;
        }
        .modal-header, .modal-footer {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .modal-footer {
            border-bottom: none;
            display: flex;
            justify-content: space-between;
            border-top: 1px solid #ddd;
        }
        .modal-footer button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
        }
        .modal-footer .cancel-btn {
            background-color: #ccc;
        }
        .modal-footer .cancel-btn:hover {
            background-color: #bbb;
        }
        .modal-footer .confirm-btn {
            background-color: #f44336;
            color: white;
        }
        .modal-footer .confirm-btn:hover {
            background-color: #d32f2f;
        }
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
    <div class="wishlist-container">
        <h1>Your Wishlist</h1>
        <div class="grid-container">
            <c:if test="${not empty wishlistBooks}">
                <c:forEach var="book" items="${wishlistBooks}">
                    <div class="grid-item">
                        <img src="data:image/jpeg;base64,${Base64Util.encode(book.imageFile)}" alt="${book.bookName}" onclick="openDetails('${book.id}')">
                        <h3>${book.bookName}</h3>
                        <p>by ${book.authorName}</p>
                        <button class="remove-btn" onclick="showModal('${book.id}', '${userId}')">&times;</button>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty wishlistBooks}">
                <p>No books in wishlist.</p>
            </c:if>
        </div>
    </div>
    <div id="modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Confirm Removal</h2>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to remove this book from your wishlist?</p>
            </div>
            <div class="modal-footer">
                <button class="cancel-btn" onclick="closeModal()">Cancel</button>
                <button id="confirmRemove" class="confirm-btn">Remove</button>
            </div>
        </div>
    </div>
    <!-- Bootstrap JavaScript Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        // Function to toggle the drawer
        function toggleDrawer() {
            const drawer = document.querySelector('.drawer');
            drawer.style.display = drawer.style.display === 'flex' ? 'none' : 'flex';
        }

        // Function to close the modal
        function closeModal() {
            document.getElementById('modal').style.display = 'none';
        }

        // Function to show modal and handle removal action
        function showModal(bookId, userId) {
            document.getElementById('modal').style.display = 'flex';
            document.getElementById('confirmRemove').onclick = function() {
                removeFromWishlist(bookId, userId);
            };
        }

        // Function to remove book from wishlist
        function removeFromWishlist(bookId, userId) {
            window.location.href = 'deleteFromWishlist?bookId=' + bookId + '&userId=' + userId;
        }

        // Logout button modal trigger using jQuery
        $(document).ready(function() {
            $('.logout-btn').click(function() {
                $('#logoutModal').modal('show');
            });
        });
    </script>
    <!-- Logout Modal -->
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
