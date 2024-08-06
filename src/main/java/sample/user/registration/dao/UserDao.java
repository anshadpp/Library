package sample.user.registration.dao;

import sample.user.registration.model.Users;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    public int registerUser(Users users) throws ClassNotFoundException {
        String INSERT_USER_SQL = "INSERT INTO users (name, username, email, phone, password, security_question, security_answer) VALUES (?, ?, ?, ?, ?, ?, ?);";
        int result = 0;
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {

            preparedStatement.setString(1, users.getName());
            preparedStatement.setString(2, users.getUsername());
            preparedStatement.setString(3, users.getEmail());
            preparedStatement.setString(4, users.getPhone());
            preparedStatement.setString(5, users.getPassword());
            preparedStatement.setString(6, users.getSecurityQuestion());
            preparedStatement.setString(7, users.getSecurityAnswer());

            System.out.println(preparedStatement);

            result = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Check if the exception is due to a duplicate entry
            if (e.getSQLState().equals("23000")) { // SQL state for integrity constraint violation
                System.out.println("Duplicate entry for username or email");
                result = -1; // Use a specific value to indicate the duplicate entry error
            } else {
                System.out.println("SQL error");
                e.printStackTrace();
            }
        }
        return result;
    }

    public Users getUserByUsername(String username) throws ClassNotFoundException {
        String SELECT_USER_BY_USERNAME_SQL = "SELECT * FROM users WHERE username = ?;";
        Users user = null;
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_USERNAME_SQL)) {

            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                user = new Users();
                user.setName(rs.getString("name"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setSecurityQuestion(rs.getString("security_question"));
                user.setSecurityAnswer(rs.getString("security_answer"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public int updatePassword(String username, String newPassword) throws ClassNotFoundException {
        String UPDATE_PASSWORD_SQL = "UPDATE users SET password = ? WHERE username = ?;";
        int result = 0;
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PASSWORD_SQL)) {

            preparedStatement.setString(1, newPassword);
            preparedStatement.setString(2, username);

            result = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
