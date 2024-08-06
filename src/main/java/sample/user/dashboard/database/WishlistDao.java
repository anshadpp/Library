package sample.user.dashboard.database;

import sample.user.dashboard.model.ViewUUpload;
import sample.user.dashboard.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDao {

    private static final String SELECT_WISHLIST_BY_USER_ID = "SELECT u.id, u.book_name, u.author_name, u.imageFile FROM wishlists w INNER JOIN uploads u ON w.book_id = u.id WHERE w.userId = ?";

    public List<ViewUUpload> getWishlist(int userId) {
        List<ViewUUpload> wishlistBooks = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_WISHLIST_BY_USER_ID)) {
            preparedStatement.setInt(1, userId);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                ViewUUpload book = new ViewUUpload();
                book.setId(rs.getInt("id"));
                book.setBookName(rs.getString("book_name"));
                book.setAuthorName(rs.getString("author_name"));
                book.setImageFile(rs.getBytes("imageFile"));
                wishlistBooks.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return wishlistBooks;
    }
    public boolean deleteFromWishlist(int userId, int bookId) {
        String sql = "DELETE FROM wishlists WHERE userId = ? AND book_id = ?";
        try (Connection connection = DBUtil.getConnection();PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
