package sample.user.dashboard.web;

import sample.user.dashboard.database.DashboardDao;
import sample.user.dashboard.model.ViewUUpload;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/shelf")
public class ShelfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDao dashboardDao;

    public void init() {
        dashboardDao = new DashboardDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = Integer.parseInt(request.getParameter("id"));
        List<ViewUUpload> userBooks = dashboardDao.getUserBoughtBooks(userId);

        if (userBooks != null) {
            // Get userId from the session
            

            // Retrieve books bought by the user
            
            request.setAttribute("userBooks", userBooks);
            request.setAttribute("userId", userId);

            RequestDispatcher dispatcher = request.getRequestDispatcher("shelf.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
