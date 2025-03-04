package model;

import java.math.BigDecimal;
import java.util.Date;

public class Asset {
    private int assetId;
    private int customerId;
    private int staffId;
    private String assetType;
    private String assetName;
    private BigDecimal assetValue;
    private String description;
    private Integer approvedBy;
    private String status;
    private Date createdDate;
    private Date approvedDate;
    private String notes;
    
    // Thông tin bổ sung (không lưu trong DB)
    private String customerName;
    private String staffName;
    private String approverName;

    public Asset(int assetId, int customerId, int staffId, String assetType, String assetName, BigDecimal assetValue, String description, Integer approvedBy, String status, Date createdDate, Date approvedDate, String notes, String customerName, String staffName, String approverName) {
        this.assetId = assetId;
        this.customerId = customerId;
        this.staffId = staffId;
        this.assetType = assetType;
        this.assetName = assetName;
        this.assetValue = assetValue;
        this.description = description;
        this.approvedBy = approvedBy;
        this.status = status;
        this.createdDate = createdDate;
        this.approvedDate = approvedDate;
        this.notes = notes;
        this.customerName = customerName;
        this.staffName = staffName;
        this.approverName = approverName;
    }
    
    public int getAssetId() {    
        return assetId;
    }

    public void setAssetId(int assetId) {
        this.assetId = assetId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getAssetType() {
        return assetType;
    }

    public void setAssetType(String assetType) {
        this.assetType = assetType;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public BigDecimal getAssetValue() {
        return assetValue;
    }

    public void setAssetValue(BigDecimal assetValue) {
        this.assetValue = assetValue;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(Integer approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(Date approvedDate) {
        this.approvedDate = approvedDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getApproverName() {
        return approverName;
    }

    // Constructors, getters, setters
    public void setApproverName(String approverName) {    
        this.approverName = approverName;
    }

    // Constructor mặc định
    public Asset() {
        this.status = "PENDING";
        this.createdDate = new Date();
    }
    
    // Business methods
    public boolean isPending() {
        return "PENDING".equals(this.status);
    }
    
    public boolean isApproved() {
        return "APPROVED".equals(this.status);
    }
    
    public boolean isRejected() {
        return "REJECTED".equals(this.status);
    }
    
    public void approve(int staffId) {
        this.approvedBy = staffId;
        this.status = "APPROVED";
        this.approvedDate = new Date();
    }
    
    public void reject(int staffId, String reason) {
        this.approvedBy = staffId;
        this.status = "REJECTED";
        this.approvedDate = new Date();
        this.notes = reason;
    }
}
