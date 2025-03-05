package context;

import context.DBContext;
import model.LoanRequest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoanRequestDAO extends DBContext<LoanRequest> {

    @Override
    public void insert(LoanRequest request) {
        String sql = "INSERT INTO LoanRequests (loan_id, staff_id, customer_id, approval_status, collateral_image) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, request.getLoanId());
            stmt.setInt(2, request.getStaffId());
            stmt.setInt(3, request.getCustomerId());
            stmt.setString(4, "Pending"); // Mặc định trạng thái chờ duyệt
            stmt.setString(5, request.getCollateralImage());

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
        ArrayList<LoanRequest> loanRequests = new ArrayList<>();
        String sql = "SELECT lr.request_id, c.fullname AS customer_name, l.amount, lr.approval_date, "
                + "lr.approval_status, lr.approved_by, lr.collateral_image, s.fullname AS staff_name "
                + "FROM LoanRequests lr "
                + "JOIN Loans l ON lr.loan_id = l.loan_id "
                + "JOIN LoanPackages lp ON lp.package_id = l.package_id "
                + "JOIN Customer c ON c.customer_id = l.customer_id "
                + "JOIN CustomerAssets ca ON ca.customer_id = c.customer_id "
                + "JOIN Staff s ON s.staff_id = ca.staff_id";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                LoanRequest loanRequest = new LoanRequest();
                loanRequest.setRequestId(rs.getInt("request_id"));
                loanRequest.setCustomerName(rs.getString("customer_name"));
                loanRequest.setLoanAmount(rs.getDouble("amount"));
                loanRequest.setApprovalDate(rs.getDate("approval_date"));
                loanRequest.setApprovalStatus(rs.getString("approval_status"));
                loanRequest.setApprovedBy(rs.getString("approved_by"));
                loanRequest.setCollateralImage(rs.getString("collateral_image"));
                loanRequest.setStaffName(rs.getString("staff_name"));

                loanRequests.add(loanRequest);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanRequests;
    }

    @Override
    public LoanRequest get(int id) {
        String sql = "SELECT lr.*, c.customer_name, lp.loan_amount, s.staff_name FROM LoanRequests lr "
                + "JOIN Customers c ON lr.customer_id = c.customer_id "
                + "JOIN LoanPackages lp ON lr.loan_id = lp.package_id "
                + "JOIN Staff s ON lr.staff_id = s.staff_id "
                + "WHERE lr.request_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                LoanRequest request = new LoanRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setLoanId(rs.getInt("loan_id"));
                request.setStaffId(rs.getInt("staff_id"));
                request.setCustomerId(rs.getInt("customer_id"));
                request.setApprovalStatus(rs.getString("approval_status"));
                request.setApprovalDate(rs.getTimestamp("approval_date"));
                request.setApprovedBy(rs.getString("approved_by"));
                request.setCollateralImage(rs.getString("collateral_image"));
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
