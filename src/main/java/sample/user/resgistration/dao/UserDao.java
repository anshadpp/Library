package sample.user.resgistration.dao;

import sample.user.resgistration.model.Users;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDao {
    public int registerUser(Users users) throws ClassNotFoundException {
        String INSERT_USER_SQL = "INSERT INTO users (name, username, email, phone, password) VALUES (?, ?, ?, ?, ?);";
        int result = 0;
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false", "root", "tqQ6#JEB");
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {

            preparedStatement.setString(1, users.getName());
            preparedStatement.setString(2, users.getUsername());
            preparedStatement.setString(3, users.getEmail());
            preparedStatement.setString(4, users.getPhone());
            preparedStatement.setString(5, users.getPassword());

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
}
