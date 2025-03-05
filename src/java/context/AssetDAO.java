package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Asset;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 *
 * @author Asus
 */
public class AssetDAO extends DBContext<Asset> {

    // Trong AssetDAO
    public boolean insertAsset(Asset asset) {
        PreparedStatement stm = null;

        boolean success = false;

        try {

            String sql = "INSERT INTO CustomerAssets (customer_id, staff_id, asset_type, asset_name, asset_value, description, status, created_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP);";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, asset.getCustomerId());
            stm.setInt(2, asset.getStaffId());
            stm.setString(3, asset.getAssetType());
            stm.setString(4, asset.getAssetName());
            stm.setBigDecimal(5, asset.getAssetValue());
            stm.setString(6, asset.getDescription());
            stm.setString(7, asset.getStatus());

            int rowsAffected = stm.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            System.out.println("Error inserting asset: " + ex.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return success;
    }
    public boolean deleteAsset(int assetId) {
    String sql = "DELETE FROM CustomerAssets WHERE asset_id = ?";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        
        ps.setInt(1, assetId);
        int rowsAffected = ps.executeUpdate();
        
        return rowsAffected > 0;
        
    } catch (SQLException e) {
        System.out.println("Error closing resources: " + e.getMessage());
        return false;
    }
}

    @Override
    public void insert(Asset model) {
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "INSERT INTO CustomerAssets (customer_id, staff_id, asset_type, "
                    + "asset_name, asset_value, description, status, created_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            stm = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setInt(1, model.getCustomerId());
            stm.setInt(2, model.getStaffId());
            stm.setString(3, model.getAssetType());
            stm.setString(4, model.getAssetName());
            stm.setBigDecimal(5, model.getAssetValue());

            // Xử lý description có thể null
            if (model.getDescription() != null) {
                stm.setString(6, model.getDescription());
            } else {
//                stm.setNull(6, java.sql.Types.TEXT);
            }

            stm.setString(7, model.getStatus() != null ? model.getStatus() : "PENDING");

            // Xử lý ngày tạo
            if (model.getCreatedDate() != null) {
                stm.setTimestamp(8, new java.sql.Timestamp(model.getCreatedDate().getTime()));
            } else {
                stm.setTimestamp(8, new java.sql.Timestamp(System.currentTimeMillis()));
            }

            stm.executeUpdate();

            // Lấy ID tự sinh
            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                model.setAssetId(rs.getInt(1));
            }

        } catch (SQLException ex) {
            System.out.println("Error inserting asset: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }
    }

    @Override
    public void update(Asset model) {
        PreparedStatement stm = null;

        try {
            String sql = "UPDATE CustomerAssets SET customer_id = ?, staff_id = ?, "
                    + "asset_type = ?, asset_name = ?, asset_value = ?, description = ?, "
                    + "approved_by = ?, status = ?, approved_date = ?, note = ? "
                    + "WHERE asset_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getCustomerId());
            stm.setInt(2, model.getStaffId());
            stm.setString(3, model.getAssetType());
            stm.setString(4, model.getAssetName());
            stm.setBigDecimal(5, model.getAssetValue());

            // Xử lý description có thể null
            if (model.getDescription() != null) {
                stm.setString(6, model.getDescription());
            } else {
//                stm.setNull(6, java.sql.Types.TEXT);
            }

            // Xử lý approved_by có thể null - chuyển từ Integer sang String vì kiểu dữ liệu là nchar(10)
            if (model.getApprovedBy() != null) {
                stm.setString(7, model.getApprovedBy().toString());
            } else {
                stm.setNull(7, java.sql.Types.NCHAR);
            }

            stm.setString(8, model.getStatus());

            // Xử lý approved_date có thể null
            if (model.getApprovedDate() != null) {
                stm.setTimestamp(9, new java.sql.Timestamp(model.getApprovedDate().getTime()));
            } else {
                stm.setNull(9, java.sql.Types.TIMESTAMP);
            }

            // Xử lý notes có thể null (lưu vào trường note trong database)
            if (model.getNotes() != null) {
                stm.setString(10, model.getNotes());
            } else {
//                stm.setNull(10, java.sql.Types.TEXT);
            }

            stm.setInt(11, model.getAssetId());

            stm.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error updating asset: " + ex.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }
    }

    @Override
    public void delete(Asset model) {
        PreparedStatement stm = null;

        try {
            String sql = "DELETE FROM CustomerAssets WHERE asset_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getAssetId());

            stm.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error deleting asset: " + ex.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }
    }

    @Override
    public ArrayList<Asset> list() {
        ArrayList<Asset> assets = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT cs.asset_id, cs.customer_id, c.fullname AS customer_name, "
                    + "cs.staff_id, s.fullname AS staff_name, cs.asset_type, cs.asset_name, "
                    + "cs.asset_value, cs.approved_by, s2.fullname AS approved_by_name, "
                    + "cs.status, cs.created_date, cs.approved_date, cs.description, cs.note "
                    + "FROM CustomerAssets cs "
                    + "LEFT JOIN Customer c ON cs.customer_id = c.customer_id "
                    + "LEFT JOIN Staff s ON s.staff_id = cs.staff_id "
                    + "LEFT JOIN Staff s2 ON s2.staff_id = cs.approved_by "
                    + "ORDER BY cs.created_date DESC";

            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                Asset asset = new Asset();
                asset.setAssetId(rs.getInt("asset_id"));
                asset.setCustomerId(rs.getInt("customer_id"));
                asset.setStaffId(rs.getInt("staff_id"));
                asset.setAssetType(rs.getString("asset_type"));
                asset.setAssetName(rs.getString("asset_name"));
                asset.setAssetValue(rs.getBigDecimal("asset_value"));
                asset.setDescription(rs.getString("description"));

                // Xử lý approved_by có thể null - chuyển từ String sang Integer
                String approvedBy = rs.getString("approved_by");
                if (approvedBy != null && !approvedBy.trim().isEmpty()) {
                    try {
                        asset.setApprovedBy(Integer.parseInt(approvedBy.trim()));
                    } catch (NumberFormatException e) {
                        System.out.println("Error parsing approved_by: " + e.getMessage());
                    }
                }

                asset.setStatus(rs.getString("status"));
                asset.setCreatedDate(rs.getTimestamp("created_date"));
                asset.setApprovedDate(rs.getTimestamp("approved_date"));

                // Lấy note từ database và lưu vào notes trong model
                asset.setNotes(rs.getString("note"));

                // Thông tin bổ sung
                asset.setCustomerName(rs.getString("customer_name"));
                asset.setStaffName(rs.getString("staff_name"));
                asset.setApproverName(rs.getString("approved_by_name"));

                assets.add(asset);
            }

        } catch (SQLException ex) {
            System.out.println("Error listing assets: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return assets;
    }

    @Override
    public Asset get(int id) {
        Asset asset = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT cs.asset_id, cs.customer_id, c.fullname AS customer_name, "
                    + "cs.staff_id, s.fullname AS staff_name, cs.asset_type, cs.asset_name, "
                    + "cs.asset_value, cs.approved_by, s2.fullname AS approved_by_name, "
                    + "cs.status, cs.created_date, cs.approved_date, cs.description, cs.note "
                    + "FROM CustomerAssets cs "
                    + "LEFT JOIN Customer c ON cs.customer_id = c.customer_id "
                    + "LEFT JOIN Staff s ON s.staff_id = cs.staff_id "
                    + "LEFT JOIN Staff s2 ON s2.staff_id = cs.approved_by "
                    + "WHERE cs.asset_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                asset = new Asset();
                asset.setAssetId(rs.getInt("asset_id"));
                asset.setCustomerId(rs.getInt("customer_id"));
                asset.setStaffId(rs.getInt("staff_id"));
                asset.setAssetType(rs.getString("asset_type"));
                asset.setAssetName(rs.getString("asset_name"));
                asset.setAssetValue(rs.getBigDecimal("asset_value"));
                asset.setDescription(rs.getString("description"));

                // Xử lý approved_by có thể null - chuyển từ String sang Integer
                String approvedBy = rs.getString("approved_by");
                if (approvedBy != null && !approvedBy.trim().isEmpty()) {
                    try {
                        asset.setApprovedBy(Integer.parseInt(approvedBy.trim()));
                    } catch (NumberFormatException e) {
                        System.out.println("Error parsing approved_by: " + e.getMessage());
                    }
                }

                asset.setStatus(rs.getString("status"));
                asset.setCreatedDate(rs.getTimestamp("created_date"));
                asset.setApprovedDate(rs.getTimestamp("approved_date"));

                // Lấy note từ database và lưu vào notes trong model
                asset.setNotes(rs.getString("note"));

                // Thông tin bổ sung
                asset.setCustomerName(rs.getString("customer_name"));
                asset.setStaffName(rs.getString("staff_name"));
                asset.setApproverName(rs.getString("approved_by_name"));
            }

        } catch (SQLException ex) {
            System.out.println("Error getting asset: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return asset;
    }

    public boolean approveAsset(int assetId, int staffId, String note) {
        PreparedStatement stm = null;
        boolean success = false;

        try {
            String sql = "UPDATE CustomerAssets SET status = 'APPROVED', "
                    + "approved_by = ?, approved_date = CURRENT_TIMESTAMP, note = ? "
                    + "WHERE asset_id = ? AND status = 'PENDING'";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setString(2, note);
            stm.setInt(3, assetId);

            int rowsAffected = stm.executeUpdate();
            success = rowsAffected > 0;

            System.out.println("Approve Asset ID: " + assetId + ", Rows affected: " + rowsAffected);

        } catch (SQLException ex) {
            System.out.println("Error approving asset: " + ex.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return success;
    }

    public boolean rejectAsset(int assetId, int staffId, String reason) {
        PreparedStatement stm = null;
        boolean success = false;

        try {
            String sql = "UPDATE CustomerAssets SET status = 'REJECTED', "
                    + "approved_by = ?, approved_date = CURRENT_TIMESTAMP, note = ? "
                    + "WHERE asset_id = ? AND status = 'PENDING'";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setString(2, reason);
            stm.setInt(3, assetId);

            int rowsAffected = stm.executeUpdate();
            success = rowsAffected > 0;

            System.out.println("Reject Asset ID: " + assetId + ", Rows affected: " + rowsAffected);

        } catch (SQLException ex) {
            System.out.println("Error rejecting asset: " + ex.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return success;
    }

    // Phương thức bổ sung: Lấy danh sách tài sản theo trạng thái
    public ArrayList<Asset> getByStatus(String status) {
        ArrayList<Asset> assets = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT cs.asset_id, cs.customer_id, c.fullname AS customer_name, "
                    + "cs.staff_id, s.fullname AS staff_name, cs.asset_type, cs.asset_name, "
                    + "cs.asset_value, cs.approved_by, s2.fullname AS approved_by_name, "
                    + "cs.status, cs.created_date, cs.approved_date, cs.description, cs.note "
                    + "FROM CustomerAssets cs "
                    + "LEFT JOIN Customer c ON cs.customer_id = c.customer_id "
                    + "LEFT JOIN Staff s ON s.staff_id = cs.staff_id "
                    + "LEFT JOIN Staff s2 ON s2.staff_id = cs.approved_by "
                    + "WHERE cs.status = ? "
                    + "ORDER BY cs.created_date DESC";

            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();

            while (rs.next()) {
                Asset asset = new Asset();
                asset.setAssetId(rs.getInt("asset_id"));
                asset.setCustomerId(rs.getInt("customer_id"));
                asset.setStaffId(rs.getInt("staff_id"));
                asset.setAssetType(rs.getString("asset_type"));
                asset.setAssetName(rs.getString("asset_name"));
                asset.setAssetValue(rs.getBigDecimal("asset_value"));
                asset.setDescription(rs.getString("description"));

                // Xử lý approved_by có thể null - chuyển từ String sang Integer
                String approvedBy = rs.getString("approved_by");
                if (approvedBy != null && !approvedBy.trim().isEmpty()) {
                    try {
                        asset.setApprovedBy(Integer.parseInt(approvedBy.trim()));
                    } catch (NumberFormatException e) {
                        System.out.println("Error parsing approved_by: " + e.getMessage());
                    }
                }

                asset.setStatus(rs.getString("status"));
                asset.setCreatedDate(rs.getTimestamp("created_date"));
                asset.setApprovedDate(rs.getTimestamp("approved_date"));

                // Lấy note từ database và lưu vào notes trong model
                asset.setNotes(rs.getString("note"));

                // Thông tin bổ sung
                asset.setCustomerName(rs.getString("customer_name"));
                asset.setStaffName(rs.getString("staff_name"));
                asset.setApproverName(rs.getString("approved_by_name"));

                assets.add(asset);
            }

        } catch (SQLException ex) {
            System.out.println("Error getting assets by status: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return assets;
    }

    // Phương thức bổ sung: Lấy tổng số tài sản theo trạng thái
    public int countAssetsByStatus(String status) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;

        try {
            String sql = "SELECT COUNT(*) AS total FROM CustomerAssets WHERE status = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException ex) {
            System.out.println("Error counting assets by status: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return count;
    }

    // Phương thức bổ sung: Lấy tổng số tài sản
    public int countAllAssets() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;

        try {
            String sql = "SELECT COUNT(*) AS total FROM CustomerAssets";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException ex) {
            System.out.println("Error counting all assets: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return count;
    }

    // Phương thức bổ sung: Lấy danh sách tài sản theo nhiều điều kiện lọc
    public ArrayList<Asset> filter(String assetName, String assetType, String customerName,
            BigDecimal minValue, BigDecimal maxValue, String status,
            java.util.Date createdDateFrom, java.util.Date createdDateTo) {
        ArrayList<Asset> assets = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT cs.asset_id, cs.customer_id, c.fullname AS customer_name, ")
                    .append("cs.staff_id, s.fullname AS staff_name, cs.asset_type, cs.asset_name, ")
                    .append("cs.asset_value, cs.approved_by, s2.fullname AS approved_by_name, ")
                    .append("cs.status, cs.created_date, cs.approved_date, cs.description, cs.note ")
                    .append("FROM CustomerAssets cs ")
                    .append("LEFT JOIN Customer c ON cs.customer_id = c.customer_id ")
                    .append("LEFT JOIN Staff s ON s.staff_id = cs.staff_id ")
                    .append("LEFT JOIN Staff s2 ON s2.staff_id = cs.approved_by ")
                    .append("WHERE 1=1 ");

            ArrayList<Object> params = new ArrayList<>();

            if (assetName != null && !assetName.trim().isEmpty()) {
                sqlBuilder.append("AND cs.asset_name LIKE ? ");
                params.add("%" + assetName.trim() + "%");
            }

            if (assetType != null && !assetType.trim().isEmpty()) {
                sqlBuilder.append("AND cs.asset_type = ? ");
                params.add(assetType);
            }

            if (customerName != null && !customerName.trim().isEmpty()) {
                sqlBuilder.append("AND c.fullname LIKE ? ");
                params.add("%" + customerName.trim() + "%");
            }

            if (minValue != null) {
                sqlBuilder.append("AND cs.asset_value >= ? ");
                params.add(minValue);
            }

            if (maxValue != null) {
                sqlBuilder.append("AND cs.asset_value <= ? ");
                params.add(maxValue);
            }

            if (status != null && !status.trim().isEmpty()) {
                sqlBuilder.append("AND cs.status = ? ");
                params.add(status);
            }

            if (createdDateFrom != null) {
                sqlBuilder.append("AND cs.created_date >= ? ");
                params.add(new java.sql.Timestamp(createdDateFrom.getTime()));
            }

            if (createdDateTo != null) {
                sqlBuilder.append("AND cs.created_date <= ? ");
                params.add(new java.sql.Timestamp(createdDateTo.getTime()));
            }

            sqlBuilder.append("ORDER BY cs.created_date DESC");

            stm = connection.prepareStatement(sqlBuilder.toString());

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    stm.setString(i + 1, (String) param);
                } else if (param instanceof BigDecimal) {
                    stm.setBigDecimal(i + 1, (BigDecimal) param);
                } else if (param instanceof java.sql.Timestamp) {
                    stm.setTimestamp(i + 1, (java.sql.Timestamp) param);
                }
            }

            rs = stm.executeQuery();

            while (rs.next()) {
                Asset asset = new Asset();
                // Tương tự như trong phương thức list()
                asset.setAssetId(rs.getInt("asset_id"));
                asset.setCustomerId(rs.getInt("customer_id"));
                asset.setStaffId(rs.getInt("staff_id"));
                asset.setAssetType(rs.getString("asset_type"));
                asset.setAssetName(rs.getString("asset_name"));
                asset.setAssetValue(rs.getBigDecimal("asset_value"));
                asset.setDescription(rs.getString("description"));

                // Xử lý approved_by có thể null
                String approvedBy = rs.getString("approved_by");
                if (approvedBy != null && !approvedBy.trim().isEmpty()) {
                    try {
                        asset.setApprovedBy(Integer.parseInt(approvedBy.trim()));
                    } catch (NumberFormatException e) {
                        System.out.println("Error parsing approved_by: " + e.getMessage());
                    }
                }

                asset.setStatus(rs.getString("status"));
                asset.setCreatedDate(rs.getTimestamp("created_date"));
                asset.setApprovedDate(rs.getTimestamp("approved_date"));
                asset.setNotes(rs.getString("note"));

                // Thông tin bổ sung
                asset.setCustomerName(rs.getString("customer_name"));
                asset.setStaffName(rs.getString("staff_name"));
                asset.setApproverName(rs.getString("approved_by_name"));

                assets.add(asset);
            }

        } catch (SQLException ex) {
            System.out.println("Error filtering assets: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing resources: " + ex.getMessage());
            }
        }

        return assets;
    }

    public ArrayList<Asset> searchAssets(String assetName, String assetType, String customerName,
            BigDecimal minValue, BigDecimal maxValue, String status,
            String createdDateFrom, String createdDateTo,
            String approvedBy, String approvedDateFrom, String approvedDateTo) {
        ArrayList<Asset> assets = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT a.asset_id, a.customer_id, a.staff_id, a.asset_type, a.asset_name, "
                + "a.asset_value, a.description, a.approved_by, a.status, a.created_date, "
                + "a.approved_date, a.note, c.fullname AS customer_name, "
                + "s.fullname AS staff_name, s2.fullname AS approver_name "
                + "FROM CustomerAssets a "
                + "LEFT JOIN Customer c ON a.customer_id = c.customer_id "
                + "LEFT JOIN Staff s ON s.staff_id = a.staff_id "
                + "LEFT JOIN Staff s2 ON s2.staff_id = a.approved_by "
                + "WHERE 1=1");

        ArrayList<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm cơ bản
        addSearchConditions(sql, params, assetName, assetType, customerName,
                minValue, maxValue, status, createdDateFrom, createdDateTo, approvedDateFrom, approvedDateTo);

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

        // In câu SQL để debug
        System.out.println("Search SQL: " + sql.toString());
        System.out.println("Search params: " + params);

        // Thêm sắp xếp
        sql.append(" ORDER BY a.created_date DESC");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                try {
                    Asset asset = new Asset();
                    // Map dữ liệu từ ResultSet vào đối tượng Asset
                    int assetId = rs.getInt("asset_id");
                    String assetStatus = rs.getString("status");
                    String noteValue = rs.getString("note");

                    System.out.println("Đang xử lý asset ID: " + assetId + ", Status: " + assetStatus + ", Note: " + noteValue);

                    asset.setAssetId(assetId);
                    asset.setCustomerId(rs.getInt("customer_id"));
                    asset.setStaffId(rs.getInt("staff_id"));
                    asset.setAssetType(rs.getString("asset_type"));
                    asset.setAssetName(rs.getString("asset_name"));
                    asset.setAssetValue(rs.getBigDecimal("asset_value"));
                    asset.setDescription(rs.getString("description"));

                    // Xử lý các trường có thể NULL
                    Object approvedByObj = rs.getObject("approved_by");
                    if (approvedByObj != null) {
                        if (approvedByObj instanceof String) {
                            try {
                                asset.setApprovedBy(Integer.parseInt((String) approvedByObj));
                            } catch (NumberFormatException e) {
                                System.err.println("Lỗi chuyển đổi approved_by: " + e.getMessage());
                            }
                        } else {
                            asset.setApprovedBy((Integer) approvedByObj);
                        }
                    }

                    asset.setStatus(assetStatus);
                    asset.setCreatedDate(rs.getTimestamp("created_date"));

                    java.sql.Timestamp approvedDateValue = rs.getTimestamp("approved_date");
                    if (approvedDateValue != null) {
                        asset.setApprovedDate(approvedDateValue);
                    }

                    asset.setNotes(noteValue);

                    asset.setCustomerName(rs.getString("customer_name"));
                    asset.setStaffName(rs.getString("staff_name"));
                    asset.setApproverName(rs.getString("approver_name"));

                    assets.add(asset);
                    count++;
                } catch (Exception e) {
                    System.err.println("Lỗi khi mapping asset: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            System.out.println("Tìm thấy " + count + " assets");
        } catch (SQLException e) {
            System.err.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }

        return assets;
    }

    // Helper method to convert asset type codes to display text
    private String getAssetTypeDisplay(String assetType) {
        switch (assetType) {
            case "REAL_ESTATE":
                return "Bất động sản";
            case "VEHICLE":
                return "Phương tiện";
            case "INCOME":
                return "Thu nhập";
            case "OTHER":
                return "Khác";
            default:
                return assetType;
        }
    }

    private void addSearchConditions(
            StringBuilder sql, ArrayList<Object> params,
            String assetName, String assetType, String customerName,
            BigDecimal minValue, BigDecimal maxValue, String status,
            String createdDateFrom, String createdDateTo,
            String approvedDateFrom, String approvedDateTo) {

        if (assetName != null && !assetName.isEmpty()) {
            sql.append(" AND a.asset_name LIKE ?");
            params.add("%" + assetName + "%");
        }

        if (assetType != null && !assetType.isEmpty()) {
            sql.append(" AND a.asset_type = ?");
            params.add(assetType);
        }

        if (customerName != null && !customerName.isEmpty()) {
            sql.append(" AND c.fullname LIKE ?");
            params.add("%" + customerName + "%");
        }

        if (minValue != null) {
            sql.append(" AND a.asset_value >= ?");
            params.add(minValue);
        }

        if (maxValue != null) {
            sql.append(" AND a.asset_value <= ?");
            params.add(maxValue);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND a.status = ?");
            params.add(status);
        }

        if (createdDateFrom != null && !createdDateFrom.isEmpty()) {
            sql.append(" AND a.created_date >= ?");
            params.add(createdDateFrom);
        }

        if (createdDateTo != null && !createdDateTo.isEmpty()) {
            sql.append(" AND a.created_date <= ?");
            params.add(createdDateTo);
        }

        if (approvedDateFrom != null && !approvedDateFrom.isEmpty()) {
            sql.append(" AND a.approved_date >= ?");
            params.add(approvedDateFrom);
        }

        if (approvedDateTo != null && !approvedDateTo.isEmpty()) {
            sql.append(" AND a.approved_date <= ?");
            params.add(approvedDateTo);
        }
    }

}
