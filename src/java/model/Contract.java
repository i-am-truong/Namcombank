/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lenovo
 */
public class Contract {

    private int id;
    private String customerName; // Tên khách hàng (Customers)
    private String loanName; // Tên khoản vay (Loans)
    private String packageName; // Tên gói vay (LoanPackages)
    private double amount;
    private String status;

    public Contract() {
    }

    public Contract(int id, String customerName, String loanName, String packageName, double amount, String status) {
        this.id = id;
        this.customerName = customerName;
        this.loanName = loanName;
        this.packageName = packageName;
        this.amount = amount;
        this.status = status;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getLoanName() {
        return loanName;
    }

    public String getPackageName() {
        return packageName;
    }

    public double getAmount() {
        return amount;
    }

    public String getStatus() {
        return status;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public void setLoanName(String loanName) {
        this.loanName = loanName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
