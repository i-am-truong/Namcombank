/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import java.util.Date;


public class LoanRequest {

    private int requestId;
    private int loanId;
    private int staffId;
    private int customerId;
    private String approvalStatus;
    private Date approvalDate;
    private String approvedBy;

    // Các thông tin bổ sung để hiển thị
    private String customerName;
    private Double loanAmount;
    private String staffName;

    public LoanRequest() {
    }

    public LoanRequest(int requestId, int loanId, int staffId, int customerId, String approvalStatus, Date approvalDate, String approvedBy, String customerName, Double loanAmount, String staffName) {
        this.requestId = requestId;
        this.loanId = loanId;
        this.staffId = staffId;
        this.customerId = customerId;
        this.approvalStatus = approvalStatus;
        this.approvalDate = approvalDate;
        this.approvedBy = approvedBy;
        this.customerName = customerName;
        this.loanAmount = loanAmount;
        this.staffName = staffName;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
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

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Double getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(Double loanAmount) {
        this.loanAmount = loanAmount;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    
    
}
