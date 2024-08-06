package sample.user.dashboard.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.dashboard.util.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/rateBook")
public class RateBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int rating = Integer.parseInt(request.getParameter("rating"));

        try (Connection conn = DBUtil.getConnection()) {
            // Insert or update the rating for the user and book
            String sql = "INSERT INTO bookratings (book_id, user_id, rating) VALUES (?, ?, ?) " +
                         "ON DUPLICATE KEY UPDATE rating = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, bookId);
                stmt.setInt(2, userId);
                stmt.setInt(3, rating);
                stmt.setInt(4, rating);
                stmt.executeUpdate();
            }

            // Calculate the new average rating
            double averageRating = 0.0;
            sql = "SELECT AVG(rating) AS avg_rating FROM bookratings WHERE book_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, bookId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        averageRating = rs.getDouble("avg_rating");
                    }
                }
            }

            response.setContentType("application/json");
            response.getWriter().write("{\"averageRating\": " + averageRating + "}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the rating.");
        }
    }
}
