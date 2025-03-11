package model;

import java.util.Date;

public class Loan {
    private int loanId;
    private int customerId;
    private int packageId;
    private double amount;
    private Date startDate;
    private Date endDate;
    private String status;
    
    public Loan() {
    }
    
    public Loan(int loanId, int customerId, int packageId, double amount, Date startDate, Date endDate, String status) {
        this.loanId = loanId;
        this.customerId = customerId;
        this.packageId = packageId;
        this.amount = amount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
