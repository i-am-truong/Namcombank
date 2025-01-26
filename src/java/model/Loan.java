/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TQT
 */
public class Loan {
    private int loanId;
    private int customerId;
    private int packageId;
    private String amount;
    private String startDate;
    private String endDate;
    private String status;

    public Loan() {
    }

    public Loan(int loanId, int customerId, int packageId, String amount, String startDate, String endDate, String status) {
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

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Loan{" + "loanId=" + loanId + ", customerId=" + customerId + ", packageId=" + packageId + ", amount=" + amount + ", startDate=" + startDate + ", endDate=" + endDate + ", status=" + status + '}';
    }
    
    
}
