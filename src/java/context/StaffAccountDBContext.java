/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.Feature;
import model.auth.Role;
import model.auth.Staff;

/**
 *
 * @author Asus
 */
public class StaffAccountDBContext extends DBContext<Staff> {

    public String getStaffEmailByUsername(String username) {
        String sql = "SELECT email FROM staff WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("email");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when getting staff email: " + e.getMessage());
        }
        return null;
    }

    public static String toSHA1(String str) {
        String salt = "kaisd#$%^&*(sg~~sda";
        String result = null;

        str = str + salt;
        try {
            byte[] dataByte = str.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] hashBytes = md.digest(dataByte);
            result = Base64.getEncoder().encodeToString(hashBytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;

    }

    public ArrayList<Role> getRoles(String username) {
        PreparedStatement stm = null;
        ArrayList<Role> roles = new ArrayList<>();
        try {
            String sql = "SELECT r.role_id, r.role_name, f.feature_id, f.feature_name, f.url FROM Staff s "
                    + "INNER JOIN StaffRoles sr ON s.staff_id = sr.staff_id "
                    + "INNER JOIN Roles r ON r.role_id = sr.role_id "
                    + "INNER JOIN RoleFeatures rf ON rf.role_id = r.role_id "
                    + "INNER JOIN Features f ON f.feature_id = rf.feature_id "
                    + "WHERE username = ?";

            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();

            Map<Integer, Role> roleMap = new HashMap<>();
            while (rs.next()) {
                int rid = rs.getInt("role_id");
                Role role = roleMap.get(rid);
                if (role == null) {
                    role = new Role();
                    role.setId(rid);
                    role.setName(rs.getString("role_name"));
                    roleMap.put(rid, role);
                    roles.add(role);
                }

                Feature feature = new Feature();
                feature.setId(rs.getInt("feature_id"));
                feature.setName(rs.getString("feature_name"));
                feature.setUrl(rs.getString("url"));
                role.getFeatures().add(feature);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                // Không đóng connection tại đây trong khi test
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return roles;
    }

    public Staff get(String username, String password) {
        Staff staff = null;

        PreparedStatement stm = null;
        try {
            String sql = "SELECT staff_id, [fullname], [username],[password] FROM [Staff]\n"
                    + "WHERE [username] = ? AND [password] = ?";
            stm = connection.prepareStatement(sql);
            stm.setNString(1, username);
            stm.setNString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                staff = new Staff();
                staff.setUsername(username);
                staff.setFullname(rs.getString("fullname"));
                staff.setId(rs.getInt("staff_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffAccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(StaffAccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return staff;
    }

    public int getStaffIdByUsername(String username) {
        int staffId = 0;
        try {
            String sql = "SELECT staff_id FROM Staff WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                staffId = rs.getInt(1);
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in getStaffIdByUsername: " + e.getMessage());
            e.printStackTrace();
        }
        return staffId;
    }

    @Override
    public void insert(Staff model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Staff model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Staff model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Staff> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Staff get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
