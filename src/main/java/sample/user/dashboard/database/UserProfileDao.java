package sample.user.dashboard.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;

import sample.user.dashboard.model.User;

public class UserProfileDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/users?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "tqQ6#JEB";
    private Connection connection;

    public UserProfileDao() {
        // Initialize database connection
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public User getUserByUsername(String username) {
        String query = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if user not found or error occurs
    }
}
