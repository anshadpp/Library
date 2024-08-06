<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book Details</title>
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
        .form-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group input[type="file"] {
            padding: 0;
        }
        .form-group button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2874f0;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-group button:hover {
            background-color: #1e60d5;
        }
        .cancel-button {
            background-color: #f44336;
        }
        .cancel-button:hover {
            background-color: #d32f2f;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }
        .message.success {
            background-color: #4caf50;
            color: white;
        }
        .message.error {
            background-color: #f44336;
            color: white;
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function cancelEdit(bookId) {
            window.location.href = "/sample/detail?bookId=" + bookId;
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

        function showMessage(message, type) {
            var messageBox = document.createElement('div');
            messageBox.className = 'message ' + (type === 'success' ? 'success' : 'error');
            messageBox.innerText = message;
            document.body.insertBefore(messageBox, document.querySelector('.form-container'));
            setTimeout(function() {
                messageBox.remove();
            }, 5000);
        }

        window.onload = function() {
            var message = "${requestScope.updateMessage}";
            if (message) {
                var messageType = "${requestScope.updateMessageType}";
                showMessage(message, messageType);
            }

            var categorySelect = document.getElementById('category');
            var newCategoryInput = document.getElementById('newCategoryInput');
            categorySelect.addEventListener('change', function() {
                if (categorySelect.value === 'other') {
                    newCategoryInput.style.display = 'block';
                } else {
                    newCategoryInput.style.display = 'none';
                }
            });
        };
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
                   <%--  <a href="<%= request.getContextPath() %>/logout" class="icon"><i class="fa fa-sign-out-alt"></i> Logout</a> --%>
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

    <div class="form-container">
        <h2>Edit Book Details</h2>
        <form action="${pageContext.request.contextPath}/update/update" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${book.id}">
            <input type="hidden" name="userId" value="${book.userId}">

            <div class="form-group">
                <label for="book_name">Book Name:</label>
                <input type="text" id="book_name" name="book_name" value="${book.bookName}" required>
            </div>
            <div class="form-group">
                <label for="author_name">Author Name:</label>
                <input type="text" id="author_name" name="author_name" value="${book.authorName}" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required>${book.description}</textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" value="${book.price}" required>
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category}" ${category == book.category ? 'selected' : ''}>${category}</option>
                    </c:forEach>
                    <option value="other">Other</option>
                </select>
                <input type="text" id="newCategoryInput" name="newCategory" placeholder="Enter new category" style="display:none;">
            </div>
            <div class="form-group">
                <label for="pdfFile">Upload PDF:</label>
                <input type="file" id="pdfFile" name="pdfFile">
            </div>
            <div class="form-group">
                <label for="imageFile">Upload Image:</label>
                <input type="file" id="imageFile" name="imageFile">
            </div>
            <div class="form-group">
                <button type="submit">Update</button>
                <button type="button" class="cancel-button" onclick="cancelEdit(${book.id})">Cancel</button>
            </div>
        </form>
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
        <div>&copy; 2024 Book Dashboard</div>
        <div>
            <a href="/about">About</a>
            <a href="/contact">Contact</a>
        </div>
    </div>
</body>
</html>
