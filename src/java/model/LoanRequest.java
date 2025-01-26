/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;

/**
 *
 * @author TQT
 */
public class LoanRequest {
    private int requestId;
    private int loanId;
    private int staffId;
    private String approvalStatus;
    private Timestamp approvalDate;
    private String approvedBy;

    public LoanRequest() {
    }

    public LoanRequest(int requestId, int loanId, int staffId, String approvalStatus, Timestamp approvalDate, String approvedBy) {
        this.requestId = requestId;
        this.loanId = loanId;
        this.staffId = staffId;
        this.approvalStatus = approvalStatus;
        this.approvalDate = approvalDate;
        this.approvedBy = approvedBy;
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

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public Timestamp getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Timestamp approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    @Override
    public String toString() {
        return "LoanRequest{" + "requestId=" + requestId + ", loanId=" + loanId + ", staffId=" + staffId + ", approvalStatus=" + approvalStatus + ", approvalDate=" + approvalDate + ", approvedBy=" + approvedBy + '}';
    }
    
    
}
