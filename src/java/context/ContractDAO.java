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
        String sql = "INSERT INTO contracts (customer_name, type, amount, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, contract.getCustomerName());
            stmt.setString(2, contract.getType());
            stmt.setDouble(3, contract.getAmount());
            stmt.setString(4, contract.getStatus());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Contract contract) {
        String sql = "UPDATE contracts SET customer_name = ?, type = ?, amount = ?, status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, contract.getCustomerName());
            stmt.setString(2, contract.getType());
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
        String sql = "DELETE FROM contracts WHERE id = ?";
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
        String sql = "SELECT * FROM contracts";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                contracts.add(new Contract(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("type"),
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
        String sql = "SELECT * FROM contracts WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Contract(
                            rs.getInt("id"),
                            rs.getString("customer_name"),
                            rs.getString("type"),
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

}
