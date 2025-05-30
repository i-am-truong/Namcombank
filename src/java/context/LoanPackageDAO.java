/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.LoanPackage;

/**
 *
 * @author lenovo
 */
public class LoanPackageDAO extends DBContext {

    public List<LoanPackage> getAllLoanPackageByStaffId(int staffId) {
        List<LoanPackage> loanPackages = new ArrayList<>();
        String query = "SELECT * FROM LoanPackages WHERE staff_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LoanPackage loanPackage = new LoanPackage(
                            rs.getInt("package_id"),
                            rs.getInt("staff_id"),
                            rs.getString("package_name"),
                            rs.getString("loan_type"),
                            rs.getString("description"),
                            rs.getBigDecimal("interest_rate"),
                            rs.getBigDecimal("max_amount"),
                            rs.getBigDecimal("min_amount"),
                            rs.getInt("loan_term"),
                            rs.getDate("created_date")
                    );
                    loanPackages.add(loanPackage);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log lỗi
        }

        return loanPackages;
    }

    public boolean updateLoanPackage(LoanPackage loanPackage) {
        String query = "UPDATE LoanPackages SET package_name = ?, loan_type = ?, description = ?, interest_rate = ?, max_amount = ?, min_amount = ?, loan_term = ? WHERE package_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, loanPackage.getPackageName());
            ps.setString(2, loanPackage.getLoanType());
            ps.setString(3, loanPackage.getDescription());
            ps.setBigDecimal(4, loanPackage.getInterestRate());
            ps.setBigDecimal(5, loanPackage.getMaxAmount());
            ps.setBigDecimal(6, loanPackage.getMinAmount());
            ps.setInt(7, loanPackage.getLoanTerm());
            ps.setInt(8, loanPackage.getPackageId());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public LoanPackage getLoanPackageById(int packageId) {
        String query = "SELECT * FROM LoanPackages WHERE package_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new LoanPackage(
                            rs.getInt("package_id"),
                            rs.getInt("staff_id"),
                            rs.getString("package_name"),
                            rs.getString("loan_type"),
                            rs.getString("description"),
                            rs.getBigDecimal("interest_rate"),
                            rs.getBigDecimal("max_amount"),
                            rs.getBigDecimal("min_amount"),
                            rs.getInt("loan_term"),
                            rs.getDate("created_date")
                    );
                }
            }
        } catch (SQLException e) {
            // Log the exception or handle it as needed
            e.printStackTrace();
        }
        return null;
    }

//    public void updateLoanPackage(LoanPackage loanPackage) {
//        String sql_update = "UPDATE [LoanPackages]\n"
//                + "   SET [package_name] = ?,\n"
//                + "       [loan_type] = ?,\n"
//                + "       [description] = ?,\n"
//                + "       [interest_rate] = ?,\n"
//                + "       [max_amount] = ?,\n"
//                + "       [min_amount] = ?,\n"
//                + "       [loan_term] = ?\n"
//                + " WHERE package_id = ?";
//        PreparedStatement stm_update = null;
//        try {
//            stm_update = connection.prepareStatement(sql_update);
//            stm_update.setString(1, loanPackage.getPackageName());
//            stm_update.setString(2, loanPackage.getLoanType());
//            stm_update.setString(3, loanPackage.getDescription());
//            stm_update.setDouble(4, loanPackage.getInterestRate());
//            stm_update.setDouble(5, loanPackage.getMaxAmount());
//            stm_update.setDouble(6, loanPackage.getMinAmount());
//            stm_update.setInt(7, loanPackage.getLoanTerm());
//            stm_update.setInt(8, loanPackage.getPackageId());
//            stm_update.executeUpdate();
//            
//        } catch (SQLException ex) {
//            Logger.getLogger(LoanPackage.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            // Close the prepared statement and database connection
//            if (stm_update != null) {
//                try {
//                    stm_update.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(LoanPackageDAO.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(LoanPackageDAO.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        }
//}
    public void deleteLoanPackage(int packageId) {
        String sql_update = "DELETE FROM LoanPackages\n"
                + " WHERE package_id = ?";
        PreparedStatement stm_update = null;
        try {
            stm_update = connection.prepareStatement(sql_update);
            stm_update.setInt(1, packageId);
            stm_update.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(LoanPackageDAO.class
                    .getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(LoanPackageDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    public List<LoanPackage> getAllLoanPackages() {
        List<LoanPackage> loanPackages = new ArrayList<>();
        String query = "SELECT * FROM LoanPackages";

        try (PreparedStatement pstmt = connection.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                LoanPackage loanPackage = new LoanPackage(
                        rs.getInt("package_id"),
                        rs.getInt("staff_id"),
                        rs.getString("package_name"),
                        rs.getString("loan_type"),
                        rs.getString("description"),
                        rs.getBigDecimal("interest_rate"),
                        rs.getBigDecimal("max_amount"),
                        rs.getBigDecimal("min_amount"),
                        rs.getInt("loan_term"),
                        rs.getDate("created_date")
                );
                loanPackages.add(loanPackage);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanPackages;
    }

    public boolean insertLoanPackage(LoanPackage loanPackage) {
        String query = "INSERT INTO LoanPackages (staff_id, package_name, loan_type, description, interest_rate, max_amount, min_amount, loan_term, created_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, loanPackage.getStaffId());
            pstmt.setString(2, loanPackage.getPackageName());
            pstmt.setString(3, loanPackage.getLoanType());
            pstmt.setString(4, loanPackage.getDescription());
            pstmt.setBigDecimal(5, loanPackage.getInterestRate());
            pstmt.setBigDecimal(6, loanPackage.getMaxAmount());
            pstmt.setBigDecimal(7, loanPackage.getMinAmount());
            pstmt.setInt(8, loanPackage.getLoanTerm());
            pstmt.setDate(9, new java.sql.Date(loanPackage.getCreatedDate().getTime()));

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Nếu insert thành công, trả về true

        } catch (SQLException e) {
            Logger.getLogger(LoanPackageDAO.class.getName()).log(Level.SEVERE, "Error inserting loan package", e);
            return false; // Insert thất bại
        }
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
