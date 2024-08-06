package sample.user.dashboard.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.dashboard.database.ViewUploadDao;
import sample.user.dashboard.model.ViewUUpload;

@WebServlet("/detail")
public class DetailServletPre extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ViewUploadDao viewUploadDao;

    @Override
    public void init() throws ServletException {
        viewUploadDao = new ViewUploadDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        System.out.println(bookId);

        if (bookId != null && !bookId.isEmpty()) {
            try {
                int id = Integer.parseInt(bookId);
                ViewUUpload book = viewUploadDao.getBookById(id);

                if (book != null) {
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("/detailspre.jsp").forward(request, response);
                } else {
                    response.sendRedirect("error.jsp"); // redirect to an error page if book not found
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("error"); // redirect to an error page if bookId is not a valid integer
            }
        } else {
            response.sendRedirect("error"); // redirect to an error page if bookId is null or empty
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle the read book action
        String bookId = request.getParameter("bookId");

        if (bookId != null && !bookId.isEmpty()) {
            try {
                int id = Integer.parseInt(bookId);
                // Redirect to the page or functionality for reading the book
                response.sendRedirect("readBook?bookId=" + id);
            } catch (NumberFormatException e) {
                response.sendRedirect("error.jsp"); // redirect to an error page if bookId is not a valid integer
            }
        } else {
            response.sendRedirect("error.jsp"); // redirect to an error page if bookId is null or empty
        }
    }
}
