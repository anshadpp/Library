package sample.user.dashboard.web;

import sample.user.dashboard.database.DashboardDao;
import sample.user.dashboard.database.UploadDao;
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

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDao dashboardDao;

    public void init() {
        dashboardDao = new DashboardDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Do not create a new session if it doesn't exist

        String sort = request.getParameter("sort");
        String category = request.getParameter("category");
        List<String> categories = dashboardDao.getAllCategories();
        request.setAttribute("categories", categories);
        List<ViewUUpload> books = dashboardDao.getBooks(sort, category);
        request.setAttribute("books", books);

        if (session != null && session.getAttribute("id") != null) {
            int id = (int) session.getAttribute("id");
            request.setAttribute("id", id);

            // Retrieve books from user's shelf
            List<ViewUUpload> userBooks = dashboardDao.getUserBoughtBooks(id);
            request.setAttribute("userBooks", userBooks);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
