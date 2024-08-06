package sample.user.dashboard.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.Part;
import sample.user.dashboard.database.UploadDao;

@WebServlet("/uploadBook")
@MultipartConfig(
        maxFileSize = 104857600, // 100MB
        maxRequestSize = 209715200 // 200MB
)
public class UploadBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UploadDao uploadDAO;

    public void init() {
        uploadDAO = new UploadDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch categories from database
        List<String> categories = uploadDAO.getAllCategories();
        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/upload.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idString = request.getParameter("userId");
        int id = 0;
        try {
            id = Integer.parseInt(idString);
        } catch (NumberFormatException e) {
            request.setAttribute("uploadMessage", "Invalid ID. Please try again.");
            request.setAttribute("uploadMessageType", "error");
            request.getRequestDispatcher("/upload.jsp").forward(request, response);
            return;
        }

        String bookName = request.getParameter("bookName");
        String authorName = request.getParameter("authorName");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String newCategory = request.getParameter("newCategory");
        String priceString = request.getParameter("price");
        double price = 0.0;

        if (priceString != null && !priceString.trim().isEmpty()) {
            try {
                price = Double.parseDouble(priceString.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("uploadMessage", "Invalid price. Please enter a valid number.");
                request.setAttribute("uploadMessageType", "error");
                request.getRequestDispatcher("/upload.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("uploadMessage", "Price is required.");
            request.setAttribute("uploadMessageType", "error");
            request.getRequestDispatcher("/upload.jsp").forward(request, response);
            return;
        }

        // Handle new category
        if ("other".equals(category)) {
            if (newCategory != null && !newCategory.trim().isEmpty()) {
                // Add the new category to the database and update the category variable
                uploadDAO.addNewCategory(newCategory);
                category = newCategory;
            } else {
                request.setAttribute("uploadMessage", "New category name is required.");
                request.setAttribute("uploadMessageType", "error");
                request.getRequestDispatcher("/upload.jsp").forward(request, response);
                return;
            }
        }

        InputStream pdfInputStream = null;
        InputStream imageInputStream = null;

        Part pdfPart = request.getPart("pdfFile");
        Part imagePart = request.getPart("imageFile");
        if (pdfPart != null) {
            pdfInputStream = pdfPart.getInputStream();
        }
        if (imagePart != null) {
            imageInputStream = imagePart.getInputStream();
        }

        boolean isUploadRecorded = uploadDAO.uploadUploads(id, bookName, authorName, description, price, pdfInputStream, imageInputStream, category);

        if (isUploadRecorded) {
            request.setAttribute("uploadMessage", "Book uploaded successfully!");
            request.setAttribute("uploadMessageType", "success");
        } else {
            request.setAttribute("uploadMessage", "Failed to upload book. Please try again.");
            request.setAttribute("uploadMessageType", "error");
        }

        // Forward the request back to the upload page with the message
        request.getRequestDispatcher("/upload.jsp").forward(request, response);
    }
}
