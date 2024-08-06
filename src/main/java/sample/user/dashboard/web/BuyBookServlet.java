package sample.user.dashboard.web;

import sample.user.dashboard.database.DashboardDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/buyBook")
public class BuyBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDao dashboardDao;

    public void init() {
        dashboardDao = new DashboardDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            String userIdParam = request.getParameter("userId");
            String bookIdParam = request.getParameter("bookId");

            if (userIdParam != null && bookIdParam != null) {
                try {
                    int userId = Integer.parseInt(userIdParam);
                    int bookId = Integer.parseInt(bookIdParam);

                    dashboardDao.addToShelf(userId, bookId);
                    response.sendRedirect(request.getContextPath() + "/shelf?id=" + userId);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid userId or bookId");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId or bookId");
            }
        } else {
            System.out.println("null");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
