package model;

import java.math.BigDecimal;
import java.util.Date;
import model.auth.Staff;

public class LoanRequest {

    private int requestId;
    private int customerId;
    private int packageId;
    private BigDecimal amount;
    private Date requestDate;
    private String status;
    private int staffId;
    private Date approvalDate;
    private String approvedBy;
    private String notes;
    private Date startDate;
    private Date endDate;

    private Staff staff;
    private LoanPackage loanPackage;
    private Customer customer;
    private Asset asset;

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
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

    // Constructor dành cho việc tạo yêu cầu vay mới (chưa có duyệt)
    public LoanRequest(int customerId, int packageId, BigDecimal amount, Date requestDate, String status) {
        this.customerId = customerId;
        this.packageId = packageId;
        this.amount = amount;
        this.requestDate = requestDate;
        this.status = status;
    }

    // Constructor đầy đủ (dùng khi lấy từ database)
    public LoanRequest(int requestId, int customerId, int packageId, BigDecimal amount, Date requestDate, String status, int staffId, Date approvalDate, String approvedBy, String notes, Date start_date, Date endDate) {
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
        this.startDate = startDate;
        this.endDate = endDate;
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

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
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
