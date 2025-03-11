/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import model.Saving;
import model.SavingPackage;
import model.SavingPackage_id;
import model.SavingRequest;
import model.SavingRequest_id;

/**
 *
 * @author admin
 */
public class SavingDao extends DBContext {

//                	[saving_package_id] [int] IDENTITY(1,1) NOT NULL,
//	[staff_id] [int] NOT NULL,
//	[saving_package_name] [nvarchar](255) NOT NULL,
//	[saving_package_description] [nvarchar](max) NOT NULL,
//	[saving_package_interest_rate] [decimal](5, 2) NOT NULL,
//	[saving_package_term_months] [int] NOT NULL,
//	[saving_package_min_deposit] [decimal](18, 2) NOT NULL,
//	[saving_package_max_deposit] [decimal](18, 2) NULL,
//	[saving_package_status] [nvarchar](10) NOT NULL,
//	[saving_package_created_at] [datetime] NOT NULL,
//	[saving_package_updated_at] [datetime] NULL,
//	[saving_package_withdrawable] [bit] NOT NULL,
//	[saving_package_approval_status] [nvarchar](10) NOT NULL,
    public List<SavingPackage> getSavingsWithdrawable() {
        List<SavingPackage> savingsList = new ArrayList<>();
        String query = "SELECT * FROM SavingPackage WHERE saving_package_status='active' AND saving_package_approval_status='approved' And saving_package_withdrawable = 1 ORDER BY saving_package_interest_rate ASC";
//And saving_package_withdrawable = 1
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SavingPackage saving = new SavingPackage();
                saving.setStaff_id(rs.getInt("staff_id"));
                saving.setSaving_package_name(rs.getString("saving_package_name"));
                saving.setSaving_package_description(rs.getString("saving_package_description"));
                saving.setSaving_package_interest_rate(rs.getDouble("saving_package_interest_rate"));
                saving.setSaving_package_term_months(rs.getInt("saving_package_term_months"));
                saving.setSaving_package_min_deposit(rs.getDouble("saving_package_min_deposit"));
                saving.setSaving_package_max_deposit(rs.getObject("saving_package_max_deposit") != null ? rs.getDouble("saving_package_max_deposit") : null);
                saving.setSaving_package_status(rs.getString("saving_package_status"));
                saving.setSaving_package_created_at(rs.getString("saving_package_created_at"));
                saving.setSaving_package_updated_at(rs.getString("saving_package_updated_at"));
                saving.setSaving_withdrawable(rs.getBoolean("saving_package_withdrawable"));
                saving.setSaving_package_approval_status(rs.getString("saving_package_approval_status"));

                savingsList.add(saving);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savingsList;
    }

    public List<SavingPackage> getSavingsNoWithdrawable() {
        List<SavingPackage> savingsList = new ArrayList<>();
        String query = "SELECT * FROM SavingPackage WHERE saving_package_status='active' AND saving_package_approval_status='approved' And saving_package_withdrawable = 0 ORDER BY saving_package_interest_rate ASC";
//And saving_package_withdrawable = 0
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SavingPackage saving = new SavingPackage();
                saving.setStaff_id(rs.getInt("staff_id"));
                saving.setSaving_package_name(rs.getString("saving_package_name"));
                saving.setSaving_package_description(rs.getString("saving_package_description"));
                saving.setSaving_package_interest_rate(rs.getDouble("saving_package_interest_rate"));
                saving.setSaving_package_term_months(rs.getInt("saving_package_term_months"));
                saving.setSaving_package_min_deposit(rs.getDouble("saving_package_min_deposit"));
                saving.setSaving_package_max_deposit(rs.getObject("saving_package_max_deposit") != null ? rs.getDouble("saving_package_max_deposit") : null);
                saving.setSaving_package_status(rs.getString("saving_package_status"));
                saving.setSaving_package_created_at(rs.getString("saving_package_created_at"));
                saving.setSaving_package_updated_at(rs.getString("saving_package_updated_at"));
                saving.setSaving_withdrawable(rs.getBoolean("saving_package_withdrawable"));
                saving.setSaving_package_approval_status(rs.getString("saving_package_approval_status"));

                savingsList.add(saving);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savingsList;
    }

