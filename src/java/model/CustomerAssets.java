/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author TQT
 */
public class CustomerAssets {
    private int assetId;
    private int customerId;
    private int staffId;
    private String assetName;
    private double assetValue;
    private String approvedBy;
    private String status;
    private Date createdDate;
    private Date approvedDate;

    public CustomerAssets() {
    }

    public CustomerAssets(int assetId, int customerId, int staffId, String assetName, double assetValue, String approvedBy, String status, Date createdDate, Date approvedDate) {
        this.assetId = assetId;
        this.customerId = customerId;
        this.staffId = staffId;
        this.assetName = assetName;
        this.assetValue = assetValue;
        this.approvedBy = approvedBy;
        this.status = status;
        this.createdDate = createdDate;
        this.approvedDate = approvedDate;
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

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public double getAssetValue() {
        return assetValue;
    }

    public void setAssetValue(double assetValue) {
        this.assetValue = assetValue;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
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

    @Override
    public String toString() {
        return "CustomerAssets{" + "assetId=" + assetId + ", customerId=" + customerId + ", staffId=" + staffId + ", assetName=" + assetName + ", assetValue=" + assetValue + ", approvedBy=" + approvedBy + ", status=" + status + ", createdDate=" + createdDate + ", approvedDate=" + approvedDate + '}';
    }
    
    
}
