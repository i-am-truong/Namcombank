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