    public List<SavingPackage_id> get_saving_package_withdrawable(int bit) {
        String query = "SELECT saving_package_id, saving_package_name, saving_package_interest_rate, "
                + "saving_package_term_months, saving_package_min_deposit, saving_package_max_deposit "
                + "FROM SavingPackage WHERE saving_package_withdrawable = ? AND saving_package_status='active'";

        List<SavingPackage_id> savingsList = new ArrayList<>();

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, bit); // Gán giá trị tham số
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) { // Lặp qua từng dòng kết quả
                    SavingPackage_id saving = new SavingPackage_id();
                    saving.setSaving_package_id(rs.getInt("saving_package_id"));
                    saving.setSaving_package_name(rs.getString("saving_package_name"));
                    saving.setSaving_package_interest_rate(rs.getDouble("saving_package_interest_rate"));
                    saving.setSaving_package_term_months(rs.getInt("saving_package_term_months"));
                    saving.setSaving_package_min_deposit(rs.getDouble("saving_package_min_deposit"));
                    saving.setSaving_package_max_deposit(
                            rs.getObject("saving_package_max_deposit") != null ? rs.getDouble("saving_package_max_deposit") : null
                    );

                    savingsList.add(saving); // Thêm vào danh sách
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savingsList;
    }

    public double selectRate(int saving_package_id) {
        String query = "SELECT saving_package_interest_rate FROM SavingPackage WHERE saving_package_id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_package_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("saving_package_interest_rate");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int selectTerm(int saving_package_id) {
        String query = "SELECT saving_package_term_months FROM SavingPackage WHERE saving_package_id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_package_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("saving_package_term_months");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String selectName(int saving_package_id) {
        String query = "SELECT saving_package_name FROM SavingPackage WHERE saving_package_id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_package_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("saving_package_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int selectSaving_package_term_months(int saving_package_id) {
        String query = "SELECT saving_package_term_months FROM SavingPackage WHERE saving_package_id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_package_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("saving_package_term_months");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void insertSavingRequest(int customer_id, int saving_package_id, Double money, String created_at, double amount, String saving_package_name) {
        String query = "INSERT INTO SavingRequest "
                + "(customer_id, saving_package_id, staff_id, money, saving_approval_status, "
                + "saving_approval_date, money_approval_status, amount, created_at, saving_package_name) "
                + "VALUES (?, ?, NULL, ?, 'pending', NULL, 'pending', ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customer_id);
            ps.setInt(2, saving_package_id);
            ps.setDouble(3, money);
            ps.setDouble(4, amount);
            ps.setString(5, created_at);
            ps.setString(6, saving_package_name);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Insert thành công!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//     <td>${sr.saving_request_id}</td>
//                                <td>${sr.saving_package_id}</td>
//                                <td>${sr.customer_id}</td>
//                                <td>${sr.saving_package_name}</td>
//                                <td>${String.format("%.2f", sr.money)}</td>
//                                <td>${sr.saving_approval_status}</td>
//                                <td>${sr.created_at}</td>
//                                <td>${sr.saving_approval_date}</td>
//                                <td>${sr.saving_date}</td>
//                                <td>${sr.staff_id}</td>
//                                <td>${String.format("%.2f", sr.amount)}</td>
    //SELECT * FROM SavingRequest WHERE staff_id IS NULL AND saving_approval_date IS NULL AND saving_date IS NULL;
    public List<SavingRequest_id> getAllSavingRequestPending() {
        List<SavingRequest_id> list = new ArrayList<>();
        String query = "SELECT * FROM SavingRequest WHERE staff_id IS NULL AND saving_approval_date IS NULL AND money_approval_status='pending';";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavingRequest_id sr = new SavingRequest_id();
                sr.setSaving_request_id(rs.getInt("saving_request_id")); // Đúng tên cột
                sr.setCustomer_id(rs.getInt("customer_id"));
                sr.setSaving_package_id(rs.getInt("saving_package_id")); // Bổ sung
                sr.setStaff_id(rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null); // Xử lý NULL
                sr.setMoney(rs.getDouble("money"));
                sr.setSaving_approval_status(rs.getString("saving_approval_status")); // Bổ sung
                sr.setSaving_approval_date(rs.getString("saving_approval_date"));
                sr.setMoney_approval_status(rs.getString("money_approval_status")); // Bổ sung
                sr.setAmount(rs.getDouble("amount")); // Bổ sung
                sr.setCreated_at(rs.getString("created_at")); // Nếu `created_at` có time, dùng `Timestamp`
                sr.setSaving_package_name(rs.getString("saving_package_name")); // Bổ sung
                list.add(sr);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    public void acceptSavingRequest(String saving_approval_status, String saving_approval_date, int saving_request_id) {
        String query = "UPDATE SavingRequest SET saving_approval_status = ?, saving_approval_date = ? WHERE saving_request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, saving_approval_status);
            ps.setString(2, saving_approval_date);
            ps.setInt(3, saving_request_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<SavingPackage_id> getAllSavingPackage() {
        String query = "select * from SavingPackage where saving_package_status='active' and saving_package_approval_status='approved'";
        List<SavingPackage_id> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
//                    private int saving_package_id;
//    private int staff_id;
//    private String saving_package_name;
//    private String saving_package_description;
//    private double saving_package_interest_rate;
//    private int saving_package_term_months;
//    private Double saving_package_min_deposit;
//    private Double saving_package_max_deposit;
//    private String saving_package_status;
//    private String saving_package_created_at;
//    private String saving_package_updated_at;
//    private boolean saving_withdrawable;
//    private String saving_package_approval_status;

                SavingPackage_id saving = new SavingPackage_id();
                saving.setSaving_package_id(rs.getInt("saving_package_id"));
                saving.setStaff_id(rs.getInt("staff_id"));
                saving.setSaving_package_name(rs.getString("saving_package_name"));
                saving.setSaving_package_description(rs.getString("saving_package_description"));
                saving.setSaving_package_interest_rate(rs.getDouble("saving_package_interest_rate"));
                saving.setSaving_package_term_months(rs.getInt("saving_package_term_months"));
                saving.setSaving_package_min_deposit(rs.getDouble("saving_package_min_deposit"));
                saving.setSaving_package_max_deposit(rs.getObject("saving_package_max_deposit") != null ? rs.getDouble("saving_package_max_deposit") : null);
                saving.setSaving_package_status(rs.getString("saving_package_status"));
                saving.setSaving_package_created_at(rs.getString("saving_package_created_at"));
                saving.setSaving_package_updated_at(rs.getString("saving_package_updated_at"));
                saving.setSaving_withdrawable(rs.getBoolean("saving_package_withdrawable"));
                saving.setSaving_package_approval_status(rs.getString("saving_package_approval_status"));
                list.add(saving);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<SavingRequest_id> getAllSavingRequestMoneyPending() {
        List<SavingRequest_id> list = new ArrayList<>();
        String query = "select * from SavingRequest where staff_id is NULL and money_approval_status ='pending' and saving_approval_status='approved';";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavingRequest_id sr = new SavingRequest_id();
                sr.setSaving_request_id(rs.getInt("saving_request_id")); // Đúng tên cột
                sr.setCustomer_id(rs.getInt("customer_id"));
                sr.setSaving_package_id(rs.getInt("saving_package_id")); // Bổ sung
                sr.setStaff_id(rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null); // Xử lý NULL
                sr.setMoney(rs.getDouble("money"));
                sr.setSaving_approval_status(rs.getString("saving_approval_status")); // Bổ sung
                sr.setSaving_approval_date(rs.getString("saving_approval_date"));
                sr.setMoney_approval_status(rs.getString("money_approval_status")); // Bổ sung
                sr.setAmount(rs.getDouble("amount")); // Bổ sung
                sr.setCreated_at(rs.getString("created_at"));
                sr.setSaving_package_name(rs.getString("saving_package_name")); // Bổ sung
                list.add(sr);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    public boolean acceptMoney(String money_approval_status, String saving_approval_date, int saving_request_id, int staff_id) {
        String query = "UPDATE SavingRequest SET money_approval_status = ?, saving_approval_date = ?, staff_id=? WHERE saving_request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, money_approval_status);
            ps.setString(2, saving_approval_date);
            ps.setInt(3, staff_id);
            ps.setInt(4, saving_request_id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu có ít nhất 1 dòng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Nếu có lỗi, trả về false
    }

    public void insertSavingPackage(int staff_id, String saving_package_name, String saving_package_description,
            String saving_package_created_at, String saving_package_updated_at,
            double saving_package_interest_rate, int saving_package_term_months,
            double saving_package_min_deposit, double saving_package_max_deposit,
            String saving_package_status, int saving_package_withdrawable,
            String saving_package_approval_status) {

        String query = "INSERT INTO [SavingPackage] "
                + "([staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], "
                + "[saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], "
                + "[saving_package_status], [saving_package_created_at], [saving_package_updated_at], "
                + "[saving_package_withdrawable], [saving_package_approval_status]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, staff_id);
            ps.setString(2, saving_package_name);
            ps.setString(3, saving_package_description);
            ps.setDouble(4, saving_package_interest_rate);
            ps.setInt(5, saving_package_term_months);
            ps.setDouble(6, saving_package_min_deposit);
            ps.setDouble(7, saving_package_max_deposit);
            ps.setString(8, saving_package_status);
            ps.setString(9, saving_package_created_at);
            ps.setString(10, saving_package_updated_at);
            ps.setInt(11, saving_package_withdrawable);
            ps.setString(12, saving_package_approval_status);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Inserted successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<SavingPackage_id> getAllSavingPackageRequest() {
        String query = "select * from SavingPackage where saving_package_status='Inactive' and saving_package_approval_status='pending'";
        List<SavingPackage_id> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                SavingPackage_id saving = new SavingPackage_id();
                saving.setSaving_package_id(rs.getInt("saving_package_id"));
                saving.setStaff_id(rs.getInt("staff_id"));
                saving.setSaving_package_name(rs.getString("saving_package_name"));
                saving.setSaving_package_description(rs.getString("saving_package_description"));
                saving.setSaving_package_interest_rate(rs.getDouble("saving_package_interest_rate"));
                saving.setSaving_package_term_months(rs.getInt("saving_package_term_months"));
                saving.setSaving_package_min_deposit(rs.getDouble("saving_package_min_deposit"));
                saving.setSaving_package_max_deposit(rs.getObject("saving_package_max_deposit") != null ? rs.getDouble("saving_package_max_deposit") : null);
                saving.setSaving_package_status(rs.getString("saving_package_status"));
                saving.setSaving_package_created_at(rs.getString("saving_package_created_at"));
                saving.setSaving_package_updated_at(rs.getString("saving_package_updated_at"));
                saving.setSaving_withdrawable(rs.getBoolean("saving_package_withdrawable"));
                saving.setSaving_package_approval_status(rs.getString("saving_package_approval_status"));
                list.add(saving);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void acceptSavingPackageRequest(String saving_package_updated_at, int saving_package_id) {
        String query = "UPDATE SavingPackage SET saving_package_status = 'Active', saving_package_approval_status = 'approved',saving_package_updated_at=? WHERE saving_package_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, saving_package_updated_at);
            ps.setInt(2, saving_package_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void rejectSavingPackageRequest(String saving_package_updated_at, int saving_package_id) {
        String query = "UPDATE SavingPackage SET saving_package_status = 'Active', saving_package_approval_status = 'pending',saving_package_updated_at=? WHERE saving_package_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, saving_package_updated_at);
            ps.setInt(2, saving_package_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int selectCustomer_id(int saving_request_id) {
        String query = "select customer_id  from SavingRequest where saving_request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_request_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("customer_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public double selectAmount(int saving_request_id) {
        String query = "select amount  from SavingRequest where saving_request_id = ? ";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_request_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("amount");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int selectSaving_package_id(int saving_request_id) {
        String query = "select saving_package_id  from SavingRequest where saving_request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_request_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("saving_package_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String selectSaving_package_interest_rate(int saving_package_id) {
        String query = "select saving_package_interest_rate  from SavingPackage where saving_package_id= ? ";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_package_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("saving_package_interest_rate");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int selectStaff_id(int saving_request_id) {
        String query = "select staff_id  from SavingRequest where saving_request_id =  ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_request_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("staff_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String select_openDate(int saving_request_id) {
        String query = "select saving_approval_date  from SavingRequest where saving_request_id = ? ";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, saving_request_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("saving_approval_date");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

//select staff_id  from SavingRequest where saving_request_id = 
    public void AddSavingFinal(int customer_id, double amount, double interest_rate, int term_months, String opened_date, int saving_request_id, int staff_id, String money_get_date) {
        String query = "INSERT INTO Saving (customer_id, amount, interest_rate, term_months, opened_date, status, saving_request_id, staff_id, money_get_date) "
                + "VALUES (?, ?, ?, ?, ?, 'active', ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customer_id);
            ps.setDouble(2, amount);
            ps.setDouble(3, interest_rate);
            ps.setInt(4, term_months);
            ps.setString(5, opened_date);
            ps.setInt(6, saving_request_id);
            ps.setInt(7, staff_id);
            ps.setString(8, money_get_date);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Saving> getAllSaving() {
        String query = "SELECT * FROM Saving WHERE money_get_date <= GETDATE() AND status = 'Active'";
        List<Saving> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Saving saving = new Saving();
                saving.setSavings_id(rs.getInt("savings_id"));
                saving.setCustomer_id(rs.getInt("customer_id"));
                saving.setAmount(rs.getDouble("amount"));
                saving.setInterest_rate(rs.getFloat("interest_rate"));
                saving.setTerm_months(rs.getInt("term_months"));
                saving.setOpened_date(rs.getString("opened_date"));
                saving.setStatus(rs.getString("status"));
                saving.setSaving_request_id(rs.getInt("saving_request_id"));
                saving.setStaff_id(rs.getInt("staff_id"));
                saving.setMoney_get_date(rs.getString("money_get_date"));

                list.add(saving);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void SavingPay(int savings_id) {
        String query = "UPDATE [Saving]  SET status='paid' WHERE savings_id= ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, savings_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws ParseException {
        int saving_request_id = 7;
        String opened_date = "2025-02-02";
        int term_months = 5;
        LocalDate openedLocalDate = LocalDate.parse(opened_date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LocalDate moneyGetLocalDate = openedLocalDate.plusMonths(term_months);
        String money_get_date = moneyGetLocalDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        System.out.println(money_get_date);
    }

    public List<SavingRequest> getAllSavingRequestCustomer(int customer_id) {
        List<SavingRequest> list = new ArrayList<>();
        String query = "select * from SavingRequest where staff_id is NULL and money_approval_status ='pending' and saving_approval_status='pending' and customer_id = ? ;";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customer_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavingRequest sr = new SavingRequest();
                sr.setCustomer_id(rs.getInt("customer_id"));
                sr.setSaving_package_id(rs.getInt("saving_package_id")); // Bổ sung
                sr.setStaff_id(rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null); // Xử lý NULL
                sr.setMoney(rs.getDouble("money"));
                sr.setSaving_approval_status(rs.getString("saving_approval_status")); // Bổ sung
                sr.setSaving_approval_date(rs.getString("saving_approval_date"));
                sr.setMoney_approval_status(rs.getString("money_approval_status")); // Bổ sung
                sr.setAmount(rs.getDouble("amount")); // Bổ sung
                sr.setCreated_at(rs.getString("created_at"));
                sr.setSaving_package_name(rs.getString("saving_package_name")); // Bổ sung
                list.add(sr);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<SavingRequest> getAllSavingRequestCustomerAccepted(int customer_id) {
        List<SavingRequest> list = new ArrayList<>();
        String query = "select * from SavingRequest where money_approval_status ='pending' and saving_approval_status='approved' and customer_id = ?;";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customer_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavingRequest sr = new SavingRequest();
                sr.setCustomer_id(rs.getInt("customer_id"));
                sr.setSaving_package_id(rs.getInt("saving_package_id")); // Bổ sung
                sr.setStaff_id(rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null); // Xử lý NULL
                sr.setMoney(rs.getDouble("money"));
                sr.setSaving_approval_status(rs.getString("saving_approval_status")); // Bổ sung
                sr.setSaving_approval_date(rs.getString("saving_approval_date"));
                sr.setMoney_approval_status(rs.getString("money_approval_status")); // Bổ sung
                sr.setAmount(rs.getDouble("amount")); // Bổ sung
                sr.setCreated_at(rs.getString("created_at"));
                sr.setSaving_package_name(rs.getString("saving_package_name")); // Bổ sung
                list.add(sr);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Saving> getAllSavings(int customer_id) {
        List<Saving> list = new ArrayList<>();
        String query = "SELECT * FROM Saving WHERE status='active' AND customer_id=?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customer_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Saving sr = new Saving();
                sr.setSavings_id(rs.getInt("savings_id"));
                sr.setCustomer_id(rs.getInt("customer_id"));
                sr.setAmount(rs.getDouble("amount"));
                sr.setInterest_rate(rs.getDouble("interest_rate"));
                sr.setTerm_months(rs.getInt("term_months"));
                sr.setOpened_date(rs.getString("opened_date"));
                sr.setStatus(rs.getString("status"));
                sr.setSaving_request_id(rs.getInt("saving_request_id"));
                sr.setStaff_id(rs.getInt("staff_id"));
                sr.setMoney_get_date(rs.getString("money_get_date"));

                list.add(sr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //select * from SavingRequest where saving_approval_status='approved' and money_approval_status='pending'
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
