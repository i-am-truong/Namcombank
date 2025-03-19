/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.math.BigDecimal;
import java.util.ArrayList;
import model.RepaymentSchedule;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

public class RepaymentScheduleDAO extends DBContext<RepaymentSchedule> {

    public boolean processPaymentTransaction(int scheduleId, int customerId, BigDecimal paymentAmount) {
        
        PreparedStatement updateBalanceStmt = null;
        PreparedStatement updateStatusStmt = null;
        PreparedStatement insertTransactionStmt = null;
        boolean autoCommitOriginal = true;

        try {
            // 1. Update customer balance by subtracting the payment amount
            String updateBalanceSql = "UPDATE Customer SET balance = balance - ? WHERE customer_id = ?";
            updateBalanceStmt = connection.prepareStatement(updateBalanceSql);
            updateBalanceStmt.setBigDecimal(1, paymentAmount);
            updateBalanceStmt.setInt(2, customerId);

            int balanceRowsUpdated = updateBalanceStmt.executeUpdate();
            if (balanceRowsUpdated == 0) {
                connection.rollback();
                return false;
            }

            // 2. Update repayment schedule status to PAID
            String updateStatusSql = "UPDATE RepaymentSchedule SET status = 'PAID' WHERE schedule_id = ?";
            updateStatusStmt = connection.prepareStatement(updateStatusSql);
            updateStatusStmt.setInt(1, scheduleId);

            int statusRowsUpdated = updateStatusStmt.executeUpdate();
            if (statusRowsUpdated == 0) {
                connection.rollback();
                return false;
            }

            // 3. Get request_id from RepaymentSchedule
            int requestId = getRequestIdFromSchedule(scheduleId);
            if (requestId <= 0) {
                connection.rollback();
                return false;
            }

            // 4. Insert transaction record
            String insertTransactionSql = "INSERT INTO [dbo].[Transaction] "
                    + "([schedule_id], [request_id], [amount], [transaction_date], [type], [customer_id], [staff_id]) "
                    + "VALUES (?, ?, ?, GETDATE(), 'Repayment', ?, NULL)";

            insertTransactionStmt = connection.prepareStatement(insertTransactionSql);
            insertTransactionStmt.setInt(1, scheduleId);
            insertTransactionStmt.setInt(2, requestId);
            insertTransactionStmt.setBigDecimal(3, paymentAmount);
            insertTransactionStmt.setInt(4, customerId);

            int transactionRowsInserted = insertTransactionStmt.executeUpdate();
            if (transactionRowsInserted == 0) {
                connection.rollback();
                return false;
            }

            // If all operations are successful, commit the transaction
            connection.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Error rolling back transaction: " + rollbackEx.getMessage());
            }
            System.err.println("SQL Error processing payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                // Close resources
                if (updateBalanceStmt != null) {
                    updateBalanceStmt.close();
                }
                if (updateStatusStmt != null) {
                    updateStatusStmt.close();
                }
                if (insertTransactionStmt != null) {
                    insertTransactionStmt.close();
                }

                // Reset auto-commit to original state
                if (connection != null) {
                    connection.setAutoCommit(autoCommitOriginal);
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }

    /**
     * Helper method to get request_id from a repayment schedule
     */
    private int getRequestIdFromSchedule(int scheduleId) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT request_id FROM RepaymentSchedule WHERE schedule_id = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, scheduleId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("request_id");
            }
            return 0;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    public RepaymentSchedule getScheduleById(int scheduleId) {
        RepaymentSchedule schedule = null;
        String sql = "SELECT rs.schedule_id, rs.status, rs.due_date, rs.amount_due, rs.request_id, lr.customer_id "
                + "FROM RepaymentSchedule rs "
                + "LEFT JOIN LoanRequests lr ON lr.request_id = rs.request_id "
                + "WHERE rs.schedule_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                schedule = new RepaymentSchedule();
                schedule.setSchedule_id(rs.getInt("schedule_id"));
                schedule.setStatus(rs.getString("status"));
                schedule.setDueDate(rs.getDate("due_date"));
                schedule.setAmountDue(rs.getBigDecimal("amount_due"));
                schedule.setRequestId(rs.getInt("request_id"));
                schedule.setCustomerId(rs.getInt("customer_id"));
            }
        } catch (Exception e) {
            System.out.println("Error in getScheduleById: " + e.getMessage());
            e.printStackTrace();
        }
        return schedule;
    }

    public List<RepaymentSchedule> getRepaymentSchedulesByCustomerId(int customerId) {
        List<RepaymentSchedule> schedules = new ArrayList<>();
        String sql = "SELECT rs.schedule_id, rs.status, rs.due_date, rs.amount_due, rs.request_id, lr.customer_id "
                + "FROM RepaymentSchedule rs "
                + "LEFT JOIN LoanRequests lr ON lr.request_id = rs.request_id "
                + "WHERE lr.customer_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                RepaymentSchedule schedule = new RepaymentSchedule();
                schedule.setSchedule_id(rs.getInt("schedule_id"));
                schedule.setStatus(rs.getString("status"));
                schedule.setDueDate(rs.getDate("due_date"));
                schedule.setAmountDue(rs.getBigDecimal("amount_due"));
                schedule.setRequestId(rs.getInt("request_id"));
                schedule.setCustomerId(rs.getInt("customer_id"));  // Uncomment this line
                schedules.add(schedule);
            }
        } catch (Exception e) {
            System.out.println("Error in getRepaymentSchedulesByCustomerId: " + e.getMessage());
            e.printStackTrace();
        }
        return schedules;
    }

    public boolean updateStatus(int scheduleId, String status) {
        String sql = "UPDATE RepaymentSchedule SET status = ? WHERE schedule_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, scheduleId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error in updateStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void insert(RepaymentSchedule model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(RepaymentSchedule model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(RepaymentSchedule model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<RepaymentSchedule> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public RepaymentSchedule get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
