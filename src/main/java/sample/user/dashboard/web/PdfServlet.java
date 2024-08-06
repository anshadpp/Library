package sample.user.dashboard.web;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/pdf")
public class PdfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("id");

        if (bookId == null || bookId.isEmpty()) {
            response.getWriter().write("Invalid book ID.");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
             PreparedStatement stmt = conn.prepareStatement("SELECT pdf_file_data FROM books WHERE id = ?")) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            stmt.setString(1, bookId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    InputStream pdfData = rs.getBinaryStream("pdf_file_data");
                    if (pdfData != null) {
                        response.setContentType("application/pdf");
                        response.setHeader("Content-Disposition", "inline; filename=\"book.pdf\"");
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = pdfData.read(buffer)) != -1) {
                            response.getOutputStream().write(buffer, 0, bytesRead);
                        }
                    } else {
                        response.getWriter().write("PDF data not found for book ID: " + bookId);
                    }
                } else {
                    response.getWriter().write("Book not found for ID: " + bookId);
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().write("Database driver not found.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred while retrieving the PDF.");
        }
    }
}
