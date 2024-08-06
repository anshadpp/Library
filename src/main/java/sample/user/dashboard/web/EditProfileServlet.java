package sample.user.dashboard.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.dashboard.database.UserDao;
import sample.user.dashboard.model.User;

@WebServlet("/editProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("edit-id");
            if (idParam == null || idParam.isEmpty()) {
                throw new NumberFormatException("ID is null or empty");
            }
            int id = Integer.parseInt(idParam);

            String username = request.getParameter("edit-username");
            String name = request.getParameter("edit-name");
            String email = request.getParameter("edit-email");
            String phone = request.getParameter("edit-phone");

            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);

            boolean success = userDao.updateUser(user);

            if (success) {
                response.sendRedirect("profile?id=" + id);
            } else {
                response.getWriter().println("Error updating user");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Invalid user ID");
        }
    }
}
