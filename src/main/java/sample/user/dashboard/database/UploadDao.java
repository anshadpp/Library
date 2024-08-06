package sample.user.dashboard.database;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UploadDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/users?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "tqQ6#JEB";

    private static final String INSERT_UPLOADS_SQL = "INSERT INTO uploads (userId, book_name, author_name, description, price, pdfFile, imageFile, category) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_CATEGORIES_SQL = "SELECT * FROM categories";
    private static final String INSERT_NEW_CATEGORY_SQL = "INSERT INTO categories (category) VALUES (?)";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public boolean uploadUploads(int userId, String bookName, String authorName, String description, double price, InputStream pdfInputStream, InputStream imageInputStream, String category) {
        boolean rowInserted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_UPLOADS_SQL)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, bookName);
            preparedStatement.setString(3, authorName);
            preparedStatement.setString(4, description);
            preparedStatement.setDouble(5, price);
            if (pdfInputStream != null) {
                preparedStatement.setBlob(6, pdfInputStream);
            }
            if (imageInputStream != null) {
                preparedStatement.setBlob(7, imageInputStream);
            }
            preparedStatement.setString(8, category);

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CATEGORIES_SQL)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String category = rs.getString("category");
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public void addNewCategory(String category) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_NEW_CATEGORY_SQL)) {
            preparedStatement.setString(1, category);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
