package sample.user.dashboard.web;

import sample.user.dashboard.database.UpdateDao;
//import sample.user.dashboard.model.ViewUpload;
import sample.user.dashboard.model.ViewUUpload;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/update/*")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UpdateDao updateDao;

    @Override
    public void init() {
        updateDao = new UpdateDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        try {
            switch (action) {
                case "/delete":
                    deleteBook(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                	response.sendRedirect("/sample/update/update");
                
            }
        } catch (SQLException ex) {
            throw new ServletException("Database operation failed", ex);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("/sample/previousUploads");
            return;
        }

        int id = Integer.parseInt(idParam);
        ViewUUpload existingBook = updateDao.selectBook(id);
        List<String> categories = updateDao.getAllCategories();
        
        request.setAttribute("book", existingBook);
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/editdetail.jsp").forward(request, response);
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String idParam = request.getParameter("id");
        String userIdParam = request.getParameter("userId");
        if (idParam == null || idParam.isEmpty() || userIdParam == null || userIdParam.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid book ID or user ID.");
            request.getRequestDispatcher("/sample/previousUploads").forward(request, response);
            return;
        }

        int id = Integer.parseInt(idParam);
        int userId = Integer.parseInt(userIdParam);
        
        boolean isDeleted = updateDao.deleteBook(id);

        if (isDeleted) {
            response.sendRedirect("/sample/previousUploads?id=" + userId);
        } else {
            request.setAttribute("errorMessage", "Failed to delete book.");
            request.getRequestDispatcher("/sample/previousUploads").forward(request, response);
        }
    }
}
