/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.util.ArrayList;
import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Saving;

public class LoanSavingDAO extends DBContext {

    public List<Saving> getSavingsList() {
        List<Saving> savingsList = new ArrayList<>();
        String query = "SELECT \n"
                + "    s.savings_id,\n"
                + "    c.customer_id,\n"
                + "    c.fullname,\n"
                + "    c.phonenumber,\n"
                + "    s.amount,\n"
                + "    s.interest_rate,\n"
                + "    s.term_months,\n"
                + "    s.opened_date,\n"
                + "    s.status\n"
                + "FROM Saving s\n"
                + "JOIN Customer c ON s.customer_id = c.customer_id\n"
                + "WHERE s.status = 'active'; ";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Saving saving = new Saving(
                            rs.getInt(1),
                            rs.getInt(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getDouble(5),
                            rs.getDouble(6),
                            rs.getInt(7),
                            rs.getString(8),
                            rs.getString(9)
                    );
                    savingsList.add(saving);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savingsList;
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
    public ArrayList list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
