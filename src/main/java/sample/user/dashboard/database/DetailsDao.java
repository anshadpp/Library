package sample.user.dashboard.database;
import sample.user.dashboard.model.ViewUUpload;
import sample.user.dashboard.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DetailsDao {

	    /**
	     * Retrieves a book by its ID.
	     *
	     * @param id The ID of the book.
	     * @return The ViewUpload object corresponding to the book ID, or null if not found.
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
	                    ViewUUpload book=new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
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

