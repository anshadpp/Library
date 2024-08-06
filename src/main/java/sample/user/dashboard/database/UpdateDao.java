package sample.user.dashboard.database;

import sample.user.dashboard.model.ViewUpload;
import sample.user.dashboard.model.ViewUUpload;
import sample.user.dashboard.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UpdateDao {

    private static final String SELECT_BOOK_BY_ID = "SELECT * FROM uploads WHERE id = ?";
   
    private static final String DELETE_BOOK_SQL = "DELETE FROM uploads WHERE id = ?";
    private static final String SELECT_ALL_CATEGORIES = "SELECT * FROM categories";

    public ViewUUpload selectBook(int id) {
        ViewUUpload book = null;
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BOOK_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("userId");
                String bookName = rs.getString("book_name");
                String authorName = rs.getString("author_name");
                String description = rs.getString("description");
                byte[] pdfFile = rs.getBytes("pdfFile");
                byte[] imageFile = rs.getBytes("imageFile");
                double price = rs.getDouble("price");
                String category = rs.getString("category");
                book = new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return book;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CATEGORIES)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String category = rs.getString("category");
                categories.add(category);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return categories;
    }

    public boolean updateBookDetails(ViewUpload book) {
        String jdbcURL = "jdbc:mysql://localhost:3306/users?useSSL=false";
        String dbUser = "root";
        String dbPassword = "tqQ6#JEB";

        StringBuilder sql = new StringBuilder("UPDATE uploads SET book_name = ?, author_name = ?, description = ?, category = ?, price = ?");
        if (book.getPdfInputStream() != null) {
            sql.append(", pdfFile = ?");
        }
        if (book.getImageInputStream() != null) {
            sql.append(", imageFile = ?");
        }
        sql.append(" WHERE id = ?");

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            stmt.setString(paramIndex++, book.getBookName());
            stmt.setString(paramIndex++, book.getAuthorName());
            stmt.setString(paramIndex++, book.getDescription());
            stmt.setString(paramIndex++, book.getCategory());
            stmt.setDouble(paramIndex++, book.getPrice());
            if (book.getPdfInputStream() != null) {
                stmt.setBlob(paramIndex++, book.getPdfInputStream());
            }
            if (book.getImageInputStream() != null) {
                stmt.setBlob(paramIndex++, book.getImageInputStream());
            }
            stmt.setInt(paramIndex, book.getId());

            int row = stmt.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean deleteBook(int id) throws SQLException {
        boolean rowDeleted = false;

        String deleteFromShelvesSQL = "DELETE FROM shelves WHERE book_id = ?";
        String deleteFromUploadsSQL = "DELETE FROM uploads WHERE id = ?";

        try (Connection connection = DBUtil.getConnection()) {
            // Start a transaction
            connection.setAutoCommit(false);

            // Delete from the shelves table
            try (PreparedStatement deleteShelvesStmt = connection.prepareStatement(deleteFromShelvesSQL)) {
                deleteShelvesStmt.setInt(1, id);
                deleteShelvesStmt.executeUpdate();
            }

            // Delete from the uploads table
            try (PreparedStatement deleteUploadsStmt = connection.prepareStatement(deleteFromUploadsSQL)) {
                deleteUploadsStmt.setInt(1, id);
                rowDeleted = deleteUploadsStmt.executeUpdate() > 0;
            }

            // Commit the transaction
            connection.commit();
        }

        return rowDeleted;
    }


    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
