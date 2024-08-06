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

@WebServlet("/register")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDao userDao = new UserDao();
    private static final String CAPTCHA_SESSION_KEY = "captcha";

    public UserServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/userregister.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String securityQuestion = request.getParameter("securityQuestion");
        String securityAnswer = request.getParameter("securityAnswer");
        String captcha = request.getParameter("captcha");

        // CAPTCHA validation
        String sessionCaptcha = (String) request.getSession().getAttribute(CAPTCHA_SESSION_KEY);
        if (sessionCaptcha == null || !sessionCaptcha.equals(captcha)) {
            request.setAttribute("error", "Invalid CAPTCHA");
            request.getRequestDispatcher("/WEB-INF/views/userregister.jsp").forward(request, response);
            return;
        }

        Users user = new Users();
        user.setName(name);
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setSecurityQuestion(securityQuestion);
        user.setSecurityAnswer(securityAnswer);

        try {
            int result = userDao.registerUser(user);
            if (result == -1) {
                request.setAttribute("error", "Username or Email already exists.");
                request.getRequestDispatcher("/WEB-INF/views/userregister.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
