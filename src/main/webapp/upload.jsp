<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .navbar, .footer {
            background-color: #2874f0;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
        }
        .navbar a, .footer a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            transition: background-color 0.3s ease;
        }
        .navbar a:hover, .footer a:hover {
            background-color: #1e60d5;
        }
        .upload-container {
            background-color: white;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 600px;
            text-align: center;
        }
        h1 {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            text-align: left;
        }
        input[type="text"],
        input[type="file"],
        input[type="number"],
        textarea,
        select {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #2874f0;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            color: #ffffff;
        }
        .success {
            background-color: #28a745;
        }
        .error {
            background-color: #dc3545;
        }
        .footer {
            margin-top: 20px;
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
    <script>
        function showMessage(message, type) {
            var messageBox = document.createElement('div');
            messageBox.className = 'message ' + (type === 'success' ? 'success' : 'error');
            messageBox.innerText = message;
            document.body.insertBefore(messageBox, document.querySelector('.upload-container'));
            setTimeout(function() {
                messageBox.remove();
            }, 5000);
        }

        window.onload = function() {
            var message = "${requestScope.uploadMessage}";
            if (message) {
                var messageType = "${requestScope.uploadMessageType}";
                showMessage(message, messageType);
            }

            var fileInputs = document.querySelectorAll('input[type="file"]');
            fileInputs.forEach(function(input) {
                input.addEventListener('change', function() {
                    var fileName = this.files.length > 0 ? this.files[0].name : '';
                    var labelText = fileName !== '' ? fileName : (this.accept === 'image/jpeg, image/png' ? 'Select an image' : 'Select a PDF');
                    this.previousElementSibling.textContent = labelText;
                });
            });

            var inputs = document.querySelectorAll('input, textarea, select');
            inputs.forEach(function(input) {
                input.addEventListener('focus', function() {
                    this.style.borderColor = '#2874f0';
                });
                input.addEventListener('blur', function() {
                    this.style.borderColor = '#ccc';
                });
            });

            var categorySelect = document.getElementById('category');
            var newCategoryInput = document.getElementById('newCategoryInput');
            categorySelect.addEventListener('change', function() {
                if (categorySelect.value === 'other') {
                    newCategoryInput.style.display = 'block';
                } else {
                    newCategoryInput.style.display = 'none';
                }
            });

            var button = document.querySelector('button');
            button.addEventListener('mouseover', function() {
                this.style.backgroundColor = '#0056b3';
            });
            button.addEventListener('mouseout', function() {
                this.style.backgroundColor = '#2874f0';
            });
        };
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
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
                    <a href="previousUploads?id=${id}" class="icon"><i class="fa fa-upload"></i> Previous Uploads</a>
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
    <div class="upload-container">
        <h1>Upload a Book</h1>
        <form action="${pageContext.request.contextPath}/uploadBook" method="post" enctype="multipart/form-data">
            <input type="hidden" name="userId" value="${id}">
            <label for="pdfFile">PDF File:</label>
            <input type="file" id="pdfFile" name="pdfFile" accept="application/pdf" required>
            <label for="imageFile">Image File:</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/jpeg, image/png" required>
            <input type="text" name="bookName" placeholder="Book Name" required>
            <input type="text" name="authorName" placeholder="Author Name" required>
            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="">Select a category</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category}">${category}</option>
                </c:forEach>
                <option value="other">Other</option>
            </select>
            <input type="text" id="newCategoryInput" name="newCategory" placeholder="Enter new category" style="display:none;">
            <textarea name="description" placeholder="Enter a description" rows="4" required></textarea>
            <input type="number" name="price" step="0.01" placeholder="Price" required>
            <button type="submit">Upload</button>
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
        <div>
            <p>&copy; 2024 Your Library. All rights reserved.</p>
        </div>
        <div>
            <a href="contact.jsp">Contact Us</a>
            <a href="about.jsp">About</a>
        </div>
    </div>
    <!-- Bootstrap JavaScript Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
