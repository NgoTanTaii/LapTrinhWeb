package Dao;

import DBcontext.Database;
import Entity.DepositOrder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import static DBcontext.Database.getConnection;
import static com.mysql.cj.conf.PropertyKey.logger;

public class DepositOrderDAO {

    private static final Logger LOGGER = Logger.getLogger(DepositOrderDAO.class.getName());

    // Check if a user has already made a deposit for a specific property
    public boolean isDeposited(int userId, int propertyId) throws SQLException {
        String query = "SELECT COUNT(*) FROM deposit_orders WHERE user_id = ? AND property_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, propertyId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // If count is greater than 0, it means the user has deposited
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL error occurred while checking deposit status", e);
            throw e; // Rethrow exception to propagate it to the caller
        }
        return false;
    }

    // Get all deposit orders from the database
    public List<DepositOrder> getAllDeposits() throws SQLException {
        List<DepositOrder> deposits = new ArrayList<>();
        String query = "SELECT * FROM deposit_orders";
        Connection connection = Database.getConnection();
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            // Loop through the result set and create DepositOrder objects
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId = rs.getInt("user_id");
                int propertyId = rs.getInt("property_id");
                double depositAmount = rs.getDouble("deposit_amount");
                Date depositDate = rs.getDate("deposit_date");
                String status = rs.getString("status");
                String comments = rs.getString("comments");


                DepositOrder deposit = new DepositOrder(id, userId, propertyId, depositAmount, depositDate, status, comments);
                deposits.add(deposit);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deposits;
    }

    public void updateDepositStatus(int depositId, String status) throws SQLException {
        String query = "UPDATE deposit_orders SET status = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setInt(2, depositId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("No rows affected, update failed for deposit ID: " + depositId);
            }

        } catch (SQLException e) {

            throw e; // Rethrow to handle it further in the servlet
        }
    }

    public static void main(String[] args) throws SQLException {
        DepositOrderDAO dao = new DepositOrderDAO();
        System.out.println(dao.getAllDeposits());
    }
    // Optionally, if you're working with a connection pool, you'd return the connection to the pool
    // after use, but since you're using a single connection, make sure to manage it properly in the
    // Database class or connection pool manager.
}
