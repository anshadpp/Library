package sample.user.dashboard.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import sample.user.dashboard.model.User;
import sample.user.dashboard.util.DBUtil;

public class ChangePasswordDao {

    // Method to retrieve user by ID
    public User getUserById(int id) {
        User user = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String query = "SELECT * FROM users WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setPassword(rs.getString("password"));
                // Populate other user details as needed
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs); // Close resources
        }

        return user;
    }

    // Method to update user's password by ID
    public boolean updatePassword(User user) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtil.getConnection();
            String query = "UPDATE users SET password = ? WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, user.getPassword());
            stmt.setInt(2, user.getId());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt); // Close resources
        }

        return success;
    }
}
