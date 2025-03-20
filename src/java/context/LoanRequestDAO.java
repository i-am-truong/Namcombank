package context;

import context.DBContext;
import java.math.BigDecimal;
import java.math.RoundingMode;
import model.LoanRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import model.Customer;
import model.LoanPackage;
import model.auth.Staff;
import model.Asset;
import java.sql.*;

public class LoanRequestDAO extends DBContext<LoanRequest> {

    public List<LoanRequest> getAllLoanRequests() throws SQLException {
        List<LoanRequest> loanRequests = new ArrayList<>();
        String query = "SELECT \n"
                + "    r.request_id, r.staff_id, r.package_id, r.customer_id, r.request_date, r.amount, r.status,\n"
                + "    r.start_date, r.end_date, r.approval_date, r.approved_by, r.approved_note, r.asset_id,\n"
                + "    s.fullname AS staff_name, \n"
                + "    p.package_name, p.interest_rate,\n"
                + "    c.fullname AS customer_name, c.citizen_identification_card AS cic,\n"
                + "    cs.asset_name, cs.asset_value, cs.asset_type, cs.description\n"
                + "FROM [dbo].[LoanRequests] r\n"
                + "INNER JOIN Staff s ON r.staff_id = s.staff_id\n"
                + "INNER JOIN LoanPackages p ON p.package_id = r.package_id\n"
                + "INNER JOIN Customer c ON c.customer_id = r.customer_id\n"
                + "INNER JOIN CustomerAssets cs ON cs.asset_id = r.asset_id";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Khởi tạo và ánh xạ LoanRequest
                LoanRequest loanRequest = new LoanRequest();
                loanRequest.setRequestId(rs.getInt("request_id"));
                loanRequest.setCustomerId(rs.getInt("customer_id"));
                loanRequest.setPackageId(rs.getInt("package_id"));
                loanRequest.setStaffId(rs.getInt("staff_id"));
                loanRequest.setAmount(rs.getBigDecimal("amount"));
                loanRequest.setRequestDate(rs.getDate("request_date"));
                loanRequest.setStatus(rs.getString("status"));
                loanRequest.setApprovalDate(rs.getDate("approval_date"));
                loanRequest.setApprovedBy(rs.getString("approved_by"));
                loanRequest.setNotes(rs.getString("approved_note"));

                // Khởi tạo và ánh xạ Staff
                Staff staff = new Staff();
                staff.setId(rs.getInt("staff_id"));
                staff.setFullname(rs.getString("staff_name"));
                loanRequest.setStaff(staff);

                // Khởi tạo và ánh xạ Customer
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullname(rs.getString("customer_name"));
                customer.setCid(rs.getString("cic"));
                loanRequest.setCustomer(customer);

                // Khởi tạo và ánh xạ LoanPackage
                LoanPackage loanPackage = new LoanPackage();
                loanPackage.setPackageId(rs.getInt("package_id"));
                loanPackage.setPackageName(rs.getString("package_name"));
                loanPackage.setInterestRate(rs.getBigDecimal("interest_rate"));
                loanRequest.setLoanPackage(loanPackage);

                // Khởi tạo và ánh xạ Asset
                Asset asset = new Asset();
                asset.setAssetId(rs.getInt("asset_id"));
                asset.setAssetName(rs.getString("asset_name"));
                asset.setAssetType(rs.getString("asset_type"));
                asset.setAssetValue(rs.getBigDecimal("asset_value"));
                asset.setDescription(rs.getString("description"));
                loanRequest.setAsset(asset);

                loanRequests.add(loanRequest);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách yêu cầu vay: " + e.getMessage(), e);
        }
        return loanRequests;
    }

