/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
/**
 *
 * @author lenovo
 */
public class LoanPackage {
    private int packageId;
    private int staffId;
    private String packageName;
    private String loanType;
    private String description;
    private double interestRate;
    private double maxAmount;
    private double minAmount;
    private int loanTerm;
    private Date createdDate;

    public LoanPackage() {
        
    }

    public LoanPackage(int packageId, int staffId, String packageName, String loanType, String description, double interestRate, double maxAmount, double minAmount, int loanTerm, Date createdDate) {
        this.packageId = packageId;
        this.staffId = staffId;
        this.packageName = packageName;
        this.loanType = loanType;
        this.description = description;
        this.interestRate = interestRate;
        this.maxAmount = maxAmount;
        this.minAmount = minAmount;
        this.loanTerm = loanTerm;
        this.createdDate = createdDate;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getLoanType() {
        return loanType;
    }

    public void setLoanType(String loanType) {
        this.loanType = loanType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    public double getMaxAmount() {
        return maxAmount;
    }

    public void setMaxAmount(double maxAmount) {
        this.maxAmount = maxAmount;
    }

    public double getMinAmount() {
        return minAmount;
    }

    public void setMinAmount(double minAmount) {
        this.minAmount = minAmount;
    }

    public int getLoanTerm() {
        return loanTerm;
    }

    public void setLoanTerm(int loanTerm) {
        this.loanTerm = loanTerm;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    
    
}
