/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lenovo
 */
public class LoanPayment {

    private int month;
    private double beginningBalance;
    private double principalPayment;
    private double interestPayment;
    private double totalPayment;
    private double endingBalance;

    public LoanPayment() {
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public void setBeginningBalance(double beginningBalance) {
        this.beginningBalance = beginningBalance;
    }

    public void setPrincipalPayment(double principalPayment) {
        this.principalPayment = principalPayment;
    }

    public void setInterestPayment(double interestPayment) {
        this.interestPayment = interestPayment;
    }

    public void setTotalPayment(double totalPayment) {
        this.totalPayment = totalPayment;
    }

    public void setEndingBalance(double endingBalance) {
        this.endingBalance = endingBalance;
    }

    
    
    public LoanPayment(int month, double beginningBalance, double principalPayment, double interestPayment, double totalPayment, double endingBalance) {
        this.month = month;
        this.beginningBalance = beginningBalance;
        this.principalPayment = principalPayment;
        this.interestPayment = interestPayment;
        this.totalPayment = totalPayment;
        this.endingBalance = endingBalance;
    }

    public int getMonth() {
        return month;
    }

    public double getBeginningBalance() {
        return beginningBalance;
    }

    public double getPrincipalPayment() {
        return principalPayment;
    }

    public double getInterestPayment() {
        return interestPayment;
    }

    public double getTotalPayment() {
        return totalPayment;
    }

    public double getEndingBalance() {
        return endingBalance;
    }
    
    
}
