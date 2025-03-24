/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package context;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Transaction;
import model.Customer;
import model.RepaymentSchedule;
import model.auth.Staff;
import model.Transaction;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Asus
 */

public class TransactionDAO extends DBContext<Transaction> {

    @Override
    public void insert(Transaction model) {
        try {
            String sql = "INSERT INTO [Transaction] (schedule_id, request_id, amount, " +
                        "transaction_date, type, customer_id, staff_id) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setObject(1, model.getScheduleId(), Types.INTEGER);
            statement.setObject(2, model.getRequestId(), Types.INTEGER);
            statement.setBigDecimal(3, model.getAmount());
            statement.setTimestamp(4, new Timestamp(model.getTransactionDate().getTime()));
            statement.setString(5, model.getType());
            statement.setObject(6, model.getCustomerId(), Types.INTEGER);
            statement.setObject(7, model.getStaffId(), Types.INTEGER);
            
            statement.executeUpdate();
            
            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                model.setTransactionId(generatedKeys.getInt(1));
            }
            
            generatedKeys.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Transaction model) {
        try {
            String sql = "UPDATE [Transaction] SET schedule_id = ?, request_id = ?, " +
                        "amount = ?, transaction_date = ?, type = ?, customer_id = ?, " +
                        "staff_id = ? WHERE transaction_id = ?";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            
            statement.setObject(1, model.getScheduleId(), Types.INTEGER);
            statement.setObject(2, model.getRequestId(), Types.INTEGER);
            statement.setBigDecimal(3, model.getAmount());
            statement.setTimestamp(4, new Timestamp(model.getTransactionDate().getTime()));
            statement.setString(5, model.getType());
            statement.setObject(6, model.getCustomerId(), Types.INTEGER);
            statement.setObject(7, model.getStaffId(), Types.INTEGER);
            statement.setInt(8, model.getTransactionId());
            
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Transaction model) {
        try {
            String sql = "DELETE FROM [Transaction] WHERE transaction_id = ?";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, model.getTransactionId());
            
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Transaction> list() {
        ArrayList<Transaction> transactions = new ArrayList<>();
        
        try {
            String sql = "SELECT t.transaction_id, t.schedule_id, t.request_id, t.amount, " +
                        "t.transaction_date, t.type, t.customer_id, t.staff_id, " +
                        "rs.due_date, c.fullname, c.citizen_identification_card, c.phonenumber, " +
                        "s.fullname as staff_fullname " +
                        "FROM [Transaction] t " +
                        "LEFT JOIN RepaymentSchedule rs ON rs.schedule_id = t.schedule_id " +
                        "LEFT JOIN Customer c ON c.customer_id = t.customer_id " +
                        "LEFT JOIN Staff s ON s.staff_id = t.staff_id " +
                        "ORDER BY t.transaction_date DESC";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Transaction transaction = mapResultSetToTransaction(resultSet);
                transactions.add(transaction);
            }
            
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transactions;
    }

    @Override
    public Transaction get(int id) {
        Transaction transaction = null;
        
        try {
            String sql = "SELECT t.transaction_id, t.schedule_id, t.request_id, t.amount, " +
                        "t.transaction_date, t.type, t.customer_id, t.staff_id, " +
                        "rs.due_date, c.fullname, c.citizen_identification_card, c.phonenumber, " +
                        "s.fullname as staff_fullname " +
                        "FROM [Transaction] t " +
                        "LEFT JOIN RepaymentSchedule rs ON rs.schedule_id = t.schedule_id " +
                        "LEFT JOIN Customer c ON c.customer_id = t.customer_id " +
                        "LEFT JOIN Staff s ON s.staff_id = t.staff_id " +
                        "WHERE t.transaction_id = ?";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                transaction = mapResultSetToTransaction(resultSet);
            }
            
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transaction;
    }
    
    /**
     * Search transactions with various filters
     */
    public ArrayList<Transaction> search(Integer customerId, String type, 
                                      Date startDate, Date endDate, 
                                      BigDecimal minAmount, BigDecimal maxAmount) {
        ArrayList<Transaction> transactions = new ArrayList<>();
        
        try {
            StringBuilder sqlBuilder = new StringBuilder(
                "SELECT t.transaction_id, t.schedule_id, t.request_id, t.amount, " +
                "t.transaction_date, t.type, t.customer_id, t.staff_id, " +
                "rs.due_date, c.fullname, c.citizen_identification_card, c.phonenumber, " +
                "s.fullname as staff_fullname " +
                "FROM [Transaction] t " +
                "LEFT JOIN RepaymentSchedule rs ON rs.schedule_id = t.schedule_id " +
                "LEFT JOIN Customer c ON c.customer_id = t.customer_id " +
                "LEFT JOIN Staff s ON s.staff_id = t.staff_id " +
                "WHERE 1=1"
            );
            
            ArrayList<Object> params = new ArrayList<>();
            
            if (customerId != null) {
                sqlBuilder.append(" AND t.customer_id = ?");
                params.add(customerId);
            }
            
            if (type != null && !type.isEmpty()) {
                sqlBuilder.append(" AND t.type = ?");
                params.add(type);
            }
            
            if (startDate != null) {
                sqlBuilder.append(" AND t.transaction_date >= ?");
                params.add(new java.sql.Date(startDate.getTime()));
            }
            
            if (endDate != null) {
                sqlBuilder.append(" AND t.transaction_date <= ?");
                params.add(new java.sql.Date(endDate.getTime()));
            }
            
            if (minAmount != null) {
                sqlBuilder.append(" AND t.amount >= ?");
                params.add(minAmount);
            }
            
            if (maxAmount != null) {
                sqlBuilder.append(" AND t.amount <= ?");
                params.add(maxAmount);
            }
            
            sqlBuilder.append(" ORDER BY t.transaction_date DESC");
            
            PreparedStatement statement = connection.prepareStatement(sqlBuilder.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Transaction transaction = mapResultSetToTransaction(resultSet);
                transactions.add(transaction);
            }
            
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transactions;
    }
    
    /**
     * Get transactions by customer ID
     */
    public ArrayList<Transaction> getByCustomerId(int customerId) {
        return search(customerId, null, null, null, null, null);
    }
    
    /**
     * Get transactions by repayment schedule ID
     */
    public ArrayList<Transaction> getByScheduleId(int scheduleId) {
        ArrayList<Transaction> transactions = new ArrayList<>();
        
        try {
            String sql = "SELECT t.transaction_id, t.schedule_id, t.request_id, t.amount, " +
                        "t.transaction_date, t.type, t.customer_id, t.staff_id, " +
                        "rs.due_date, c.fullname, c.citizen_identification_card, c.phonenumber, " +
                        "s.fullname as staff_fullname " +
                        "FROM [Transaction] t " +
                        "LEFT JOIN RepaymentSchedule rs ON rs.schedule_id = t.schedule_id " +
                        "LEFT JOIN Customer c ON c.customer_id = t.customer_id " +
                        "LEFT JOIN Staff s ON s.staff_id = t.staff_id " +
                        "WHERE t.schedule_id = ? " +
                        "ORDER BY t.transaction_date DESC";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, scheduleId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Transaction transaction = mapResultSetToTransaction(resultSet);
                transactions.add(transaction);
            }
            
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transactions;
    }
    
    /**
     * Get transactions by loan request ID
     */
    public ArrayList<Transaction> getByRequestId(int requestId) {
        ArrayList<Transaction> transactions = new ArrayList<>();
        
        try {
            String sql = "SELECT t.transaction_id, t.schedule_id, t.request_id, t.amount, " +
                        "t.transaction_date, t.type, t.customer_id, t.staff_id, " +
                        "rs.due_date, c.fullname, c.citizen_identification_card, c.phonenumber, " +
                        "s.fullname as staff_fullname " +
                        "FROM [Transaction] t " +
                        "LEFT JOIN RepaymentSchedule rs ON rs.schedule_id = t.schedule_id " +
                        "LEFT JOIN Customer c ON c.customer_id = t.customer_id " +
                        "LEFT JOIN Staff s ON s.staff_id = t.staff_id " +
                        "WHERE t.request_id = ? " +
                        "ORDER BY t.transaction_date DESC";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, requestId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Transaction transaction = mapResultSetToTransaction(resultSet);
                transactions.add(transaction);
            }
            
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transactions;
    }
    
    /**
     * Helper method to map ResultSet to Transaction object with related entities
     */
    private Transaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        
        transaction.setTransactionId(rs.getInt("transaction_id"));
        transaction.setScheduleId(rs.getObject("schedule_id") != null ? rs.getInt("schedule_id") : null);
        transaction.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
        transaction.setAmount(rs.getBigDecimal("amount"));
        transaction.setTransactionDate(rs.getTimestamp("transaction_date"));
        transaction.setType(rs.getString("type"));
        transaction.setCustomerId(rs.getObject("customer_id") != null ? rs.getInt("customer_id") : null);
        transaction.setStaffId(rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null);
        
        // Map Customer
        if (rs.getObject("customer_id") != null) {
            Customer customer = new Customer();
            customer.setCustomerId(rs.getInt("customer_id"));
            customer.setFullname(rs.getString("fullname"));
            customer.setCid(rs.getString("citizen_identification_card"));
            customer.setPhonenumber(rs.getString("phonenumber"));
            
            transaction.setCustomer(customer);
        }
        
        // Map Staff
        if (rs.getObject("staff_id") != null) {
            Staff staff = new Staff();
            staff.setId(rs.getInt("staff_id"));
            staff.setFullname(rs.getString("staff_fullname"));
            
            transaction.setStaff(staff);
        }
        
        // Map RepaymentSchedule
        if (rs.getObject("schedule_id") != null) {
            RepaymentSchedule repaymentSchedule = new RepaymentSchedule();
            repaymentSchedule.setSchedule_id(rs.getInt("schedule_id"));
            repaymentSchedule.setDueDate(rs.getDate("due_date"));
            
            transaction.setRepaymentSchedule(repaymentSchedule);
        }
        
        return transaction;
    }
}
