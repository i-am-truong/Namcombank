package context;

import context.DBContext;
import model.LoanRequest;
import java.sql.*;
import java.util.ArrayList;

public class LoanRequestDAO extends DBContext<LoanRequest> {

    @Override
    public void insert(LoanRequest loan) {
        String sql = "INSERT INTO LoanRequests (customer_id, package_id, amount, request_date, status) VALUES (?, ?, ?, GETDATE(), 'pending')";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, loan.getCustomerId());
            ps.setInt(2, loan.getPackageId());
            ps.setDouble(3, loan.getAmount());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(LoanRequest loan) {
        String sql = "UPDATE LoanRequests SET amount = ?, status = ? WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, loan.getAmount());
            ps.setString(2, loan.getStatus());
            ps.setInt(3, loan.getRequestId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(LoanRequest loan) {
        String sql = "DELETE FROM LoanRequests WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, loan.getRequestId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateAmount(int requestId, double newAmount) {
        String sql = "UPDATE LoanRequests SET amount = ? WHERE request_id = ? AND status = 'pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, newAmount);
            ps.setInt(2, requestId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void cancelRequest(int requestId) {
        String sql = "DELETE FROM LoanRequests WHERE request_id = ? AND status = 'pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<LoanRequest> list() {
        ArrayList<LoanRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM LoanRequests";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LoanRequest loan = new LoanRequest();
                loan.setRequestId(rs.getInt("request_id"));
                loan.setCustomerId(rs.getInt("customer_id"));
                loan.setPackageId(rs.getInt("package_id"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setRequestDate(rs.getDate("request_date"));
                loan.setStatus(rs.getString("status"));
                list.add(loan);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public LoanRequest get(int id) {
        String sql = "SELECT * FROM LoanRequests WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LoanRequest loan = new LoanRequest();
                loan.setRequestId(rs.getInt("request_id"));
                loan.setCustomerId(rs.getInt("customer_id"));
                loan.setPackageId(rs.getInt("package_id"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setRequestDate(rs.getDate("request_date"));
                loan.setStatus(rs.getString("status"));
                return loan;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
