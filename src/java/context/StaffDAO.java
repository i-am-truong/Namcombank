/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Department;
import model.LoanPackage;
import model.auth.Staff;

/**
 *
 * @author Asus
 */
public class StaffDAO extends DBContext<Staff> {

    public ArrayList<Staff> search(Integer sid, String name, Boolean gender, String dob,
            String address, Integer did, String phonenumber, String email, String citizenID) {
        String sql = "SELECT s.staff_id, d.department_id, d.department_name, s.fullname, s.email, s.dob, "
                + "s.gender, s.phonenumber, s.citizen_identification_card, s.address "
                + "FROM [dbo].[Staff] s "
                + "INNER JOIN Department d ON s.department_id = d.department_id "
                + "WHERE 1=1";

        ArrayList<Staff> staffs = new ArrayList<>();
        ArrayList<Object> paramValues = new ArrayList<>();

        // Điều kiện tìm kiếm theo Staff ID
        if (sid != null) {
            sql += " AND s.staff_id = ?";
            paramValues.add(sid);
        }

        // Điều kiện tìm kiếm theo mã phòng ban
        if (did != null) {
            sql += " AND d.department_id = ?";
            paramValues.add(did);
        }

        // Điều kiện tìm kiếm theo tên (LIKE)
        if (name != null && !name.trim().isEmpty()) {
            sql += " AND s.fullname LIKE ?";
            paramValues.add("%" + name + "%");
        }

        // Điều kiện tìm kiếm theo địa chỉ (LIKE)
        if (address != null && !address.trim().isEmpty()) {
            sql += " AND s.address LIKE ?";
            paramValues.add("%" + address + "%");
        }

        // Điều kiện tìm kiếm theo số điện thoại
        if (phonenumber != null && !phonenumber.trim().isEmpty()) {
            sql += " AND s.phonenumber LIKE ?";
            paramValues.add("%" + phonenumber + "%");
        }

        // Điều kiện tìm kiếm theo email (LIKE)
        if (email != null && !email.trim().isEmpty()) {
            sql += " AND s.email LIKE ?";
            paramValues.add("%" + email + "%");
        }

        // Điều kiện tìm kiếm theo CMND/CCCD (LIKE)
        if (citizenID != null && !citizenID.trim().isEmpty()) {
            sql += " AND s.citizen_identification_card LIKE ?";
            paramValues.add("%" + citizenID + "%");
        }

        // Điều kiện tìm kiếm theo ngày sinh (tìm theo chuỗi chứa số bất kỳ)
        if (dob != null) {
            sql += " AND CONVERT(VARCHAR, s.dob, 23) LIKE ?";
            paramValues.add("%" + dob + "%");
        }

        PreparedStatement stm = null;

        try {
            // Chuẩn bị câu truy vấn với tham số
            stm = connection.prepareStatement(sql);
            for (int i = 0; i < paramValues.size(); i++) {
                stm.setObject((i + 1), paramValues.get(i));
            }

            // Thực thi truy vấn
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Staff s = new Staff();
                s.setId(rs.getInt("staff_id"));
                s.setFullname(rs.getNString("fullname"));
                s.setEmail(rs.getString("email"));
                s.setGender(rs.getBoolean("gender"));
                s.setDob(rs.getDate("dob"));
                s.setAddress(rs.getNString("address"));
                s.setPhonenumber(rs.getString("phonenumber"));
                s.setCitizenId(rs.getString("citizen_identification_card"));
                Department d = new Department();
                d.setId(rs.getInt("department_id"));
                d.setName(rs.getNString("department_name"));

                s.setDept(d);
                staffs.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return staffs;
    }

    @Override
    public void insert(Staff model) {
        try {
            connection.setAutoCommit(false);
            String sql_insert = "INSERT INTO [dbo].[Staff]\n"
                    + "           ([department_id]\n"
                    + "           ,[fullname]\n"
                    + "           ,[username]\n"
                    + "           ,[password]\n"
                    + "           ,[email]\n"
                    + "           ,[dob]\n"
                    + "           ,[gender]\n"
                    + "           ,[phonenumber]\n"
                    + "           ,[citizen_identification_card]\n"
                    + "           ,[address])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";

            String sql_getsid = "SELECT @@IDENTITY as staff_id";

            PreparedStatement stm_insert = connection.prepareCall(sql_insert);

            stm_insert = connection.prepareStatement(sql_insert);
            stm_insert.setInt(1, model.getDept().getId());
            stm_insert.setNString(2, model.getFullname());
            stm_insert.setNString(3, model.getUsername());
            stm_insert.setNString(4, model.getPassword());
            stm_insert.setNString(5, model.getEmail());
            stm_insert.setDate(6, model.getDob());
            stm_insert.setBoolean(7, model.isGender());
            stm_insert.setNString(8, model.getPhonenumber());
            stm_insert.setNString(9, model.getCitizenId());
            stm_insert.setNString(10, model.getAddress());

            stm_insert.executeUpdate();

            PreparedStatement stm_getsid = connection.prepareStatement(sql_getsid);
            ResultSet rs = stm_getsid.executeQuery();
            if (rs.next()) {
                model.setId(rs.getInt("staff_id"));
            }
            connection.commit();
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            // ❌ Không đóng connection ở đây!
            // ❌ Không đóng connection ở đây!
        }

    }

    @Override
    public void update(Staff model) {
        String sql_update = "UPDATE [dbo].[Staff]\n"
                + "SET \n"
                + "    [fullname] = ?,\n"
                + "    [email] = ?,\n"
                + "    [dob] = ?,  \n"
                + "    [gender] = ?,           \n"
                + "    [phonenumber] = ?, \n"
                + "    [citizen_identification_card] = ?,\n"
                + "    [address] = ?\n"
                + "WHERE staff_id = ?;";
        PreparedStatement stm_update = null;
        try {
            stm_update = connection.prepareStatement(sql_update);
            stm_update.setNString(1, model.getFullname());
            stm_update.setNString(2, model.getEmail());
            stm_update.setDate(3, model.getDob());
            stm_update.setBoolean(4, model.isGender());
            stm_update.setNString(5, model.getPhonenumber());
            stm_update.setNString(6, model.getCitizenId());
            stm_update.setNString(7, model.getAddress());
            stm_update.setInt(8, model.getId()); // khóa chính
            stm_update.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the prepared statement and database connection
            if (stm_update != null) {
                try {
                    stm_update.close();
                } catch (SQLException ex) {
                    Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    @Override
    public void delete(Staff model) {
        String sql_delete = "DELETE FROM Staff "
                + "WHERE staff_id = ?";
        PreparedStatement stm_delete = null;
        try {
            stm_delete = connection.prepareStatement(sql_delete);
            stm_delete.setInt(1, model.getId());
            stm_delete.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class
                    .getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(StaffDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public ArrayList<Staff> list() {
        ArrayList<Staff> staffs = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT s.staff_id ,d.department_name,s.fullname,s.email ,s.dob,s.gender,s.phonenumber ,s.citizen_identification_card,s.address FROM [dbo].[Staff] s\n"
                    + "  inner join Department d on s.department_id = d.department_id\n"
                    + "  where 1=1";

            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Staff s = new Staff();
                s.setId(rs.getInt("staff_id"));
                s.setFullname(rs.getNString("fullname"));
                s.setEmail(rs.getNString("email"));
                s.setDob(rs.getDate("dob"));
                s.setGender(rs.getBoolean("gender"));
                s.setPhonenumber(rs.getNString("phonenumber"));
                s.setCitizenId(rs.getNString("citizen_identification_card"));
                s.setAddress(rs.getNString("address"));

                Department d = new Department();
                d.setName(rs.getNString("department_name"));
                s.setDept(d); // Gán phòng ban cho nhân viên

                staffs.add(s);

            }

        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(StaffDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        return staffs;

    }

    @Override
    public Staff get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
