package sample.user.registration.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.registration.dao.UserDao;
import sample.user.registration.model.Users;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDao userDao = new UserDao();

    public ForgotPasswordServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/forgotpassword.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String securityAnswer = request.getParameter("securityAnswer");
        String newPassword = request.getParameter("newPassword");

        try {
            Users user = userDao.getUserByUsername(username);
            if (user != null) {
                // If security question is not answered yet, display it
                if (securityAnswer == null || securityAnswer.isEmpty()) {
                    request.setAttribute("username", username);
                    request.setAttribute("securityQuestion", user.getSecurityQuestion());
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/forgotpassword.jsp");
                    dispatcher.forward(request, response);
                } else if (user.getSecurityAnswer().equals(securityAnswer)) {
                    userDao.updatePassword(username, newPassword);
                    request.setAttribute("message", "Password reset successfully.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Invalid security answer.");
                    request.setAttribute("username", username);
                    request.setAttribute("securityQuestion", user.getSecurityQuestion());
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/forgotpassword.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                request.setAttribute("error", "User not found.");
                request.getRequestDispatcher("/WEB-INF/views/forgotpassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("/WEB-INF/views/forgotpassword.jsp").forward(request, response);
        }
    }
}
