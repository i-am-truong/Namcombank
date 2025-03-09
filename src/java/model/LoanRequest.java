package model;

import java.util.Date;
import model.auth.Staff;

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
    private String start_date;
    private String end_date;

    private Staff staff;
    private LoanPackage loanPackage;
    private Customer customer;
    private Asset asset;

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public LoanPackage getLoanPackage() {
        return loanPackage;
    }

    public void setLoanPackage(LoanPackage loanPackage) {
        this.loanPackage = loanPackage;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Asset getAsset() {
        return asset;
    }

    public void setAsset(Asset asset) {
        this.asset = asset;
    }
    
    

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
