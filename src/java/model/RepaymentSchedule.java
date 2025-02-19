/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class RepaymentSchedule {

    private int id;
    private int loanId;
    private String status;
    private String dueDate;
    private float amountDue;
    private Customer customer;
    private String packageName;

    public RepaymentSchedule() {
    }

    public RepaymentSchedule(int id, int loanId, String status, String dueDate, float amountDue) {
        this.id = id;
        this.loanId = loanId;
        this.status = status;
        this.dueDate = dueDate;
        this.amountDue = amountDue;
    }

    public RepaymentSchedule(int id, int loanId, String status, String dueDate, float amountDue, Customer customer, String packageName) {
        this.id = id;
        this.loanId = loanId;
        this.status = status;
        this.dueDate = dueDate;
        this.amountDue = amountDue;
        this.customer = customer;
        this.packageName = packageName;
    }


    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public float getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(float amountDue) {
        this.amountDue = amountDue;
    }

}
