/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.SavingPackage;

/**
 *
 * @author admin
 */
public class TranferDao extends DBContext<Object> {

    public boolean tranferCreate(int customer_id, int customer_id_received, String transfer_content, String transfer_date, Double transfer_amount, String phone, String phone_received, String name, String name_received) {
        String query = "INSERT INTO [Transfer]([transfer_date],[transfer_content],[customer_id],[customer_id_received],[transfer_amount],[phone],[phone_received],[name],[name_received]) VALUES( ? , ? , ? , ? , ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            ps.setString(1, transfer_date);
            ps.setString(2, transfer_content);
            ps.setInt(3, customer_id);
            ps.setInt(4, customer_id_received);
            ps.setDouble(5, transfer_amount);
            ps.setString(6, phone);
            ps.setString(7, phone_received);
            ps.setString(8, name);
            ps.setString(9, name_received);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Double getBalace(int customer_id) {
        String query = "select balance from Customer where customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            ps.setInt(1, customer_id);

            int rowsAffected = ps.executeUpdate();
            return rs.getDouble("balance");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkBalance(Double balance, Double money) {
        if (balance > money && balance - money >= 5000) {
            return true;
        } else {
            return false;
        }
    }

    public String getCustomer_name_received(String phone_received) {
        String query = "select fullname from Customer where phonenumber = ?";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            ps.setString(1, phone_received);

            int rowsAffected = ps.executeUpdate();
            return rs.getString("fullname");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getCustomer_id_received(String phone_received) {
        int customer_id;
        String query = "select customer_id from Customer where phonenumber = ?";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            ps.setString(1, phone_received);

            ps.executeUpdate();
            return customer_id = rs.getInt("customer_id");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public void insert(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Object> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
