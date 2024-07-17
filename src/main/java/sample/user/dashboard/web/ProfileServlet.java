package sample.user.dashboard.web;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.dashboard.database.UserProfileDao;
import sample.user.dashboard.model.User;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserProfileDao userProfileDao;

    public void init() {
        userProfileDao = new UserProfileDao(); // Initialize your DAO correctly
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        // Fetch user details based on username
        User user = userProfileDao.getUserByUsername(username);

        if (user != null) {
            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
            dispatcher.forward(request, response);
        } else {
            // Handle case where user is not found
            response.getWriter().println("User not found");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
