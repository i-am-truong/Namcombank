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
public class Transaction {
    private int transactionId;
    private int scheduleId;
    private int loanId;
    private double amount;
    private Date transactionDate;
    private String type;
    private int savingsId;

    public Transaction() {
    }

    public Transaction(int transactionId, int scheduleId, int loanId, double amount, Date transactionDate, String type, int savingsId) {
        this.transactionId = transactionId;
        this.scheduleId = scheduleId;
        this.loanId = loanId;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.type = type;
        this.savingsId = savingsId;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getSavingsId() {
        return savingsId;
    }

    public void setSavingsId(int savingsId) {
        this.savingsId = savingsId;
    }

    @Override
    public String toString() {
        return "Transaction{" + "transactionId=" + transactionId + ", scheduleId=" + scheduleId + ", loanId=" + loanId + ", amount=" + amount + ", transactionDate=" + transactionDate + ", type=" + type + ", savingsId=" + savingsId + '}';
    }
    
    
}
