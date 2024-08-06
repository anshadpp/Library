package sample.user.login.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import sample.user.login.bean.LoginBean;
import sample.user.login.database.LoginDao;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginDao loginDao;

    public void init() {
        loginDao = new LoginDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String identifier = request.getParameter("username");
        String password = request.getParameter("password");

        LoginBean loginBean = new LoginBean();
        loginBean.setIdentifier(identifier);
        loginBean.setPassword(password);

        try {
            if (loginDao.validate(loginBean)) {
                int id = loginDao.getId(identifier);
                HttpSession session = request.getSession();
                session.setAttribute("id", id);
                response.sendRedirect("/sample/dashboard");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Invalid login credentials.");
                response.sendRedirect("login.jsp");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
