/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.util.ArrayList;
import model.Contract;
import java.sql.*;
import java.util.List;

/**
 *
 * @author lenovo
 */
public class ContractDAO extends DBContext<Contract> {

    @Override
    public void insert(Contract contract) {
        String sql = "INSERT INTO Contracts (customer_id, loan_id, amount, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, contract.getCustomerName()); 
            stmt.setString(2, contract.getLoanName()); 
            stmt.setDouble(3, contract.getAmount());
            stmt.setString(4, contract.getStatus());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Contract contract) {
        String sql = "UPDATE Contracts SET customer_id = ?, loan_id = ?, amount = ?, status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, contract.getCustomerName());
            stmt.setString(2, contract.getLoanName());
            stmt.setDouble(3, contract.getAmount());
            stmt.setString(4, contract.getStatus());
            stmt.setInt(5, contract.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Contract contract) {
        String sql = "DELETE FROM Contracts WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, contract.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Contract> list() {
        ArrayList<Contract> contracts = new ArrayList<>();
        String sql = """
        SELECT c.id, cu.name AS customer_name, l.loan_name, lp.package_name, c.amount, c.status
        FROM Contracts c
        JOIN Customers cu ON c.customer_id = cu.id
        JOIN Loans l ON c.loan_id = l.id
        JOIN LoanPackages lp ON l.package_id = lp.id""";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                contracts.add(new Contract(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("loan_name"),
                        rs.getString("package_name"),
                        rs.getDouble("amount"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contracts;
    }

    @Override
    public Contract get(int id) {
        String sql = """
        SELECT c.id, cu.name AS customer_name, l.loan_name, lp.package_name, c.amount, c.status
        FROM Contracts c
        JOIN Customers cu ON c.customer_id = cu.id
        JOIN Loans l ON c.loan_id = l.id
        JOIN LoanPackages lp ON l.package_id = lp.id
        WHERE c.id = ?""";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Contract(
                            rs.getInt("id"),
                            rs.getString("customer_name"),
                            rs.getString("loan_name"),
                            rs.getString("package_name"),
                            rs.getDouble("amount"),
                            rs.getString("status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Contract> getContractsByStatus(String status) {
        List<Contract> contracts = new ArrayList<>();
        String sql = """
        SELECT c.id, cu.name AS customer_name, l.loan_name, lp.package_name, c.amount, c.status
        FROM Contracts c
        JOIN Customers cu ON c.customer_id = cu.id
        JOIN Loans l ON c.loan_id = l.id
        JOIN LoanPackages lp ON l.package_id = lp.id
        WHERE c.status = ?""";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                contracts.add(new Contract(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("loan_name"),
                        rs.getString("package_name"),
                        rs.getDouble("amount"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contracts;
    }

    public List<Contract> filterContracts(String status, String search, String sort) {
        List<Contract> contracts = new ArrayList<>();
        String sql = """
        SELECT c.id, cu.name AS customer_name, l.loan_name, lp.package_name, c.amount, c.status
        FROM Contracts c
        JOIN Customers cu ON c.customer_id = cu.id
        JOIN Loans l ON c.loan_id = l.id
        JOIN LoanPackages lp ON l.package_id = lp.id
        WHERE 1=1""";

        if (status != null && !status.equals("all")) {
            sql += " AND c.status = ?";
        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND cu.name LIKE ?";
        }
        sql += " ORDER BY c.amount " + ("desc".equals(sort) ? "DESC" : "ASC");

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int index = 1;
            if (status != null && !status.equals("all")) {
                stmt.setString(index++, status);
            }
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(index++, "%" + search + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                contracts.add(new Contract(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("loan_name"),
                        rs.getString("package_name"),
                        rs.getDouble("amount"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contracts;
    }
}
