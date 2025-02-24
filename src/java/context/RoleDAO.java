/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.Role;

/**
 *
 * @author Asus
 */
public class RoleDAO extends DBContext<Role> {

    public ArrayList<Role> getAllRoles() {
        ArrayList<Role> roles = new ArrayList<>();
        String sql = "SELECT role_id, role_name FROM [dbo].[Roles]";  // Note: Using Roles instead of Role

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                role.setName(rs.getString("role_name"));
                roles.add(role);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching roles: " + e.getMessage());
            e.printStackTrace();
        }
        return roles;
    }

    public Role getById(int id) {
        Role role = null;
        String query = "SELECT [role_id]\n"
                + "      ,[role_name]\n"
                + "  FROM [dbo].[Roles]\n"
                + " Where [role_id] = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return role;
    }

    @Override
    public void insert(Role model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Role model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Role model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Role> list() {
        ArrayList<Role> roles = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT role_id, role_name FROM Roles ORDER BY role_id";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                Role r = new Role();
                r.setId(rs.getInt("role_id"));
                r.setName(rs.getString("role_name"));
                roles.add(r);
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return roles;

    }

    @Override
    public Role get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
