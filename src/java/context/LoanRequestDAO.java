package context;

import context.DBContext;
import model.LoanRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.LoanPackage;
import model.auth.Staff;
import model.Asset;

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
        String sql = "INSERT INTO LoanRequests (customer_id, package_id, amount, request_date, status) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, model.getCustomerId());
            stmt.setInt(2, model.getPackageId());
            stmt.setBigDecimal(3, model.getAmount());
            stmt.setDate(4, new java.sql.Date(model.getRequestDate().getTime()));
            stmt.setString(5, model.getStatus());

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

    public boolean deleteLoanRequest(int requestId) {
        String sql = "DELETE FROM LoanRequests WHERE request_id = ? ";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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
    public boolean approveLoanRequest(int requestId, String notes) {
        String query = "UPDATE LoanRequests SET status = 'Approved', approved_by = ?, "
                + "approval_date = GETDATE(), approved_note = ? "
                + "WHERE request_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, notes);
            stmt.setInt(1, requestId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi phê duyệt yêu cầu vay: " + e.getMessage());
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

}
