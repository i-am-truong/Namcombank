package model;

import java.util.Date;

public class LoanRequest {
    private int requestId;
    private int customerId;
    private int packageId;
    private double amount;
    private Date requestDate;
    private String status;
    private int staffId;
    private Date approvalDate;
    private String approvedBy;
    private String notes;

    public LoanRequest() {
    }

    public LoanRequest(int requestId, int customerId, int packageId, double amount, Date requestDate, String status, int staffId, Date approvalDate, String approvedBy, String notes) {
        this.requestId = requestId;
        this.customerId = customerId;
        this.packageId = packageId;
        this.amount = amount;
        this.requestDate = requestDate;
        this.status = status;
        this.staffId = staffId;
        this.approvalDate = approvalDate;
        this.approvedBy = approvedBy;
        this.notes = notes;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    
}
