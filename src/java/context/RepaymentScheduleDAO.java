/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.util.ArrayList;
import model.RepaymentSchedule;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

public class RepaymentScheduleDAO extends DBContext<RepaymentSchedule> {

    public List<RepaymentSchedule> getAllRepaymentSchedules() {
        List<RepaymentSchedule> schedules = new ArrayList<>();
        String query = "SELECT rs.schedule_id, lp.package_name, rs.status, rs.due_date, rs.amount_due, \n"
                + "       c.customer_id, c.fullname, c.email, c.phonenumber\n"
                + "FROM RepaymentSchedule rs\n"
                + "JOIN Loans l ON rs.loan_id = l.loan_id\n"
                + "JOIN LoanPackages lp ON lp.package_id = l.package_id\n"
                + "JOIN Customer c ON l.customer_id = c.customer_id;";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9)
                );

                RepaymentSchedule schedule = new RepaymentSchedule(
                        rs.getInt(1),
                        rs.getInt(1),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getFloat(5),
                        customer,
                        rs.getString(2)
                );
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi nếu cần
        }
        return schedules;
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
