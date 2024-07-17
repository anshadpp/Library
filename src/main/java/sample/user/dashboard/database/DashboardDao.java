package sample.user.dashboard.database;


import sample.user.dashboard.model.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DashboardDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/users?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "tqQ6#JEB";

    private static final String SELECT_ALL_BOOKS = "SELECT id, book_name, author_name, pdf_file_path FROM books";

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

    public List<Books> selectAllBooks() {
        List<Books> books = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BOOKS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String book_name = rs.getString("book_name");
                String author_name = rs.getString("author_name");
                String pdf_file_path = rs.getString("pdf_file_path");
                books.add(new Books(id, book_name, author_name, pdf_file_path));
                System.out.println("Fetched book: " + book_name);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }
}

