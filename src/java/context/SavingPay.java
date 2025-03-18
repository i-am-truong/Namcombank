/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import jakarta.servlet.annotation.WebListener;
/**
 *
 * @author admin
 */
@WebListener
public class SavingPay extends DBContext<Object> implements ServletContextListener {

    public void autoPayMoney() {
        String updateBalanceQuery = """
                    UPDATE c
                    SET c.balance = c.balance + s.total_amount
                    FROM Customer c
                    JOIN (
                        SELECT customer_id, SUM(amount) AS total_amount
                        FROM Saving
                        WHERE money_get_date <= GETDATE()
                        AND status = 'Active'
                        AND payment_method = 'TRANSFER'
                        AND saving_withdrawable = 1
                        AND money_getted IS NULL
                        GROUP BY customer_id
                    ) s ON c.customer_id = s.customer_id;
                """;
        String updateSavingQuery = """
                    UPDATE Saving
                    SET money_getted = amount, status = 'Received'
                    WHERE money_get_date <= GETDATE()
                    AND status = 'Active'
                    AND payment_method = 'TRANSFER'
                    AND saving_withdrawable = 1
                    AND money_getted IS NULL;
                """;

        try (PreparedStatement ps1 = connection.prepareStatement(updateBalanceQuery); PreparedStatement ps2 = connection.prepareStatement(updateSavingQuery)) {

            int rowsUpdated = ps1.executeUpdate();
            if (rowsUpdated > 0) {
                ps2.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🔄 Auto payment process started...");
        autoPayMoney();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Không cần xử lý gì khi Tomcat tắt
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
