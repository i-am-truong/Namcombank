/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.security.SecureRandom;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Department;
import model.LoanPackage;
import model.auth.Role;
import model.auth.Staff;

/**
 *
 * @author Asus
 */
public class StaffDAO extends DBContext<Staff> {

    // Method to generate a random password
    public String generateRandomPassword() {
        SecureRandom random = new SecureRandom();
        byte[] password = new byte[12]; // Password length
        random.nextBytes(password);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(password); // URL-safe encoding
    }

    // Method to send the password via email
    public void sendEmail(String recipientEmail, String password, String username) {
        String subject = "Your New Account Password";

        // Generate the HTML body with the account information
        String htmlBody = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "    <meta charset='UTF-8'>"
                + "    <style>"
                + "        body {"
                + "            font-family: Arial, sans-serif;"
                + "            line-height: 1.6;"
                + "            color: #333333;"
                + "            max-width: 600px;"
                + "            margin: 0 auto;"
                + "            padding: 20px;"
                + "        }"
                + "        .container {"
                + "            border: 1px solid #e0e0e0;"
                + "            border-radius: 5px;"
                + "            padding: 20px 30px;"
                + "        }"
                + "        .header {"
                + "            text-align: center;"
                + "            color: #2e7d32;"
                + "            font-size: 20px;"
                + "            font-weight: bold;"
                + "            margin-bottom: 20px;"
                + "        }"
                + "        .credentials-container {"
                + "            background-color: #f5f5f5;"
                + "            padding: 15px;"
                + "            text-align: center;"
                + "            margin: 20px 0;"
                + "            border-radius: 5px;"
                + "        }"
                + "        .credential-item {"
                + "            font-size: 16px;"
                + "            font-weight: bold;"
                + "            color: #2e7d32;"
                + "            margin: 10px 0;"
                + "        }"
                + "        p {"
                + "            margin: 10px 0;"
                + "        }"
                + "        .footer {"
                + "            margin-top: 20px;"
                + "        }"
                + "    </style>"
                + "</head>"
                + "<body>"
                + "    <div class='container'>"
                + "        <div class='header'>Namcombank - Account Information</div>"
                + "        <p>Hello,</p>"
                + "        <p>Your account has been created successfully. Below are your account credentials:</p>"
                + "        <div class='credentials-container'>"
                + "            <div class='credential-item'>Username: " + username + "</div>"
                + "            <div class='credential-item'>Password: " + password + "</div>"
                + "        </div>"
                + "        <p>Please change your password upon your first login.</p>"
                + "        <p>If you did not request this account, please contact our support team immediately.</p>"
                + "        <div class='footer'>"
                + "            <p>Best regards,<br>Namcombank Support Team</p>"
                + "        </div>"
                + "    </div>"
                + "</body>"
                + "</html>";

        // Set up email properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Your SMTP host
        properties.put("mail.smtp.port", "587"); // Your SMTP port
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Create email session
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("doanvinhhung369@gmail.com", "typj uudv rlzc yxzq"); // Your email and password
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("doanvinhhung369@gmail.com")); // Sender email
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);

            // Set the email content as HTML
            message.setContent(htmlBody, "text/html; charset=utf-8");

            Transport.send(message); // Send the email
        } catch (MessagingException e) {
            System.out.println("Error sending email: " + e.getMessage());
        }
    }

    public boolean isValueExistExcept(String columnName, String value, int staffId) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE " + columnName + " = ? AND staff_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, value);
            ps.setInt(2, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi kiểm tra " + columnName + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean doesRecordExist(String columnName, String value) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE " + columnName + " = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, value);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking " + columnName + ": " + e.getMessage());
        }

        return false;
    }

    public boolean updateStaff(Staff model) {
        // SQL queries
        String sql_update = "UPDATE [dbo].[Staff]\n"
                + "   SET [department_id] = ?\n"
                + "      ,[fullname] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[dob] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[phonenumber] = ?\n"
                + "      ,[citizen_identification_card] = ?\n"
                + "      ,[address] = ?\n"
                + " WHERE staff_id = ?";

        String sql_delete_roles = "DELETE FROM [dbo].[StaffRoles] WHERE staff_id = ?";
        String sql_insert_roles = "INSERT INTO [dbo].[StaffRoles] (staff_id, role_id) VALUES (?, ?)";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // 1. Cập nhật thông tin nhân viên
            try (PreparedStatement stm_update = connection.prepareStatement(sql_update)) {
                stm_update.setInt(1, model.getDept().getId());
                stm_update.setNString(2, model.getFullname());
                stm_update.setNString(3, model.getEmail());
                stm_update.setDate(4, model.getDob());
                stm_update.setBoolean(5, model.isGender());
                stm_update.setNString(6, model.getPhonenumber());
                stm_update.setNString(7, model.getCitizenId());
                stm_update.setNString(8, model.getAddress());
                stm_update.setInt(9, model.getId());

                int rowsUpdated = stm_update.executeUpdate();

            }

            // 2. Xóa roles cũ
            try (PreparedStatement stm_delete = connection.prepareStatement(sql_delete_roles)) {
                stm_delete.setInt(1, model.getId());
                int rolesDeleted = stm_delete.executeUpdate();

            }

            // 3. Thêm roles mới
            if (model.getRoles() != null && !model.getRoles().isEmpty()) {
                try (PreparedStatement stm_insert = connection.prepareStatement(sql_insert_roles)) {
                    for (Role role : model.getRoles()) {
                        stm_insert.setInt(1, model.getId());
                        stm_insert.setInt(2, role.getId());
                        stm_insert.addBatch();
                    }
                    int[] results = stm_insert.executeBatch();

                }
            }

            connection.commit();

            return true;

        } catch (SQLException ex) {
            try {
                connection.rollback();
                System.out.println("❌ Lỗi, đã rollback transaction");
            } catch (SQLException rollbackEx) {
                System.err.println("Lỗi khi rollback: " + rollbackEx.getMessage());
            }
            System.err.println("Lỗi SQL: " + ex.getMessage());
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                System.err.println("Lỗi khi reset auto-commit: " + ex.getMessage());
            }
        }
    }

    public Staff getById(int id) {
        String sql = "SELECT s.staff_id, s.fullname, s.email, s.dob, s.gender, "
                + "s.phonenumber, s.citizen_identification_card, s.address, "
                + "s.department_id, d.department_name, "
                + "r.role_id, r.role_name "
                + "FROM [dbo].[Staff] s "
                + "LEFT JOIN [dbo].[Department] d ON s.department_id = d.department_id "
                + "LEFT JOIN [dbo].[StaffRoles] sr ON s.staff_id = sr.staff_id "
                + "LEFT JOIN [dbo].[Roles] r ON sr.role_id = r.role_id "
                + "WHERE s.staff_id = ?";

        Staff staff = null;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                if (staff == null) {
                    staff = new Staff();
                    staff.setId(rs.getInt("staff_id"));
                    staff.setFullname(rs.getString("fullname"));
                    staff.setPhonenumber(rs.getNString("phonenumber"));
                    staff.setEmail(rs.getString("email"));
                    staff.setDob(rs.getDate("dob"));
                    staff.setGender(rs.getBoolean("gender"));

                    staff.setCitizenId(rs.getString("citizen_identification_card"));
                    staff.setAddress(rs.getNString("address"));

                    Department dept = new Department();
                    dept.setId(rs.getInt("department_id"));
                    dept.setName(rs.getString("department_name"));
                    staff.setDept(dept);

                    staff.setRoles(new ArrayList<>());
                }

                // Thêm role nếu có
                int roleId = rs.getInt("role_id");
                if (!rs.wasNull()) {
                    Role role = new Role();
                    role.setId(roleId);
                    role.setName(rs.getString("role_name"));
                    staff.getRoles().add(role);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy thông tin staff: " + e.getMessage());
        }
        return staff;
    }

    public ArrayList<Staff> search(String name, Boolean gender, String dob,
            String address, Integer did, String phonenumber, String email, String citizenID, Integer rid) {
        String sql = "SELECT s.staff_id, s.fullname, s.email, s.dob, s.gender, s.phonenumber, "
                + "s.citizen_identification_card, s.address, d.department_name, r.role_name "
                + "FROM Staff s "
                + "INNER JOIN Department d ON s.department_id = d.department_id "
                + "LEFT JOIN StaffRoles sr ON s.staff_id = sr.staff_id "
                + "LEFT JOIN Roles r ON sr.role_id = r.role_id "
                + "WHERE 1=1";

        ArrayList<Object> paramValues = new ArrayList<>();

//        // Điều kiện tìm kiếm theo Staff ID
//        if (sid != null) {
//            sql += " AND s.staff_id = ?";
//            paramValues.add(sid);
//        }
        // Điều kiện tìm kiếm theo mã phòng ban
        if (did != null) {
            sql += " AND d.department_id = ?";
            paramValues.add(did);
        }
        if (gender != null) {
            sql += " AND s.gender = ?";
            paramValues.add(gender ? 1 : 0); // Assuming 1 for male, 0 for female in DB
        }

        // Điều kiện tìm kiếm theo vai trò (Role ID)
        if (rid != null) {
            sql += " AND r.role_id = ?";
            paramValues.add(rid);
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

        ArrayList<Staff> staffs = new ArrayList<>();
        HashMap<Integer, Staff> staffMap = new HashMap<>();
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
                int staffId = rs.getInt("staff_id");

                // Nếu nhân viên chưa tồn tại trong danh sách, tạo mới
                Staff s = staffMap.get(staffId);
                if (s == null) {
                    s = new Staff();
                    s.setId(staffId);
                    s.setFullname(rs.getNString("fullname"));
                    s.setEmail(rs.getString("email"));
                    s.setDob(rs.getDate("dob"));
                    s.setGender(rs.getBoolean("gender"));
                    s.setPhonenumber(rs.getString("phonenumber"));
                    s.setCitizenId(rs.getString("citizen_identification_card"));
                    s.setAddress(rs.getString("address"));

                    // Gán phòng ban
                    Department d = new Department();
                    d.setName(rs.getString("department_name"));
                    s.setDept(d);

                    // Tạo danh sách vai trò rỗng
                    s.setRoles(new ArrayList<>());

                    // Thêm nhân viên vào HashMap
                    staffMap.put(staffId, s);
                }

                String roleName = rs.getString("role_name");
                if (roleName != null) {
                    Role r = new Role();
                    r.setName(roleName);
                    s.getRoles().add(r);
                }
            }

            staffs.addAll(staffMap.values());

        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();

                }
            } catch (SQLException ex) {
                Logger.getLogger(StaffDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }

        return staffs;
    }

    @Override
    public void insert(Staff model) {
        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Chèn nhân viên và lấy staff_id ngay lập tức
            String sql_insert = "INSERT INTO [dbo].[Staff] "
                    + "           ([department_id], [fullname], [username], [password], [email], "
                    + "           [dob], [gender], [phonenumber], [citizen_identification_card], [address]) "
                    + "     OUTPUT INSERTED.staff_id " // Lấy ID của nhân viên vừa chèn
                    + "     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stm_insert = connection.prepareStatement(sql_insert);
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

            ResultSet rs = stm_insert.executeQuery();
            int staffId = -1;
            if (rs.next()) {
                staffId = rs.getInt("staff_id");
                model.setId(staffId); // Cập nhật ID vào đối tượng model
            }

            // Chèn vai trò vào bảng StaffRoles nếu có
            if (!model.getRoles().isEmpty()) {
                String sql_insert_roles = "INSERT INTO [dbo].[StaffRoles] (staff_id, role_id) VALUES (?, ?)";
                PreparedStatement stm_roles = connection.prepareStatement(sql_insert_roles);

                for (Role r : model.getRoles()) {
                    stm_roles.setInt(1, staffId);
                    stm_roles.setInt(2, r.getId());
                    stm_roles.addBatch(); // Thêm vào batch để thực thi nhiều lần
                }
                stm_roles.executeBatch(); // Chạy tất cả các lệnh INSERT trong 1 lần
            }

            connection.commit(); // Xác nhận transaction

        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback(); // Hoàn tác nếu có lỗi

            } catch (SQLException ex1) {
                Logger.getLogger(StaffDAO.class
                        .getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true); // Khôi phục chế độ tự động commit

            } catch (SQLException ex) {
                Logger.getLogger(StaffDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void update(Staff model) {
        String sql_update = "UPDATE [dbo].[Staff]\n"
                + "   SET [department_id] = ?\n"
                + "      ,[fullname] = ?\n"
                + "      ,[username] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[active] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[dob] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[phonenumber] = ?\n"
                + "      ,[citizen_identification_card] = ?\n"
                + "      ,[address] = ?\n"
                + " WHERE staff_id =?";
        try (PreparedStatement stm_update = connection.prepareStatement(sql_update)) {
            // Set parameters...
            stm_update.setInt(1, model.getDept().getId()); // Department ID
            stm_update.setNString(2, model.getFullname()); // Full name
            stm_update.setNString(3, model.getEmail()); // Email
            stm_update.setDate(4, model.getDob()); // Date of birth
            stm_update.setBoolean(5, model.isGender()); // Gender
            stm_update.setNString(6, model.getPhonenumber()); // Phone number
            stm_update.setNString(7, model.getCitizenId()); // Citizen ID
            stm_update.setNString(8, model.getAddress()); // Address
            stm_update.setInt(9, model.getId()); // Primary key (staff_id)

            int rowsUpdated = stm_update.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated); // Log rows affected
        } catch (SQLException ex) {
            System.err.println("SQL error: " + ex.getMessage());
            ex.printStackTrace();
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
            String sql = "SELECT s.staff_id, s.fullname, s.email, s.dob, s.gender, s.phonenumber, "
                    + "s.citizen_identification_card, s.address, d.department_name, r.role_name "
                    + "FROM Staff s "
                    + "INNER JOIN Department d ON s.department_id = d.department_id "
                    + "LEFT JOIN StaffRoles sr ON s.staff_id = sr.staff_id "
                    + "LEFT JOIN Roles r ON sr.role_id = r.role_id "
                    + "where 1=1";
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            HashMap<Integer, Staff> staffMap = new HashMap<>();
            while (rs.next()) {
                int staffId = rs.getInt("staff_id");

                // Nếu nhân viên chưa tồn tại trong danh sách, tạo mới
                Staff s = staffMap.get(staffId);
                if (s == null) {
                    s = new Staff();
                    s.setId(staffId);
                    s.setFullname(rs.getNString("fullname"));
                    s.setEmail(rs.getString("email"));
                    s.setDob(rs.getDate("dob"));
                    s.setGender(rs.getBoolean("gender"));
                    s.setPhonenumber(rs.getString("phonenumber"));
                    s.setCitizenId(rs.getString("citizen_identification_card"));
                    s.setAddress(rs.getString("address"));
                    // Gán phòng ban
                    Department d = new Department();
                    d.setName(rs.getString("department_name"));
                    s.setDept(d);
                    // Tạo danh sách vai trò rỗng
                    s.setRoles(new ArrayList<>());
                    // Thêm nhân viên vào HashMap
                    staffMap.put(staffId, s);
                }
                String roleName = rs.getString("role_name");
                if (roleName != null) {
                    Role r = new Role();
                    r.setName(roleName);
                    s.getRoles().add(r);
                }
            }

            staffs.addAll(staffMap.values());

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
