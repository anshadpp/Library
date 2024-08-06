package sample.user.dashboard.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sample.user.dashboard.model.ViewUUpload;
import sample.user.dashboard.util.DBUtil; // Ensure this utility class is correctly implemented

public class ViewUploadDao {

    /**
     * Retrieves a list of uploads by userId.
     * 
     * @param userId The userId of the user whose uploads are to be retrieved.
     * @return A list of ViewUpload objects corresponding to the userId.
     */
    public List<ViewUUpload> getUploadsByUserId(int userId) {
        List<ViewUUpload> uploads = new ArrayList<>();
        String query = "SELECT * FROM uploads WHERE userId = ?";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    // Retrieve data and create ViewUpload objects
                    int id = resultSet.getInt("id");
                    String bookName = resultSet.getString("book_name");
                    String authorName = resultSet.getString("author_name");
                    byte[] pdfFile = resultSet.getBytes("pdfFile");
                    byte[] imageFile = resultSet.getBytes("imageFile");
                    String description = resultSet.getString("description");
                    String category = resultSet.getString("category");
                    double price = resultSet.getDouble("price");

                    ViewUUpload upload = new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
                    uploads.add(upload);
                    System.out.println("Fetched book: " + bookName);
                }
            }
        } catch (SQLException e) {
            // Log the exception
            System.err.println("SQL error occurred while retrieving uploads: " + e.getMessage());
            e.printStackTrace();
        }
        return uploads;
    }

    /**
     * Retrieves a specific book by its ID.
     * 
     * @param id The ID of the book to be retrieved.
     * @return A ViewUUpload object corresponding to the book ID.
     */
    public ViewUUpload getBookById(int id) {
        String query = "SELECT * FROM uploads WHERE id = ?";
        
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int userId = resultSet.getInt("userId");
                    String bookName = resultSet.getString("book_name");
                    String authorName = resultSet.getString("author_name");
                    byte[] pdfFile = resultSet.getBytes("pdfFile");
                    byte[] imageFile = resultSet.getBytes("imageFile");
                    String description = resultSet.getString("description");
                    String category = resultSet.getString("category");
                    double price = resultSet.getDouble("price");

                    ViewUUpload book = new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
                    return book;
                }
            }
        } catch (SQLException e) {
            // Log the exception
            System.err.println("SQL error occurred while retrieving book: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
