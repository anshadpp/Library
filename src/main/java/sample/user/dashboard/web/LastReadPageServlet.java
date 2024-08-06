package sample.user.dashboard.web;

import java.io.IOException;
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

@WebServlet("/LastReadPageServlet")
public class LastReadPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "tqQ6#JEB";

    // Handle saving the last read page via POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String bookId = request.getParameter("bookId");
        String lastPage = request.getParameter("lastPage");

        if (userId == null || userId.isEmpty() || bookId == null || bookId.isEmpty() || lastPage == null || lastPage.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing parameters.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // Update the last read page if a record exists, otherwise insert a new record
            String sql = "UPDATE user_book_progress SET last_page = ? WHERE user_id = ? AND book_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, lastPage);
                stmt.setString(2, userId);
                stmt.setString(3, bookId);
                int rowsUpdated = stmt.executeUpdate();

                // If no rows were updated, insert a new record
                if (rowsUpdated == 0) {
                    sql = "INSERT INTO user_book_progress (user_id, book_id, last_page) VALUES (?, ?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(sql)) {
                        insertStmt.setString(1, userId);
                        insertStmt.setString(2, bookId);
                        insertStmt.setString(3, lastPage);
                        insertStmt.executeUpdate();
                    }
                }
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Last read page saved successfully.");
        } catch (SQLException e) {
            handleSQLException(response, e, "An error occurred while saving the last read page.");
        }
    }

    // Handle retrieving the last read page via GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String bookId = request.getParameter("bookId");

        if (userId == null || userId.isEmpty() || bookId == null || bookId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing parameters.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT last_page FROM user_book_progress WHERE user_id = ? AND book_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, userId);
                stmt.setString(2, bookId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String lastPage = rs.getString("last_page");
                        response.getWriter().write(lastPage);
                    } else {
                        response.getWriter().write("1"); // Default to page 1 if no progress is found
                    }
                }
            }
        } catch (SQLException e) {
            handleSQLException(response, e, "An error occurred while retrieving the last read page.");
        }
    }

    // Centralized error handling method
    private void handleSQLException(HttpServletResponse response, SQLException e, String message) throws IOException {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write(message);
    }
}
