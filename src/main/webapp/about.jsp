<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #2874f0;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            z-index: 1000;
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

        .footer {
            background-color: #2874f0;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
        }

        .footer a {
            color: white;
            text-decoration: none;
            padding: 10px;
            transition: background-color 0.3s ease;
        }

        .footer a:hover {
            background-color: #1e60d5;
        }

        .about-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
            margin: 100px auto; /* Center the content and avoid navbar and footer overlap */
        }

        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .about-info {
            margin-top: 30px;
            text-align: left;
        }

        .about-info p {
            margin-bottom: 15px;
            font-size: 18px;
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

        .drawer-toggle-label i {
            font-size: 24px;
        }

        /* Ensure the drawer toggle is always visible */
        .drawer-toggle {
            display: block;
        }

        /* Adjust footer to stick to the bottom when content is short */
        .footer {
            margin-top: auto;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
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

    <div class="about-container">
        <h2>About Us</h2>
        <div class="about-info">
            <p>Welcome to Your Library, where you can explore a wide range of books and resources.</p>
            <p>Our mission is to provide a convenient platform for readers to discover and enjoy their favorite books.</p>
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
