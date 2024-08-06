package sample.user.dashboard.database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class BookDAO {

    public boolean uploadBook(String bookName, String authorName,String description,double price, InputStream pdfData, InputStream imageData) {
        String jdbcURL = "jdbc:mysql://localhost:3306/users?useSSL=false";
        String dbUser = "root";
        String dbPassword = "tqQ6#JEB";

        String sql = "INSERT INTO books (book_name, author_name, pdf_file_data, image_data, description, price) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            stmt.setString(1, bookName);
            stmt.setString(2, authorName);
            if (pdfData != null) {
                stmt.setBlob(3, pdfData);
            }
            if (imageData != null) {
                stmt.setBlob(4, imageData);
            }
            stmt.setString(5, description);
            stmt.setDouble(6, price);
            int row = stmt.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
