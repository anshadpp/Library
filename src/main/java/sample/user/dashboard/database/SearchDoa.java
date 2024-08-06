package sample.user.dashboard.database;

import sample.user.dashboard.model.ViewUUpload;
import sample.user.dashboard.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SearchDoa {
	


	

	    public static List<ViewUUpload> searchBooks(String query) {
	        List<ViewUUpload> books = new ArrayList<>();
	        String sql = "SELECT * FROM uploads WHERE book_name LIKE ? OR author_name LIKE ?";
	        
	        try (Connection connection = DBUtil.getConnection();
	             PreparedStatement statement = connection.prepareStatement(sql)) {
	            statement.setString(1, "%" + query + "%");
	            statement.setString(2, "%" + query + "%");
	            ResultSet rs = statement.executeQuery();

	            while (rs.next()) {
	                int id = rs.getInt("id");
	                int userId = rs.getInt("userId");
	                String bookName = rs.getString("book_name");
	                String authorName = rs.getString("author_name");
	                byte[] pdfFile = rs.getBytes("pdfFile");
	                byte[] imageFile = rs.getBytes("imageFile");
	                String description=rs.getString("description");
	                String category=rs.getString("category");
	                double price = rs.getDouble("price");
//	                books.add(new Books(id, book_name, author_name, pdf_file_data, image_data));
	                ViewUUpload book=new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
	               
	                books.add(book);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return books;
	    }
	}
