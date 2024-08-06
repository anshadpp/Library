<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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
        .profile-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
            overflow: hidden;
            margin: 100px auto;
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
        .verified-symbol {
            color: green;
            font-weight: bold;
        }
        .edit-button, .change-password-button, .verify-email-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            margin-right: 10px;
        }
        .edit-button:hover, .change-password-button:hover, .verify-email-button:hover {
            background-color: #0056b3;
        }
        .change-password-button {
            background-color: #28a745;
        }
        .change-password-button:hover {
            background-color: #218838;
        }
        .change-password-button:focus {
            outline: none;
        }
        .change-password-button:active {
            background-color: #1e7e34;
        }
        .hidden {
            display: none;
        }
        .form-container {
            margin-top: 20px;
            text-align: left;
        }
        .form-container form {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 15px;
        }
        .form-container label {
            display: block;
            margin-bottom: 8px;
        }
        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-container input[type="submit"],
        .form-container button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .form-container input[type="submit"]:hover,
        .form-container button:hover {
            background-color: #45a049;
        }
        .form-container button[type="button"] {
            background-color: #ccc;
            color: #333;
            transition: background-color 0.3s ease;
        }
        .form-container button[type="button"]:hover {
            background-color: #bbb;
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
    </div>

    <div class="profile-container">
        <h2>User Profile</h2>
        <div class="profile-info">
            <c:if test="${not empty user}">
                <p><label>Username:</label> ${user.username}</p>
                <p><label>Name:</label> ${user.name}</p>
                <p><label>Email:</label> ${user.email}</p>
                <p><label>Phone:</label> ${user.phone}
                    <c:if test="${user.emailVerified}">
                        <span class="verified-symbol">✔</span>
                    </c:if>
                </p>
                <p>
                    <a href="#" class="edit-button" onclick="showEditForm()">Edit Profile</a>
                    <a href="changePasswordPage.jsp?id=${user.id}" class="change-password-button">Change Password</a>
                    <c:if test="${!user.emailVerified}">
                        <a href="#" class="verify-email-button" onclick="sendVerificationEmail('${user.phone}')">Verify Phone</a>
                    </c:if>
                </p>
            </c:if>
            <c:if test="${empty user}">
                <p>User not found.</p>
            </c:if>
        </div>

        <!-- Edit Profile Form - Initially hidden -->
        <div class="form-container edit-profile-form hidden">
            <form action="editProfileServlet" method="post">
                <h3>Edit Profile</h3>
                <input type="hidden" id="edit-id" name="edit-id" value="${user.id}">
                <div>
                    <label for="edit-username">Username:</label>
                    <input type="text" id="edit-username" name="edit-username" value="${user.username}" required>
                </div>
                <div>
                    <label for="edit-name">Name:</label>
                    <input type="text" id="edit-name" name="edit-name" value="${user.name}" required>
                </div>
                <div>
                    <label for="edit-email">Email:</label>
                    <input type="email" id="edit-email" name="edit-email" value="${user.email}" required>
                </div>
                <div>
                    <label for="edit-phone">Phone:</label>
                    <input type="text" id="edit-phone" name="edit-phone" value="${user.phone}" required>
                </div>
                <div>
                    <input type="submit" value="Save">
                    <button type="button" onclick="cancelEdit()">Cancel</button>
                </div>
            </form>
        </div>

        <!-- Verify Email Form - Initially hidden -->
        <div class="form-container verify-email-form hidden">
            <form action="profile" method="post">
                <h3>Verify Phone</h3>
                <input type="hidden" name="action" value="verifyOtp">
                <input type="hidden" name="id" value="${user.id}">
                <div>
                    <label for="otp">Enter OTP:</label>
                    <input type="text" id="otp" name="otp" required>
                </div>
                <div>
                    <input type="submit" value="Verify">
                    <button type="button" onclick="cancelVerification()">Cancel</button>
                </div>
            </form>
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

    <script>
        // Function to show the edit profile form
        function showEditForm() {
            document.querySelector('.edit-profile-form').classList.remove('hidden');
            document.querySelector('.profile-info').classList.add('hidden');
        }

        // Function to cancel editing and show profile info again
        function cancelEdit() {
            document.querySelector('.edit-profile-form').classList.add('hidden');
            document.querySelector('.profile-info').classList.remove('hidden');
        }

        // Function to show the verify email form
        function sendVerificationEmail(phone) {
            // Call your server-side code to send a verification email here

            // Show the verification form
            document.querySelector('.verify-email-form').classList.remove('hidden');
            document.querySelector('.profile-info').classList.add('hidden');
        }

        // Function to cancel email verification
        function cancelVerification() {
            document.querySelector('.verify-email-form').classList.add('hidden');
            document.querySelector('.profile-info').classList.remove('hidden');
        }
    </script>
</body>
</html>
