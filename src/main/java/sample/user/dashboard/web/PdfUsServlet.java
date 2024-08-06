package sample.user.dashboard.web;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/pdfu")
public class PdfUsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("id");

        if (bookId == null || bookId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid book ID.");
            return;
        }

        // Fetch last read page for the user and book
        String userId = (String) request.getSession().getAttribute("userId");
        int lastReadPage = getLastReadPage(userId, bookId);

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
            stmt = conn.prepareStatement("SELECT pdfFile FROM uploads WHERE id = ?");
            stmt.setString(1, bookId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                InputStream pdfData = rs.getBinaryStream("pdfFile");
                if (pdfData != null) {
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "inline; filename=\"book.pdf\"");

                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = pdfData.read(buffer)) != -1) {
                        response.getOutputStream().write(buffer, 0, bytesRead);
                    }

                    // If you need to send last read page info, consider using cookies or separate endpoint
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("PDF data not found for book ID: " + bookId);
                }
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Book not found for ID: " + bookId);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database driver not found.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred while retrieving the PDF.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Helper method to retrieve the last read page from user_book_progress
    private int getLastReadPage(String userId, String bookId) {
        int lastPage = 1; // Default to page 1 if no progress is found

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
            stmt = conn.prepareStatement("SELECT last_page FROM user_book_progress WHERE user_id = ? AND book_id = ?");
            stmt.setString(1, userId);
            stmt.setString(2, bookId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                lastPage = rs.getInt("last_page");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return lastPage;
    }
}
