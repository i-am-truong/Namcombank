package dao;

import context.DBContext;
import model.LoanRequest;
import java.sql.*;
import java.util.ArrayList;

public class LoanRequestDAO extends DBContext<LoanRequest> {

    @Override
    public void insert(LoanRequest request) {
        String sql = "INSERT INTO LoanRequests (loan_id, staff_id, approval_status) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, request.getLoanId());
            stmt.setInt(2, request.getStaffId());
            stmt.setString(3, "Pending");
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(LoanRequest request) {
        String sql = "UPDATE LoanRequests SET approval_status = ?, approval_date = ?, approved_by = ? WHERE request_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, request.getApprovalStatus());
            stmt.setTimestamp(2, request.getApprovalDate() != null ? new Timestamp(request.getApprovalDate().getTime()) : null);
            stmt.setString(3, request.getApprovedBy());
            stmt.setInt(4, request.getRequestId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(LoanRequest request) {
        String sql = "DELETE FROM LoanRequests WHERE request_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, request.getRequestId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<LoanRequest> list() {
        ArrayList<LoanRequest> requests = new ArrayList<>();
        String sql = """
                SELECT 
                    lr.request_id, 
                    lr.loan_id, 
                    lr.staff_id, 
                    lr.approval_status, 
                    lr.approval_date, 
                    lr.approved_by, 
                    c.customer_id, 
                    c.fullname AS customer_name, 
                    l.amount AS loan_amount,
                    s.fullname AS staff_name
                FROM 
                    LoanRequests lr
                JOIN 
                    Loans l ON lr.loan_id = l.loan_id
                JOIN 
                    Customer c ON l.customer_id = c.customer_id
                JOIN 
                    Staff s ON lr.staff_id = s.staff_id
                WHERE 1 = 1;         
            """;

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                LoanRequest request = new LoanRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setLoanId(rs.getInt("loan_id"));
                request.setStaffId(rs.getInt("staff_id"));
                request.setApprovalStatus(rs.getString("approval_status"));

                // Xử lý giá trị NULL cho approval_date
                request.setApprovalDate(rs.getTimestamp("approval_date") != null ? rs.getTimestamp("approval_date") : null);

                request.setApprovedBy(rs.getString("approved_by"));
                request.setCustomerId(rs.getInt("customer_id"));
                request.setCustomerName(rs.getString("customer_name"));

                // Xử lý giá trị NULL cho loan_amount
                double loanAmount = rs.getDouble("loan_amount");
                request.setLoanAmount(!rs.wasNull() ? loanAmount : 0.0);

                request.setStaffName(rs.getString("staff_name"));
                requests.add(request);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving loan requests: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    @Override
    public LoanRequest get(int id) {
        String sql = """
                SELECT 
                    lr.request_id, 
                    lr.loan_id, 
                    lr.staff_id, 
                    lr.approval_status, 
                    lr.approval_date, 
                    lr.approved_by, 
                    c.customer_id, 
                    c.fullname AS customer_name, 
                    l.amount AS loan_amount,
                    s.fullname AS staff_name
                FROM 
                    LoanRequests lr
                JOIN 
                    Loans l ON lr.loan_id = l.loan_id
                JOIN 
                    Customer c ON l.customer_id = c.customer_id
                JOIN 
                    Staff s ON lr.staff_id = s.staff_id
                WHERE lr.request_id = ?
            """;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                LoanRequest request = new LoanRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setLoanId(rs.getInt("loan_id"));
                request.setStaffId(rs.getInt("staff_id"));
                request.setApprovalStatus(rs.getString("approval_status"));
                request.setApprovalDate(rs.getTimestamp("approval_date"));
                request.setApprovedBy(rs.getString("approved_by"));
                request.setCustomerId(rs.getInt("customer_id"));
                request.setCustomerName(rs.getString("customer_name"));
                request.setLoanAmount(rs.getDouble("loan_amount"));
                request.setStaffName(rs.getString("staff_name"));
                return request;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
