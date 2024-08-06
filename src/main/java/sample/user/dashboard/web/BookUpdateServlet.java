package sample.user.dashboard.web;

import sample.user.dashboard.database.UpdateDao;
import sample.user.dashboard.model.ViewUpload;
import sample.user.dashboard.model.ViewUUpload;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/update/update")
@MultipartConfig(
        maxFileSize = 104857600, // 100MB
        maxRequestSize = 209715200 // 200MB
)
public class BookUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UpdateDao updateDao;

    @Override
    public void init() {
        updateDao = new UpdateDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book ID is missing.");
                return;
            }

            int id = Integer.parseInt(idStr);
            ViewUUpload book = updateDao.selectBook(id);
            if (book == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found.");
                return;
            }

            List<String> categories = updateDao.getAllCategories();
            request.setAttribute("book", book);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/editdetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            updateBook(request, response);
        } catch (SQLException ex) {
            throw new ServletException("Database operation failed", ex);
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            String idStr = request.getParameter("id");
            String userIdStr = request.getParameter("userId");
            System.out.println("Received id: " + idStr);
            System.out.println("Received userId: " + userIdStr);

            if (idStr == null || userIdStr == null || idStr.isEmpty() || userIdStr.isEmpty()) {
                redirectToDetailWithMessage(response, idStr, "Invalid book or user ID.", "error");
                return;
            }

            int id = Integer.parseInt(idStr);
            int userId = Integer.parseInt(userIdStr);

            String bookName = request.getParameter("book_name");
            String authorName = request.getParameter("author_name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String category = request.getParameter("category");

            if (bookName == null || authorName == null || description == null || priceStr == null || category == null ||
                    bookName.isEmpty() || authorName.isEmpty() || description.isEmpty() || priceStr.isEmpty() || category.isEmpty()) {
                redirectToDetailWithMessage(response, idStr, "All fields are required.", "error");
                return;
            }

            double price = Double.parseDouble(priceStr);

            Part pdfFilePart = request.getPart("pdfFile");
            Part imageFilePart = request.getPart("imageFile");

            InputStream pdfFile = (pdfFilePart != null && pdfFilePart.getSize() > 0) ? pdfFilePart.getInputStream() : null;
            InputStream imageFile = (imageFilePart != null && imageFilePart.getSize() > 0) ? imageFilePart.getInputStream() : null;

            ViewUpload updatedBook = new ViewUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
            boolean isUpdated = updateDao.updateBookDetails(updatedBook);

            if (isUpdated) {
                redirectToDetailWithMessage(response, idStr, "Book details updated successfully!", "success");
            } else {
                redirectToDetailWithMessage(response, idStr, "Failed to update book.", "error");
            }
        } catch (NumberFormatException e) {
            redirectToDetailWithMessage(response, request.getParameter("id"), "Invalid input for number fields.", "error");
        } catch (Exception e) {
            redirectToDetailWithMessage(response, request.getParameter("id"), "An error occurred while updating the book.", "error");
        }
    }

    private void redirectToDetailWithMessage(HttpServletResponse response, String bookId, String message, String messageType) throws IOException {
        String url = "/sample/detail?bookId=" + bookId + "&updateMessage=" + message + "&updateMessageType=" + messageType;
        response.sendRedirect(url);
    }
}
