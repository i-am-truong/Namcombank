/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Properties;
import java.util.Random;

/**
 *
 * @author lenovo
 */
public class CustomerDAO extends DBContext {

    public Customer checkUser(String username, String password) {
        String sql = "SELECT [customer_id]\n"
                + "      ,[fullname]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[active]\n"
                + "      ,[email]\n"
                + "      ,[dob]\n"
                + "      ,[gender]\n"
                + "      ,[phonenumber]\n"
                + "      ,[balance]\n"
                + "      ,[citizen_identification_card]\n"
                + "      ,[address]\n"
                + "  FROM [dbo].[Customer]\n"
                + "  where username = ? and password = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, username);
            ps.setNString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Customer(
                        rs.getInt(1), // customer_id
                        rs.getString(2), // fullname
                        rs.getString(3), // username
                        rs.getString(4), // password
                        rs.getInt(5), // active
                        rs.getString(6), // email
                        rs.getDate(7), // date of birth
                        rs.getInt(8), // gender
                        rs.getString(9), // phone number
                        rs.getFloat(10), // balance
                        rs.getString(11), // citizen ID card
                        rs.getNString("address") // address
                );
            }

        } catch (SQLException e) {
        }
        return null;
    }

    public Customer get(String username, String password) {
        Customer customer = null;
        PreparedStatement stm = null;
        try {
            // Simple query to match username and password (in plaintext)
            String sql = "SELECT [username], [password] FROM [Customer]\n"
                    + "WHERE [username] = ? AND [password] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                customer = new Customer();
                customer.setUsername(username);
                // You can add any other user details here if needed
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return customer;
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT [customer_id]\n"
                + "      ,[fullname]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[active]\n"
                + "      ,[email]\n"
                + "      ,[dob]\n"
                + "      ,[gender]\n"
                + "      ,[phonenumber]\n"
                + "      ,[balance]\n"
                + "      ,[citizen_identification_card]\n"
                + "      ,[address]\n"
                + "  FROM [dbo].[Customer]\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("fullname"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("active"),
                        rs.getString("email"),
                        rs.getDate("dob"),
                        rs.getInt("gender"),
                        rs.getString("phonenumber"),
                        rs.getFloat("balance"),
                        rs.getString("citizen_identification_card"),
                        rs.getString("address")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public List<Customer> listAllCustomers(int index, int quantity, String sortField, String sortOrder) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT [customer_id]\n"
                + "      ,[fullname]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[active]\n"
                + "      ,[email]\n"
                + "      ,[dob]\n"
                + "      ,[gender]\n"
                + "      ,[phonenumber]\n"
                + "      ,[balance]\n"
                + "      ,[citizen_identification_card]\n"
                + "      ,[address]\n"
                + "  FROM [dbo].[Customer]\n";
        if (sortField != null && sortOrder != null) {
            sql += "ORDER BY " + sortField + " " + sortOrder + " ";
        } else {
            sql += "ORDER BY customer_id ";
        }

        sql += "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (index - 1) * quantity);
            ps.setInt(2, quantity);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("fullname"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("active"),
                        rs.getString("email"),
                        rs.getDate("dob"),
                        rs.getInt("gender"),
                        rs.getString("phonenumber"),
                        rs.getFloat("balance"),
                        rs.getString("citizen_identification_card"),
                        rs.getString("address")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public List<Customer> searchCustomers(String key, int active, int index, int quantity, String sortField, String sortOrder) {
        List<Customer> customers = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT [customer_id], [fullname], [username], [password], [active], ")
           .append("[email], [dob], [gender], [phonenumber], [balance], ")
           .append("[citizen_identification_card], [address] ")
           .append("FROM [dbo].[Customer] WHERE 1=1 ");

        // Add search conditions if key is provided
        if (key != null && !key.trim().isEmpty()) {
            sql.append("AND (fullname LIKE ? OR phonenumber LIKE ? OR email LIKE ? OR username LIKE ?) ");
        }

        // Add active filter condition
        if (active != -1) {
            sql.append("AND active = ? ");
        }

        // Add sorting
        if (sortField != null && sortOrder != null) {
            sql.append("ORDER BY ").append(sortField).append(" ").append(sortOrder).append(" ");
        } else {
            sql.append("ORDER BY customer_id ");
        }

        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // Set search parameters if key is provided
            if (key != null && !key.trim().isEmpty()) {
                String searchPattern = "%" + key + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            // Set active parameter if specified
            if (active != -1) {
                ps.setInt(paramIndex++, active);
            }

            // Set pagination parameters
            ps.setInt(paramIndex++, (index - 1) * quantity);
            ps.setInt(paramIndex, quantity);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    customers.add(new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("fullname"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("active"),
                        rs.getString("email"),
                        rs.getDate("dob"),
                        rs.getInt("gender"),
                        rs.getString("phonenumber"),
                        rs.getFloat("balance"),
                        rs.getString("citizen_identification_card"),
                        rs.getString("address")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // lay so du tai khoan cua khach hang
    public double getBalanceByCId(Customer c) {
        int cid = c.getCustomerId();
        String sql = "SELECT [balance]\n"
                + "FROM [dbo].[Customer]\n"
                + "WHERE customer_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("balance");
            }
        } catch (SQLException e) {

        }
        return 0;
    }

    //___________________________Active Customer_________________________
    // set active of account
    public void changeActive(int customer_id, int active) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET [active] = ?\n"
                + " WHERE [customer_id] =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, active);
            ps.setInt(2, customer_id);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void changeRole2(String username, int role) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET [rid] = ?\n"
                + " WHERE [username] =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

//    public Customer checkCustomer(String username, String password) {
//        String sql = "SELECT [customer_id]\n"
//                + "      ,[fullname]\n"
//                + "      ,[username]\n"
//                + "      ,[password]\n"
//                + "      ,[active]\n"
//                + "      ,[email]\n"
//                + "      ,[dob]\n"
//                + "      ,[gender]\n"
//                + "      ,[phonenumber]\n"
//                + "      ,[balance]\n"
//                + "      ,[citizen identification card]\n"
//                + "  FROM [dbo].[Customer]"
//                + "where username = ? and password = ?";
//        try{
//
//        }
//        return 0;
//    }
    public boolean checkUsername(String username, String email, String phonenumber) {
        String sql = "SELECT [username] FROM Customer WHERE [username] = ? or [email] = ? or [phonenumber] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phonenumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Username already exists in the database
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Print the stack trace for debugging
        }
        return true;
    }

    //sent code to email
    public static boolean verifyCode(String mailTo, String code) {
        final String from = "tranducanh22062004@gmail.com";
        final String password = "uqqy hrpu monf efam";

        Properties props = new Properties();
        props.setProperty("mail.smtp.host", "smtp.gmail.com"); // Use the correct SMTP server
        props.setProperty("mail.smtp.port", "587");//Cổng smtp tls-587
        props.setProperty("mail.smtp.auth", "true");//xác định cần xác thực mail
        props.setProperty("mail.smtp.starttls.enable", "true");// Kích hoạt STARTTLS để bảo mật kết nối.

        //Authenticator: cugn cấp thông tin xác thực khi cần
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);

        //using mail api, content send to mail.
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mailTo, false));
            msg.setSubject("verifile code");
            msg.setSentDate(new java.util.Date());
            String emailContent = "<html>"
                    + "<head>"
                    + "<style>"
                    + "p { font-size: 16px; }"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<h1>This is your code: <h1 style=\"color: #33ff33\">" + code + "</h1></h1>"
                    + "<p>Thank you for using our service.</p>"
                    + "</body>"
                    + "</html>";
            msg.setContent(emailContent, "text/html; charset=UTF-8");
            Transport.send(msg);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //cretate random code send to email
    public static String getCode() {
        Random rd = new Random();
        int number = rd.nextInt(1000000);
        return String.format("%06d", number);
    }

    //encode string
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

    //_____________________________________Register Account______________________________
    //resgister with customer
    public void registerAcc(String fullname, String username, String password, String email, String dob, int gender, String phonenumber, String cic, String address) {
        String sql = "INSERT INTO [dbo].[Customer] "
                + "([fullname], [username], [password], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [active], [balance]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1, 0);";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, fullname);
            ps.setString(2, username);
            // Use hashed password here
            ps.setString(3, password);
            ps.setString(4, email);
            ps.setDate(5, Date.valueOf(dob));
            ps.setInt(6, gender);
            ps.setString(7, phonenumber);
            ps.setString(8, cic);
            ps.setString(9, address);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi ra console
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "SQL Error: " + e.getMessage(), e);
        }
    }

    //_____________________________Reset Password_____________________________
    public void changePassByEmail(String email, String password) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET \n"
                + "[password] = ?\n"
                + " WHERE [email] = ?";
        try {
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, password);
            pst.setString(2, email);
            pst.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void changePass(String username, String password) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET \n"
                + "[password] = ?\n"
                + " WHERE [username] = ?";
        try {
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, password);
            pst.setString(2, username);
            pst.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateProfile(Customer customer) {
        if (connection == null) {
            throw new IllegalStateException("Database connection is not initialized.");
        }

        if (customer == null) {
            throw new IllegalArgumentException("Customer object cannot be null.");
        }

        String sql = "UPDATE [Customer] "
                + "SET [fullname] = ?, "
                + "[phonenumber] = ?, "
                + "[address] = ?, "
                + "[email] = ?, "
                + "[dob] = ?, "
                + "[gender] = ? "
                + "WHERE [customer_id] = ?";

        try {

            try (PreparedStatement stm = connection.prepareStatement(sql)) {
                stm.setNString(1, customer.getFullname());
                stm.setNString(2, customer.getPhonenumber());
                stm.setNString(3, customer.getAddress());
                stm.setNString(4, customer.getEmail());
                stm.setDate(5, customer.getDob());
                stm.setInt(6, customer.getGender());
                stm.setInt(7, customer.getCustomerId());

                int rowsUpdated = stm.executeUpdate();
                if (rowsUpdated == 0) {
                    System.out.println("No user found with UID: " + customer.getCustomerId());
                } else {
                    System.out.println("User profile updated successfully.");
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public int getTotalCustomerCount(String searchKey, int active) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) as total FROM [dbo].[Customer] WHERE 1=1 ");

        if (searchKey != null && !searchKey.trim().isEmpty()) {
            sql.append("AND (fullname LIKE ? OR phonenumber LIKE ? OR email LIKE ? OR username LIKE ?) ");
        }

        if (active != -1) {
            sql.append("AND active = ? ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (searchKey != null && !searchKey.trim().isEmpty()) {
                String pattern = "%" + searchKey + "%";
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
            }

            if (active != -1) {
                ps.setInt(paramIndex, active);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
//        CustomerDAO cdao = new CustomerDAO();
//        List<Customer> customers = cdao.getAllCustomers();
//        for(Customer customer : customers){
//            System.out.println(customer.toString());
//        }
    }
    //search user
//Name Phone Email Username
//    public List<Customer> searchU(String key, int active, int index, int quantity, String sortField, String sortOrder) {
//        List<Customer> listU = new ArrayList<>();
//        String sql = "SELECT [customer_id], [fullname], [phonenumber], [address], [email], [username], [password], [dob], [gender], [active] "
//                + "FROM [dbo].[Customer] c "
//                + "WHERE (c.fullname LIKE ? OR c.phonenumber LIKE ? OR c.email LIKE ? OR c.username LIKE ?) ";
//
//        if (active != -1) {
//            sql += "AND u.active = ? ";
//        }
//
//        // Add sorting
//        if (sortField != null && sortOrder != null) {
//            sql += "ORDER BY c." + sortField + " " + sortOrder + " ";
//        } else {
//            sql += "ORDER BY c.customer_id "; // Default sorting
//        }
//
//        sql += "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
//
//        try {
//            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setString(1, "%" + key + "%");
//            stm.setString(2, "%" + key + "%");
//            stm.setString(3, "%" + key + "%");
//            stm.setString(4, "%" + key + "%");
//            int paramIndex = 5;
//
//            if (active != -1) {
//                stm.setInt(paramIndex++, active);
//            }
//            int offset = Math.max(0, (index - 1) * quantity); // Ensure offset is non-negative
//            stm.setInt(paramIndex++, offset);
//            stm.setInt(paramIndex, quantity);
//
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                listU.add(new Customer(rs.getInt("customer_id"),
//                        rs.getString("fullname"),
//                        rs.getString("phonenumber"),
//                        rs.getString("address"),
//                        rs.getString("email"),
//                        rs.getString("username"),
//                        rs.getString("password"),
//                        rs.getString("dob"),
//                        rs.getInt("gender"),
//                        rs.getInt("rid"),
//                        rs.getInt("active")));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace(); // Handle or log the exception properly
//        }
//
//        return listU;
//    }
    //search user
//Name Phone Email Username
//    public List<Customer> searchU(String key, int rid, int active, int index, int quantity, String sortField, String sortOrder) {
//        List<Customer> listU = new ArrayList<>();
//        String sql = "SELECT [uid], [fullName], [phone], [address], [email], [username], [password], [dob], [gender], [rid], [active] "
//                + "FROM [dbo].[User] u "
//                + "WHERE (u.fullName LIKE ? OR u.phone LIKE ? OR u.email LIKE ? OR u.username LIKE ?) ";
//        if (rid != -1) {
//            sql += "AND u.rid = ? ";
//        }
//        if (active != -1) {
//            sql += "AND u.active = ? ";
//        }
//
//        // Add sorting
//        if (sortField != null && sortOrder != null) {
//            sql += "ORDER BY u." + sortField + " " + sortOrder + " ";
//        } else {
//            sql += "ORDER BY u.uid "; // Default sorting
//        }
//
//        sql += "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
//
//        try {
//            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setString(1, "%" + key + "%");
//            stm.setString(2, "%" + key + "%");
//            stm.setString(3, "%" + key + "%");
//            stm.setString(4, "%" + key + "%");
//            int paramIndex = 5;
//            if (rid != -1) {
//                stm.setInt(paramIndex++, rid);
//            }
//            if (active != -1) {
//                stm.setInt(paramIndex++, active);
//            }
//            int offset = Math.max(0, (index - 1) * quantity); // Ensure offset is non-negative
//            stm.setInt(paramIndex++, offset);
//            stm.setInt(paramIndex, quantity);
//
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                listU.add(new Customer(rs.getInt("uid"),
//                        rs.getString("fullName"),
//                        rs.getString("phone"),
//                        rs.getString("address"),
//                        rs.getString("email"),
//                        rs.getString("username"),
//                        rs.getString("password"),
//                        rs.getString("dob"),
//                        rs.getInt("gender"),
//                        rs.getInt("rid"),
//                        rs.getInt("active")));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace(); // Handle or log the exception properly
//        }
//
//        return listU;
//    }

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