//    public boolean insertLoanRequest(LoanRequest request) {
//        String sql = "INSERT INTO LoanRequests (customer_id, package_id, amount, request_date, status, start_date, end_date, staff_id, approval_date, approved_by, notes) "
//                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//        try ( // Lấy kết nối từ DBContext
//                PreparedStatement stmt = connection.prepareStatement(sql)) {
//
//            stmt.setInt(1, request.getCustomerId());
//            stmt.setInt(2, request.getPackageId());
//            stmt.setDouble(3, request.getAmount());
//            stmt.setDate(4, new java.sql.Date(request.getRequestDate().getTime()));
//            stmt.setString(5, request.getStatus());
//
//            // Xử lý start_date
//            if (request.getStart_date() != null) {
//                stmt.setDate(6, new java.sql.Date(request.getStart_date().getTime()));
//            } else {
//                stmt.setNull(6, java.sql.Types.DATE);
//            }
//
//            // Xử lý end_date
//            if (request.getEnd_date() != null) {
//                stmt.setDate(7, new java.sql.Date(request.getEnd_date().getTime()));
//            } else {
//                stmt.setNull(7, java.sql.Types.DATE);
//            }
//
//            // Xử lý staff_id
//            if (request.getStaffId() > 0) {
//                stmt.setInt(8, request.getStaffId());
//            } else {
//                stmt.setNull(8, java.sql.Types.INTEGER);
//            }
//
//            // Xử lý approval_date
//            if (request.getApprovalDate() != null) {
//                stmt.setDate(9, new java.sql.Date(request.getApprovalDate().getTime()));
//            } else {
//                stmt.setNull(9, java.sql.Types.DATE);
//            }
//
//            // Xử lý approved_by
//            if (request.getApprovedBy() != null) {
//                stmt.setString(10, request.getApprovedBy());
//            } else {
//                stmt.setNull(10, java.sql.Types.VARCHAR);
//            }
//
//            // Xử lý notes
//            if (request.getNotes() != null) {
//                stmt.setString(11, request.getNotes());
//            } else {
//                stmt.setNull(11, java.sql.Types.VARCHAR);
//            }
//
//            return stmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
    @Override
    public void insert(LoanRequest model) {
        String sql = "INSERT INTO LoanRequests (customer_id, package_id, amount, request_date, status, asset_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, model.getCustomerId());
            stmt.setInt(2, model.getPackageId());
            stmt.setBigDecimal(3, model.getAmount());
            stmt.setDate(4, new java.sql.Date(model.getRequestDate().getTime()));
            stmt.setString(5, model.getStatus());

            // Xử lý asset_id: nếu là unsecured thì set null, ngược lại set giá trị assetId
            if (model.getAssetId() == null) {
                stmt.setNull(6, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(6, model.getAssetId());
            }

            stmt.executeUpdate();
            System.out.println("✅ Dữ liệu đã được lưu vào database!");
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi chi tiết
            System.out.println("❌ Lỗi khi lưu dữ liệu vào database: " + e.getMessage());
        }
    }

    @Override
    public void update(LoanRequest loan) {
        String sql = "UPDATE LoanRequests SET amount = ?, status = ? WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBigDecimal(1, loan.getAmount());
            ps.setString(2, loan.getStatus());
            ps.setInt(3, loan.getRequestId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a loan request and its related repayment schedules
     *
     * @param requestId The ID of the loan request to delete
     * @return true if the deletion is successful, false otherwise
     */
    public boolean deleteLoanRequest(int requestId) {
        Connection conn = null;
        PreparedStatement deleteScheduleStm = null;
        PreparedStatement deleteLoanStm = null;

        try {
            conn = connection; // Use your existing connection
            conn.setAutoCommit(false); // Start transaction

            // 1. Delete repayment schedule entries related to the loan request
            String deleteScheduleSql = "DELETE FROM RepaymentSchedule WHERE request_id = ?";
            deleteScheduleStm = conn.prepareStatement(deleteScheduleSql);
            deleteScheduleStm.setInt(1, requestId);
            int scheduleRowsDeleted = deleteScheduleStm.executeUpdate();

            System.out.println("Repayment schedule entries deleted: " + scheduleRowsDeleted);

            // 2. Delete the loan request
            String deleteLoanSql = "DELETE FROM LoanRequests WHERE request_id = ?";
            deleteLoanStm = conn.prepareStatement(deleteLoanSql);
            deleteLoanStm.setInt(1, requestId);
            int loanRowsDeleted = deleteLoanStm.executeUpdate();

            if (loanRowsDeleted == 0) {
                System.err.println("No loan request found with ID: " + requestId);
                conn.rollback();
                return false;
            }

            // 3. Commit the transaction if everything succeeded
            conn.commit();
            System.out.println("Loan request deleted successfully. Rows affected: " + loanRowsDeleted);
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Error rolling back transaction: " + rollbackEx.getMessage());
            }
            System.err.println("Error deleting loan request: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (deleteScheduleStm != null) {
                    deleteScheduleStm.close();
                }
                if (deleteLoanStm != null) {
                    deleteLoanStm.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto-commit to default
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }

    @Override
    public void delete(LoanRequest loan
    ) {
        String sql = "DELETE FROM LoanRequests WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, loan.getRequestId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAmount(int requestId, double newAmount) {
        String sql = "UPDATE LoanRequests SET amount = ? WHERE request_id = ? AND status = 'pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, newAmount);
            ps.setInt(2, requestId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void cancelRequest(int requestId) {
        String sql = "DELETE FROM LoanRequests WHERE request_id = ? AND status = 'pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<LoanRequest> list() {
        ArrayList<LoanRequest> list = new ArrayList<>();
        String sql = "SELECT r.*, c.fullname AS customer_name, p.package_name, \n"
                + "       COALESCE(s.fullname, 'Not yet') AS approved_by\n"
                + "FROM LoanRequests r\n"
                + "INNER JOIN Customer c ON r.customer_id = c.customer_id\n"
                + "INNER JOIN LoanPackages p ON r.package_id = p.package_id\n"
                + "LEFT JOIN Staff s ON s.staff_id = r.staff_id;";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LoanRequest loan = new LoanRequest();
                loan.setRequestId(rs.getInt("request_id"));
                loan.setPackageId(rs.getInt("package_id"));
                loan.setAmount(rs.getBigDecimal("amount"));
                loan.setRequestDate(rs.getDate("request_date"));
                loan.setStatus(rs.getString("status"));

                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullname(rs.getString("customer_name"));
                loan.setCustomer(customer);

                LoanPackage loanPackage = new LoanPackage();
                loanPackage.setPackageId(rs.getInt("package_id"));
                loanPackage.setPackageName(rs.getString("package_name"));
                loan.setLoanPackage(loanPackage);

                Staff staff = new Staff();
                staff.setId(rs.getInt("staff_id"));
                staff.setFullname(rs.getString("approved_by"));

                loan.setStaff(staff);

                list.add(loan);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public LoanRequest get(int id) {
        String sql = "SELECT * FROM LoanRequests WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LoanRequest loan = new LoanRequest();
                loan.setRequestId(rs.getInt("request_id"));
                loan.setCustomerId(rs.getInt("customer_id"));
                loan.setPackageId(rs.getInt("package_id"));
                loan.setAmount(rs.getBigDecimal("amount"));
                loan.setRequestDate(rs.getDate("request_date"));
                loan.setStatus(rs.getString("status"));
                return loan;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra xem khách hàng đã có thẻ tín dụng chưa
    public boolean hasCreditCard(int customerId) {
        String sql = "SELECT COUNT(*) FROM CreditCards WHERE customer_id = ? and status = 'Approved'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<LoanRequest> searchLoanRequests(
            String customerName, String packageName, String status,
            Double minAmount, Double maxAmount,
            String requestDateFrom, String requestDateTo,
            String approvedBy, String approvalDateFrom, String approvalDateTo,
            Boolean hasAsset) {

        ArrayList<LoanRequest> loanRequests = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT r.request_id, r.staff_id, r.package_id, r.customer_id, r.request_date, r.amount, "
                + "r.status, r.start_date, r.end_date, r.approval_date, r.approved_by, r.approved_note, r.asset_id, "
                + "s.fullname AS staff_name, "
                + "p.package_name, p.interest_rate,p.loan_term, "
                + "c.fullname AS customer_name, c.citizen_identification_card AS cic, "
                + "cs.asset_name, cs.asset_value, cs.asset_type, cs.description, "
                + "s2.fullname AS approver_name "
                + "FROM LoanRequests r "
                + "LEFT JOIN Staff s ON r.staff_id = s.staff_id "
                + "LEFT JOIN LoanPackages p ON p.package_id = r.package_id "
                + "LEFT JOIN Customer c ON c.customer_id = r.customer_id "
                + "LEFT JOIN CustomerAssets cs ON cs.asset_id = r.asset_id "
                + "LEFT JOIN Staff s2 ON s2.staff_id = r.approved_by "
                + "WHERE 1=1");

        ArrayList<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm cơ bản
        addSearchConditions(sql, params, customerName, packageName, status,
                minAmount, maxAmount, requestDateFrom, requestDateTo,
                approvalDateFrom, approvalDateTo, hasAsset);

        // Thêm điều kiện tìm kiếm cho người duyệt
        if (approvedBy != null && !approvedBy.isEmpty()) {
            sql.append(" AND (s2.fullname LIKE ? OR s2.staff_id = ?)");
            params.add("%" + approvedBy + "%");
            try {
                int approvedById = Integer.parseInt(approvedBy);
                params.add(approvedById);
            } catch (NumberFormatException e) {
                params.add(-1); // Giá trị không hợp lệ nếu không phải số
            }
        }

        // Thêm sắp xếp
        sql.append(" ORDER BY r.request_date DESC");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                try {
                    // Khởi tạo và ánh xạ LoanRequest
                    LoanRequest loanRequest = new LoanRequest();
                    int requestId = rs.getInt("request_id");
                    String loanStatus = rs.getString("status");
                    String noteValue = rs.getString("approved_note");

                    loanRequest.setRequestId(requestId);
                    loanRequest.setCustomerId(rs.getInt("customer_id"));
                    loanRequest.setPackageId(rs.getInt("package_id"));
                    loanRequest.setStaffId(rs.getInt("staff_id"));
                    loanRequest.setAmount(rs.getBigDecimal("amount"));
                    loanRequest.setStatus(loanStatus);
                    loanRequest.setNotes(noteValue);

                    // Xử lý các trường ngày tháng có thể NULL
                    java.sql.Date requestDate = rs.getDate("request_date");
                    if (requestDate != null) {
                        loanRequest.setRequestDate(requestDate);
                    }

                    java.sql.Date startDate = rs.getDate("start_date");
                    if (startDate != null) {
                        // Thêm setter cho startDate nếu model có trường này
                        // loanRequest.setStartDate(startDate);
                    }

                    java.sql.Date endDate = rs.getDate("end_date");
                    if (endDate != null) {
                        // Thêm setter cho endDate nếu model có trường này
                        // loanRequest.setEndDate(endDate);
                    }

                    java.sql.Date approvalDate = rs.getDate("approval_date");
                    if (approvalDate != null) {
                        loanRequest.setApprovalDate(approvalDate);
                    }

                    // Trong phương thức searchLoanRequests và getLoanRequestById
                    String approverName = rs.getString("approver_name");
                    if (approverName != null && !approverName.isEmpty()) {
                        loanRequest.setApprovedBy(approverName); // Lưu tên người duyệt vào approvedBy
                    } else {
                        Object approvedByObj = rs.getObject("approved_by");
                        if (approvedByObj != null) {
                            loanRequest.setApprovedBy("Staff ID: " + rs.getString("approved_by"));
                        }
                    }

                    // Khởi tạo và ánh xạ Staff
                    Staff staff = new Staff();
                    staff.setId(rs.getInt("staff_id"));
                    staff.setFullname(rs.getString("staff_name"));
                    loanRequest.setStaff(staff);

                    // Khởi tạo và ánh xạ Customer
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullname(rs.getString("customer_name"));
                    customer.setCid(rs.getString("cic"));
                    loanRequest.setCustomer(customer);

                    // Khởi tạo và ánh xạ LoanPackage
                    LoanPackage loanPackage = new LoanPackage();
                    loanPackage.setPackageId(rs.getInt("package_id"));
                    loanPackage.setPackageName(rs.getString("package_name"));
                    loanPackage.setInterestRate(rs.getBigDecimal("interest_rate"));
                    loanPackage.setLoanTerm(rs.getInt("loan_term"));
                    loanRequest.setLoanPackage(loanPackage);

                    // Khởi tạo và ánh xạ Asset (nếu có)
                    Object assetIdObj = rs.getObject("asset_id");
                    if (assetIdObj != null) {
                        Asset asset = new Asset();
                        asset.setAssetId(rs.getInt("asset_id"));

                        String assetName = rs.getString("asset_name");
                        if (assetName != null) {
                            asset.setAssetName(assetName);
                            asset.setAssetType(rs.getString("asset_type"));
                            asset.setAssetValue(rs.getBigDecimal("asset_value"));
                            asset.setDescription(rs.getString("description"));
                        }

                        loanRequest.setAsset(asset);
                    }

                    loanRequests.add(loanRequest);
                    count++;

                } catch (Exception e) {
                    System.err.println("Lỗi khi mapping loan request: " + e.getMessage());

                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }

        return loanRequests;
    }

    /**
     * Helper method để thêm các điều kiện tìm kiếm vào câu truy vấn SQL
     */
    private void addSearchConditions(
            StringBuilder sql, ArrayList<Object> params,
            String customerName, String packageName, String status,
            Double minAmount, Double maxAmount,
            String requestDateFrom, String requestDateTo,
            String approvalDateFrom, String approvalDateTo,
            Boolean hasAsset) {

        if (customerName != null && !customerName.isEmpty()) {
            sql.append(" AND c.fullname LIKE ?");
            params.add("%" + customerName + "%");
        }

        if (packageName != null && !packageName.isEmpty()) {
            sql.append(" AND p.package_name LIKE ?");
            params.add("%" + packageName + "%");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND r.status = ?");
            params.add(status);
        }

        if (minAmount != null) {
            sql.append(" AND r.amount >= ?");
            params.add(minAmount);
        }

        if (maxAmount != null) {
            sql.append(" AND r.amount <= ?");
            params.add(maxAmount);
        }

        if (requestDateFrom != null && !requestDateFrom.isEmpty()) {
            sql.append(" AND r.request_date >= ?");
            params.add(requestDateFrom + " 00:00:00");
        }

        if (requestDateTo != null && !requestDateTo.isEmpty()) {
            sql.append(" AND r.request_date <= ?");
            params.add(requestDateTo + " 23:59:59");
        }

        if (approvalDateFrom != null && !approvalDateFrom.isEmpty()) {
            sql.append(" AND r.approval_date >= ?");
            params.add(approvalDateFrom + " 00:00:00");
        }

        if (approvalDateTo != null && !approvalDateTo.isEmpty()) {
            sql.append(" AND r.approval_date <= ?");
            params.add(approvalDateTo + " 23:59:59");
        }

        if (hasAsset != null) {
            if (hasAsset) {
                sql.append(" AND r.asset_id IS NOT NULL");
            } else {
                sql.append(" AND r.asset_id IS NULL");
            }
        }
    }

    /**
     * Helper method để chuyển đổi mã trạng thái thành văn bản hiển thị
     */
    private String getStatusDisplay(String status) {
        if (status == null) {
            return "";
        }

        switch (status) {
            case "Pending":
                return "Chờ duyệt";
            case "Approved":
                return "Đã duyệt";
            case "Rejected":
                return "Từ chối";
            default:
                return status;
        }
    }

    /**
     * Đếm tổng số yêu cầu vay
     */
    public int countAllLoanRequests() {
        try {
            String query = "SELECT COUNT(*) FROM LoanRequests";
            try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm tổng số yêu cầu vay: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<LoanRequest> getLoanRequestsByCustomerId(int customerId) {
        ArrayList<LoanRequest> loanRequests = new ArrayList<>();
        String sql = "SELECT lr.request_id, lr.package_id, lr.amount, lr.request_date, lr.status, "
                + "c.customer_id, c.fullname AS customer_name, "
                + "lp.package_id, lp.package_name, "
                + "s.staff_id, s.fullname AS approved_by "
                + "FROM LoanRequests lr "
                + "JOIN Customer c ON lr.customer_id = c.customer_id "
                + "JOIN LoanPackages lp ON lr.package_id = lp.package_id "
                + "LEFT JOIN Staff s ON lr.staff_id = s.staff_id "
                + // LEFT JOIN vì có thể chưa có nhân viên duyệt
                "WHERE lr.customer_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LoanRequest loan = new LoanRequest();
                loan.setRequestId(rs.getInt("request_id"));
                loan.setPackageId(rs.getInt("package_id"));
                loan.setAmount(rs.getBigDecimal("amount"));
                loan.setRequestDate(rs.getDate("request_date"));
                loan.setStatus(rs.getString("status"));

                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullname(rs.getString("customer_name"));
                loan.setCustomer(customer);

                LoanPackage loanPackage = new LoanPackage();
                loanPackage.setPackageId(rs.getInt("package_id"));
                loanPackage.setPackageName(rs.getString("package_name"));
                loan.setLoanPackage(loanPackage);

                // Kiểm tra nếu chưa có nhân viên duyệt thì không set Staff
                if (rs.getObject("staff_id") != null) {
                    Staff staff = new Staff();
                    staff.setId(rs.getInt("staff_id"));
                    staff.setFullname(rs.getString("approved_by"));
                    loan.setStaff(staff);
                }

                loanRequests.add(loan);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanRequests;
    }

    public int countLoanRequestsByCustomer(int customerId) {
        String sql = "SELECT COUNT(*) FROM LoanRequests WHERE customer_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countLoanRequestsByStatusAndCustomer(String status, int customerId) {
        String sql = "SELECT COUNT(*) FROM LoanRequests WHERE status = ? AND customer_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Đếm số yêu cầu vay theo trạng thái
     */
    public int countLoanRequestsByStatus(String status) {
        try {
            String query = "SELECT COUNT(*) FROM LoanRequests WHERE status = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, status);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm yêu cầu vay theo trạng thái: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy chi tiết yêu cầu vay theo ID
     */
    public LoanRequest getLoanRequestById(int requestId) {
        String query = "SELECT r.request_id, r.staff_id, r.package_id, r.customer_id, r.request_date, r.amount, "
                + "r.status, r.start_date, r.end_date, r.approval_date, r.approved_by, r.approved_note, r.asset_id, "
                + "s.fullname AS staff_name, "
                + "p.package_name, p.interest_rate, p.loan_term, p.description AS package_description, "
                + "c.fullname AS customer_name, c.citizen_identification_card AS cic, c.phonenumber, c.email, c.address, "
                + "cs.asset_name, cs.asset_value, cs.asset_type, cs.description, "
                + "s2.fullname AS approver_name, s2.staff_id AS approver_id "
                + "FROM LoanRequests r "
                + "LEFT JOIN Staff s ON r.staff_id = s.staff_id "
                + "LEFT JOIN LoanPackages p ON p.package_id = r.package_id "
                + "LEFT JOIN Customer c ON c.customer_id = r.customer_id "
                + "LEFT JOIN CustomerAssets cs ON cs.asset_id = r.asset_id "
                + "LEFT JOIN Staff s2 ON s2.staff_id = r.approved_by "
                + "WHERE r.request_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, requestId);

            System.out.println("Executing query for request ID: " + requestId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    LoanRequest loanRequest = new LoanRequest();

                    // Thiết lập thông tin cơ bản
                    int reqId = rs.getInt("request_id");
                    String loanStatus = rs.getString("status");
                    String noteValue = rs.getString("approved_note");

                    System.out.println("Processing request ID: " + reqId + ", Status: " + loanStatus + ", Note: " + noteValue);

                    loanRequest.setRequestId(reqId);
                    loanRequest.setCustomerId(rs.getInt("customer_id"));
                    loanRequest.setPackageId(rs.getInt("package_id"));
                    loanRequest.setStaffId(rs.getInt("staff_id"));
                    loanRequest.setAmount(rs.getBigDecimal("amount"));
                    loanRequest.setStatus(loanStatus);
                    loanRequest.setNotes(noteValue);

                    // Xử lý các trường ngày tháng có thể NULL
                    java.sql.Date requestDate = rs.getDate("request_date");
                    if (requestDate != null) {
                        loanRequest.setRequestDate(requestDate);
                    }

                    java.sql.Date startDate = rs.getDate("start_date");
                    if (startDate != null) {
                    }
                    java.sql.Date endDate = rs.getDate("end_date");
                    if (endDate != null) {
                    }

                    java.sql.Date approvalDate = rs.getDate("approval_date");
                    if (approvalDate != null) {
                        loanRequest.setApprovalDate(approvalDate);
                    }

                    // Xử lý thông tin người duyệt
                    Object approvedByObj = rs.getObject("approved_by");
                    if (approvedByObj != null) {
                        int approvedById = rs.getInt("approved_by");
                        String approverName = rs.getString("approver_name");
                        loanRequest.setApprovedBy(approverName != null ? approverName : String.valueOf(approvedById));
                        // Nếu có thông tin người duyệt, tạo đối tượng Staff cho người duyệt
                        if (approverName != null) {
                            Staff approver = new Staff();
                            approver.setId(approvedById);
                            approver.setFullname(approverName);
                        }
                    }

                    // Thiết lập thông tin Staff (người tạo)
                    Staff staff = new Staff();
                    staff.setId(rs.getInt("staff_id"));
                    staff.setFullname(rs.getString("staff_name"));
                    loanRequest.setStaff(staff);

                    // Thiết lập thông tin Customer
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullname(rs.getString("customer_name"));
                    customer.setCid(rs.getString("cic"));
                    customer.setPhonenumber(rs.getString("phonenumber"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAddress(rs.getString("address"));
                    loanRequest.setCustomer(customer);

                    // Thiết lập thông tin LoanPackage
                    LoanPackage loanPackage = new LoanPackage();
                    loanPackage.setPackageId(rs.getInt("package_id"));
                    loanPackage.setPackageName(rs.getString("package_name"));
                    loanPackage.setInterestRate(rs.getBigDecimal("interest_rate"));
                    loanPackage.setLoanTerm(rs.getInt("loan_term"));
                    loanPackage.setDescription(rs.getString("package_description"));
                    loanRequest.setLoanPackage(loanPackage);

                    // Thiết lập thông tin Asset (nếu có)
                    Object assetIdObj = rs.getObject("asset_id");
                    if (assetIdObj != null) {
                        Asset asset = new Asset();
                        asset.setAssetId(rs.getInt("asset_id"));

                        String assetName = rs.getString("asset_name");
                        if (assetName != null) {
                            asset.setAssetName(assetName);
                            asset.setAssetType(rs.getString("asset_type"));
                            asset.setAssetValue(rs.getBigDecimal("asset_value"));
                            asset.setDescription(rs.getString("description"));
                        }

                        loanRequest.setAsset(asset);
                    }

                    return loanRequest;
                } else {
                    System.out.println("No loan request found with ID: " + requestId);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting loan request details: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Phê duyệt yêu cầu vay
     */
    /**
     * Approves a loan request, updates customer balance, and generates
     * repayment schedule
     *
     * @param requestId The ID of the loan request to approve
     * @param staffId The ID of the staff member approving the request
     * @param note Approval note
     * @return true if the approval process is successful, false otherwise
     */
    public boolean approveLoanRequestWithSchedule(int requestId, int staffId, String note) {
        Connection conn = null;
        PreparedStatement loanUpdateStm = null;
        PreparedStatement customerUpdateStm = null;
        PreparedStatement scheduleInsertStm = null;
        PreparedStatement transactionInsertStm = null;
        boolean success = false; // Biến để theo dõi trạng thái thành công

        try {
            conn = connection; // Sử dụng kết nối hiện có
            conn.setAutoCommit(false); // Bắt đầu giao dịch

            // 1. Lấy thông tin khoản vay với thông tin gói vay
            LoanRequest loanRequest = getLoanRequestWithPackage(requestId);
            if (loanRequest == null) {
                return false;
            }

            if (!"PENDING".equalsIgnoreCase(loanRequest.getStatus())) {
                return false;
            }

            // 2. Kiểm tra xem yêu cầu vay đã có asset_id chưa
            Integer assetId = getAssetIdFromLoanRequest(requestId);

            // 3. Cập nhật trạng thái yêu cầu vay thành APPROVED
            String updateSql;
            if (assetId != null && assetId > 0) {
                updateSql = "UPDATE LoanRequests SET status = 'Approved', "
                        + "approval_date = GETDATE(), approved_by = ?, "
                        + "approved_note = ?, start_date = GETDATE(), "
                        + "end_date = DATEADD(month, ?, GETDATE()) "
                        + "WHERE request_id = ? AND status = 'PENDING'";
            } else {
                updateSql = "UPDATE LoanRequests SET status = 'Approved', "
                        + "approval_date = GETDATE(), approved_by = ?, "
                        + "approved_note = ?, start_date = GETDATE(), "
                        + "end_date = DATEADD(month, ?, GETDATE()), "
                        + "asset_id = NULL "
                        + "WHERE request_id = ? AND status = 'PENDING'";
            }

            loanUpdateStm = conn.prepareStatement(updateSql);
            loanUpdateStm.setString(1, String.valueOf(staffId));
            loanUpdateStm.setString(2, note);
            loanUpdateStm.setInt(3, loanRequest.getLoanPackage().getLoanTerm());
            loanUpdateStm.setInt(4, requestId);

            int rowsUpdated = loanUpdateStm.executeUpdate();
            if (rowsUpdated == 0) {
                conn.rollback();
                return false;
            }

            // 4. Cập nhật số dư của khách hàng
            String customerSql = "UPDATE Customer SET balance = balance + ? WHERE customer_id = ?";
            customerUpdateStm = conn.prepareStatement(customerSql);
            customerUpdateStm.setBigDecimal(1, loanRequest.getAmount());
            customerUpdateStm.setInt(2, loanRequest.getCustomerId());

            int customerRowsUpdated = customerUpdateStm.executeUpdate();
            if (customerRowsUpdated == 0) {
                conn.rollback();
                return false;
            }

            // 5. Ghi lại giao dịch
            String transactionSql = "INSERT INTO [dbo].[Transaction] "
                    + "([request_id], [amount], [transaction_date], [type], [customer_id], [staff_id]) "
                    + "VALUES (?, ?, GETDATE(), 'Loan', ?, ?)";

            transactionInsertStm = conn.prepareStatement(transactionSql);
            transactionInsertStm.setInt(1, requestId);
            transactionInsertStm.setBigDecimal(2, loanRequest.getAmount());
            transactionInsertStm.setInt(3, loanRequest.getCustomerId());
            transactionInsertStm.setInt(4, staffId);

            int transactionRowsInserted = transactionInsertStm.executeUpdate();
            if (transactionRowsInserted == 0) {
                conn.rollback();
                return false;
            }

            // 6. Tính toán số tiền trả hàng tháng
            BigDecimal principal = loanRequest.getAmount();
            BigDecimal annualInterestRate;

            try {
                annualInterestRate = loanRequest.getLoanPackage().getInterestRate().divide(new BigDecimal("100"));
            } catch (NullPointerException e) {
                conn.rollback();
                return false;
            }

            BigDecimal monthlyRate = annualInterestRate.divide(new BigDecimal("12"), 10, RoundingMode.HALF_UP);
            int loanTermMonths = loanRequest.getLoanPackage().getLoanTerm();

            // Tính toán khoản thanh toán hàng tháng
            BigDecimal monthlyPayment;

            try {
                BigDecimal onePlusR = BigDecimal.ONE.add(monthlyRate);
                BigDecimal onePlusRPowerN = onePlusR.pow(loanTermMonths);
                BigDecimal numerator = principal.multiply(monthlyRate).multiply(onePlusRPowerN);
                BigDecimal denominator = onePlusRPowerN.subtract(BigDecimal.ONE);

                if (denominator.compareTo(BigDecimal.ZERO) == 0) {
                    monthlyPayment = principal.divide(new BigDecimal(loanTermMonths), 2, RoundingMode.HALF_UP);
                } else {
                    monthlyPayment = numerator.divide(denominator, 2, RoundingMode.HALF_UP);
                }
            } catch (Exception e) {
                monthlyPayment = principal.divide(new BigDecimal(loanTermMonths), 2, RoundingMode.HALF_UP);
            }

            // 7. Tạo lịch trả nợ
            String scheduleSql = "INSERT INTO RepaymentSchedule ( status, due_date, amount_due, request_id) "
                    + "VALUES ('PENDING', DATEADD(month, ?, GETDATE()), ?, ?)";

            scheduleInsertStm = conn.prepareStatement(scheduleSql);

            for (int month = 1; month <= loanTermMonths; month++) {
                scheduleInsertStm.setInt(1, month);
                scheduleInsertStm.setBigDecimal(2, monthlyPayment);
                scheduleInsertStm.setInt(3, requestId);
                scheduleInsertStm.addBatch();
            }

            int[] scheduleResults = scheduleInsertStm.executeBatch();

            boolean allSchedulesCreated = true;
            for (int i = 0; i < scheduleResults.length; i++) {
                int result = scheduleResults[i];
                if (result <= 0) {
                    allSchedulesCreated = false;
                }
            }

            if (!allSchedulesCreated) {
                conn.rollback();
                return false;
            }

            // 8. Commit giao dịch nếu mọi thứ thành công
            conn.commit();
            success = true; // Đánh dấu là thành công
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Lỗi khi rollback giao dịch: " + rollbackEx.getMessage());
            }
            System.err.println("Lỗi SQL khi phê duyệt yêu cầu vay: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Lỗi khi rollback giao dịch: " + rollbackEx.getMessage());
            }
            System.err.println("Lỗi chung khi phê duyệt yêu cầu vay: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (loanUpdateStm != null) {
                    loanUpdateStm.close();
                }
                if (customerUpdateStm != null) {
                    customerUpdateStm.close();
                }
                if (transactionInsertStm != null) {
                    transactionInsertStm.close();
                }
                if (scheduleInsertStm != null) {
                    scheduleInsertStm.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // Đặt lại auto-commit về mặc định
                }
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng tài nguyên: " + e.getMessage());
            }
            return success; // Trả về giá trị thành công đã được đặt trước đó
        }
    }

    /**
     * Helper method to get the asset ID from a loan request
     */
    private Integer getAssetIdFromLoanRequest(int requestId) {
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT asset_id FROM LoanRequests WHERE request_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, requestId);
            rs = stm.executeQuery();

            if (rs.next()) {
                int assetId = rs.getInt("asset_id");
                // Check if the value is NULL (SQL returns 0 for NULL integers in getInt)
                if (rs.wasNull()) {
                    return null;
                }
                return assetId;
            }
            return null;
        } catch (SQLException e) {
            System.err.println("Error getting asset ID from loan request: " + e.getMessage());
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }

    /**
     * Helper method to retrieve loan request with package details
     */
    private LoanRequest getLoanRequestWithPackage(int requestId) {
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            // Updated SQL to match your database schema
            String sql = "SELECT lr.*, lp.interest_rate, lp.loan_term, lp.package_name "
                    + "FROM LoanRequests lr "
                    + "JOIN LoanPackages lp ON lr.package_id = lp.package_id "
                    + "WHERE lr.request_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, requestId);
            rs = stm.executeQuery();

            if (rs.next()) {
                LoanRequest request = new LoanRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setCustomerId(rs.getInt("customer_id"));
                request.setPackageId(rs.getInt("package_id"));
                request.setAmount(rs.getBigDecimal("amount"));
                request.setRequestDate(rs.getDate("request_date"));
                request.setStatus(rs.getString("status"));
                request.setStaffId(rs.getInt("staff_id"));

                // Create and set loan package
                LoanPackage loanPackage = new LoanPackage();
                loanPackage.setPackageId(rs.getInt("package_id"));
                loanPackage.setPackageName(rs.getString("package_name"));
                loanPackage.setInterestRate(rs.getBigDecimal("interest_rate"));
                loanPackage.setLoanTerm(rs.getInt("loan_term"));

                request.setLoanPackage(loanPackage);

                return request;
            }
            return null;
        } catch (SQLException e) {
            System.err.println("Error retrieving loan request details: " + e.getMessage());
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }

    public boolean approveLoanRequest(int requestId, int staffId, String notes) {
        String query = "UPDATE LoanRequests SET status = 'Approved', approved_by = ?, "
                + "approval_date = GETDATE(), approved_note = ? "
                + "WHERE request_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, staffId);
            stmt.setString(2, notes);
            stmt.setInt(3, requestId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi từ chối yêu cầu vay: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Từ chối yêu cầu vay
     */
    public boolean rejectLoanRequest(int requestId, int staffId, String notes) {
        String query = "UPDATE LoanRequests SET status = 'Rejected', approved_by = ?, "
                + "approval_date = GETDATE(), approved_note = ? "
                + "WHERE request_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, staffId);
            stmt.setString(2, notes);
            stmt.setInt(3, requestId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi từ chối yêu cầu vay: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy danh sách tài sản của khách hàng
     */
    public ArrayList<Asset> getCustomerAssets(int customerId) {
        ArrayList<Asset> assets = new ArrayList<>();
        String query = "SELECT asset_id, customer_id, staff_id, asset_type, asset_name, "
                + "asset_value, description, approved_by, status, created_date, "
                + "approved_date, note "
                + "FROM CustomerAssets "
                + "WHERE customer_id = ? AND status = 'APPROVED'";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Asset asset = new Asset();
                    asset.setAssetId(rs.getInt("asset_id"));
                    asset.setCustomerId(rs.getInt("customer_id"));
                    asset.setStaffId(rs.getInt("staff_id"));
                    asset.setAssetType(rs.getString("asset_type"));
                    asset.setAssetName(rs.getString("asset_name"));
                    asset.setAssetValue(rs.getBigDecimal("asset_value"));
                    asset.setDescription(rs.getString("description"));
                    asset.setApprovedBy(rs.getInt("approved_by"));
                    asset.setStatus(rs.getString("status"));
                    asset.setCreatedDate(rs.getTimestamp("created_date"));
                    asset.setApprovedDate(rs.getTimestamp("approved_date"));
                    asset.setNotes(rs.getString("note"));

                    assets.add(asset);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách tài sản của khách hàng: " + e.getMessage());
            e.printStackTrace();
        }

        return assets;
    }

    public static void main(String[] args) {
        // Test the loan approval functionality
        LoanRequestDAO dao = new LoanRequestDAO();

        // Test parameters
        int requestId = 20;  // Replace with a valid request ID from your database
        int staffId = 1;    // Replace with a valid staff ID
        String note = "Test approval via main method";

        System.out.println("======= LOAN APPROVAL TEST =======");
        System.out.println("Testing approval for request ID: " + requestId);
        System.out.println("Staff ID: " + staffId);
        System.out.println("Note: " + note);
        System.out.println("=================================");

        // Test the approval method
        boolean success = dao.approveLoanRequestWithSchedule(requestId, staffId, note);

        System.out.println("=================================");
        System.out.println("Approval result: " + (success ? "SUCCESS" : "FAILED"));
        System.out.println("=================================");

        // Test with a custom method to verify database state
        if (success) {
            verifyApprovalResults(dao, requestId);
        }
    }

    /**
     * Verify the results of the approval process
     */
    private static void verifyApprovalResults(LoanRequestDAO dao, int requestId) {
        System.out.println("\n======= VERIFICATION =======");

        try (Connection conn = dao.connection) {
            // 1. Verify loan request status
            String loanSql = "SELECT status, approval_date, approved_by, approved_note FROM LoanRequests WHERE request_id = ?";
            try (PreparedStatement loanStm = conn.prepareStatement(loanSql)) {
                loanStm.setInt(1, requestId);
                try (ResultSet loanRs = loanStm.executeQuery()) {
                    if (loanRs.next()) {
                        String status = loanRs.getString("status");
                        Date approvalDate = loanRs.getDate("approval_date");
                        String approvedBy = loanRs.getString("approved_by");
                        String note = loanRs.getString("approved_note");

                        System.out.println("Loan Request Status: " + status);
                        System.out.println("Approval Date: " + approvalDate);
                        System.out.println("Approved By: " + approvedBy);
                        System.out.println("Note: " + note);
                    } else {
                        System.out.println("Loan request not found!");
                    }
                }
            }

            // 2. Check repayment schedule
            String scheduleSql = "SELECT COUNT(*) as count FROM RepaymentSchedule WHERE request_id = ?";
            try (PreparedStatement scheduleStm = conn.prepareStatement(scheduleSql)) {
                scheduleStm.setInt(1, requestId);
                try (ResultSet scheduleRs = scheduleStm.executeQuery()) {
                    if (scheduleRs.next()) {
                        int count = scheduleRs.getInt("count");
                        System.out.println("Repayment Schedule Entries: " + count);
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error verifying results: " + e.getMessage());
        }

        System.out.println("===== VERIFICATION END =====");
    }

    public boolean hasApprovedLoan(int customerId) {
        String query = "SELECT COUNT(request_id) AS loanCount, SUM(amount) AS totalAmount "
                + "FROM LoanRequests WHERE customer_id = ? AND status = 'approved' "
                + "GROUP BY customer_id";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int loanCount = rs.getInt("loanCount");
                    BigDecimal totalAmount = rs.getBigDecimal("totalAmount");
                    return loanCount >= 3 && totalAmount.compareTo(new BigDecimal(500000000)) >= 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Không có khoản vay nào được duyệt
    }

    public BigDecimal getTotalApprovedLoanAmount(int customerId) {
        BigDecimal totalLoan = BigDecimal.ZERO; // Khởi tạo đúng kiểu BigDecimal
        String query = "SELECT SUM(amount) FROM LoanRequests WHERE customer_id = ? and status = 'Approved'";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal result = rs.getBigDecimal(1); // Lấy giá trị đúng kiểu
                    if (result != null) {
                        totalLoan = result;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalLoan;
    }

    // Lấy trạng thái của khoản vay gần nhất đã được duyệt
    public String getLatestApprovedLoanStatus(int customerId) {
        String sql = "SELECT status FROM LoanRequests WHERE customer_id = ? AND status = 'Approved' ORDER BY approval_date DESC LIMIT 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getApprovedLoanCount(int customerId) {
        int loanCount = 0;
        String query = "SELECT COUNT(*) FROM LoanRequests WHERE customer_id = ? and status = 'Approved'";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    loanCount = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanCount;
    }

    public BigDecimal getTotalLoanAmount(int customerId) {
        BigDecimal totalLoan = BigDecimal.ZERO; // Khởi tạo đúng kiểu BigDecimal
        String query = "SELECT SUM(amount) FROM LoanRequests WHERE customer_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal result = rs.getBigDecimal(1); // Lấy giá trị đúng kiểu
                    if (result != null) {
                        totalLoan = result;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalLoan;
    }

    public int getLoanCount(int customerId) {
        int loanCount = 0;
        String query = "SELECT COUNT(*) FROM LoanRequests WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    loanCount = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanCount;
    }

}
