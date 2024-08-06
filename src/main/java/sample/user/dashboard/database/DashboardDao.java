package sample.user.dashboard.database;

import sample.user.dashboard.model.ViewUUpload;
import sample.user.dashboard.util.DBUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DashboardDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/users?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "tqQ6#JEB";

    private static final String SELECT_ALL_BOOKS = "SELECT userId, id, book_name, author_name, pdfFile, imageFile, description, price, category FROM uploads";
    private static final String SELECT_DISTINCT_CATEGORIES = "SELECT DISTINCT category FROM uploads";
    private static final String SELECT_ALL_CATEGORIES_SQL = "SELECT DISTINCT category FROM uploads";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public List<ViewUUpload> selectAllBooks() {
        List<ViewUUpload> books = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BOOKS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId = rs.getInt("userId");
                String bookName = rs.getString("book_name");
                String authorName = rs.getString("author_name");
                byte[] pdfFile = rs.getBytes("pdfFile");
                byte[] imageFile = rs.getBytes("imageFile");
                String description = rs.getString("description");
                String category = rs.getString("category");
                double price = rs.getDouble("price");

                ViewUUpload book = new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, category);
                books.add(book);
                System.out.println("Fetched book: " + bookName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<ViewUUpload> getBooks(String sort, String category) {
        List<ViewUUpload> books = new ArrayList<>();
        StringBuilder query = new StringBuilder(SELECT_ALL_BOOKS);
        
        if (category != null && !category.isEmpty()) {
            query.append(" WHERE category=?");
        }
        
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "title_asc":
                    query.append(" ORDER BY book_name ASC");
                    break;
                case "title_desc":
                    query.append(" ORDER BY book_name DESC");
                    break;
                case "author_asc":
                    query.append(" ORDER BY author_name ASC");
                    break;
                case "author_desc":
                    query.append(" ORDER BY author_name DESC");
                    break;
                default:
                    break;
            }
        }

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query.toString())) {

            if (category != null && !category.isEmpty()) {
                statement.setString(1, category);
            }

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId = rs.getInt("userId");
                String bookName = rs.getString("book_name");
                String authorName = rs.getString("author_name");
                byte[] pdfFile = rs.getBytes("pdfFile");
                byte[] imageFile = rs.getBytes("imageFile");
                String description = rs.getString("description");
                String bookCategory = rs.getString("category");
                double price = rs.getDouble("price");

                ViewUUpload book = new ViewUUpload(id, userId, bookName, authorName, pdfFile, imageFile, description, price, bookCategory);
                books.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<String> getCategories() {
        List<String> categories = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_DISTINCT_CATEGORIES)) {

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<ViewUUpload> getUserBoughtBooks(int userId) {
        List<ViewUUpload> books = new ArrayList<>();
        String sql = "SELECT u.* FROM uploads u INNER JOIN shelves s ON u.id = s.book_id WHERE s.userId = ?";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    ViewUUpload book = new ViewUUpload();
                    book.setId(rs.getInt("id"));
                    book.setBookName(rs.getString("book_name"));
                    book.setAuthorName(rs.getString("author_name"));
                    book.setImageFile(rs.getBytes("imageFile"));
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public void addToWishlist(int userId, int bookId) {
        String sql = "INSERT INTO wishlists (userId, book_id) VALUES (?, ?)";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, bookId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addToShelf(int userId, int bookId) {
        String sql = "INSERT INTO shelves (userId, book_id) VALUES (?, ?)";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, bookId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
}
