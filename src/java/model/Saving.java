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
public class Saving {
    private int savingsId;
    private int customerId;
    private double amount;
    private double interestRate;
    private int termMonths;
    private Date openedDate;
    private String status;

    public Saving() {
    }

    public Saving(int savingsId, int customerId, double amount, double interestRate, int termMonths, Date openedDate, String status) {
        this.savingsId = savingsId;
        this.customerId = customerId;
        this.amount = amount;
        this.interestRate = interestRate;
        this.termMonths = termMonths;
        this.openedDate = openedDate;
        this.status = status;
    }

    public int getSavingsId() {
        return savingsId;
    }

    public void setSavingsId(int savingsId) {
        this.savingsId = savingsId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    public int getTermMonths() {
        return termMonths;
    }

    public void setTermMonths(int termMonths) {
        this.termMonths = termMonths;
    }

    public Date getOpenedDate() {
        return openedDate;
    }

    public void setOpenedDate(Date openedDate) {
        this.openedDate = openedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Saving{" + "savingsId=" + savingsId + ", customerId=" + customerId + ", amount=" + amount + ", interestRate=" + interestRate + ", termMonths=" + termMonths + ", openedDate=" + openedDate + ", status=" + status + '}';
    }
    
    
}
