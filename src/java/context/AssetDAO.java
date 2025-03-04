/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.security.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Asset;
import org.jsoup.Connection;
import java.sql.*;
import java.util.ArrayList;
import java.math.BigDecimal;

/**
 *
 * @author Asus
 */
public class AssetDAO extends DBContext<Asset> {

    @Override
    public void insert(Asset model) {
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "INSERT INTO CustomerAssets (customer_id, staff_id, asset_type, "
                    + "asset_name, asset_value, description, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            stm = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setInt(1, model.getCustomerId());
            stm.setInt(2, model.getStaffId());
            stm.setString(3, model.getAssetType());
            stm.setString(4, model.getAssetName());
            stm.setBigDecimal(5, model.getAssetValue());
            stm.setString(6, model.getDescription());
            stm.setString(7, model.getStatus() != null ? model.getStatus() : "PENDING");

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
                    + "approved_by = ?, status = ?, approved_date = ?, notes = ? "
                    + "WHERE asset_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getCustomerId());
            stm.setInt(2, model.getStaffId());
            stm.setString(3, model.getAssetType());
            stm.setString(4, model.getAssetName());
            stm.setBigDecimal(5, model.getAssetValue());
            stm.setString(6, model.getDescription());

            if (model.getApprovedBy() != null) {
                stm.setInt(7, model.getApprovedBy());
            } else {
                stm.setNull(7, java.sql.Types.INTEGER);
            }

            stm.setString(8, model.getStatus());

            if (model.getApprovedDate() != null) {
                stm.setTimestamp(9, new java.sql.Timestamp(model.getApprovedDate().getTime()));
            } else {
                stm.setNull(9, java.sql.Types.TIMESTAMP);
            }

            stm.setString(10, model.getNotes());
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
                    + "cs.status, cs.created_date, cs.approved_date, cs.description, cs.notes "
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

                // Xử lý các trường có thể null
                if (rs.getObject("approved_by") != null) {
                    asset.setApprovedBy(rs.getInt("approved_by"));
                }

                asset.setStatus(rs.getString("status"));
                asset.setCreatedDate(rs.getTimestamp("created_date"));
                asset.setApprovedDate(rs.getTimestamp("approved_date"));
                asset.setNotes(rs.getString("notes"));

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
                    + "cs.status, cs.created_date, cs.approved_date, cs.description, cs.notes "
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

                // Xử lý các trường có thể null
                if (rs.getObject("approved_by") != null) {
                    asset.setApprovedBy(rs.getInt("approved_by"));
                }

                asset.setStatus(rs.getString("status"));
                asset.setCreatedDate(rs.getTimestamp("created_date"));
                asset.setApprovedDate(rs.getTimestamp("approved_date"));
                asset.setNotes(rs.getString("notes"));

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

    // Phương thức bổ sung: Duyệt tài sản
    public boolean approveAsset(int assetId, int staffId, String note) {
        PreparedStatement stm = null;
        boolean success = false;

        try {
            String sql = "UPDATE CustomerAssets SET status = 'APPROVED', "
                    + "approved_by = ?, approved_date = GETDATE(), notes = ? "
                    + "WHERE asset_id = ? AND status = 'PENDING'";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setString(2, note);
            stm.setInt(3, assetId);

            int rowsAffected = stm.executeUpdate();
            success = rowsAffected > 0;

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

    // Phương thức bổ sung: Từ chối tài sản
    public boolean rejectAsset(int assetId, int staffId, String reason) {
        PreparedStatement stm = null;
        boolean success = false;

        try {
            String sql = "UPDATE CustomerAssets SET status = 'REJECTED', "
                    + "approved_by = ?, approved_date = GETDATE(), notes = ? "
                    + "WHERE asset_id = ? AND status = 'PENDING'";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setString(2, reason);
            stm.setInt(3, assetId);

            int rowsAffected = stm.executeUpdate();
            success = rowsAffected > 0;

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
                    + "cs.status, cs.created_date, cs.approved_date, cs.description, cs.notes "
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
                // Tương tự như trong phương thức list()
                // ...
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
}
