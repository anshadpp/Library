package sample.user.dashboard.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import sample.user.dashboard.database.ChangePasswordDao;
import sample.user.dashboard.model.User;

@WebServlet("/changePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ChangePasswordDao changePasswordDao;

    @Override
    public void init() throws ServletException {
        super.init();
        changePasswordDao = new ChangePasswordDao(); // Initialize your DAO here
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("userId")); // Retrieve userId from request parameter
        String currentPassword = request.getParameter("current-password");
        String newPassword = request.getParameter("new-password");
        String confirmPassword = request.getParameter("confirm-password");

        if (newPassword.equals(confirmPassword)) {
            User user = changePasswordDao.getUserById(id);
            if (user != null && user.getPassword().equals(currentPassword)) {
                user.setPassword(newPassword);
                if (changePasswordDao.updatePassword(user)) {
                    // Password changed successfully
                    response.sendRedirect(request.getContextPath() + "/changePasswordPage.jsp?id=" + id + "&success=true");
                } else {
                    // Handle error in updating password
                    response.sendRedirect(request.getContextPath() + "/changePasswordPage.jsp?id=" + id + "&error=update_failed");
                }
            } else {
                // Handle invalid current password or user not found
                response.sendRedirect(request.getContextPath() + "/changePasswordPage.jsp?id=" + id + "&error=invalid_current_password");
            }
        } else {
            // Handle password mismatch
            response.sendRedirect(request.getContextPath() + "/changePasswordPage.jsp?id=" + id + "&error=password_mismatch");
        }
    }
}
