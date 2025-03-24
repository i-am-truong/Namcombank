/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.auth.Staff;
import java.math.BigDecimal;
import java.util.Date;

public class Transaction {
    private int transactionId;
    private Integer scheduleId;
    private Integer requestId;
    private BigDecimal amount;
    private Date transactionDate;
    private String type;
    private Integer customerId;
    private Integer staffId;
    
    // Related entities
    private Customer customer;
    private Staff staff;
    private RepaymentSchedule repaymentSchedule;
    
    // Default constructor
    public Transaction() {
    }
    
    // Constructor with primary fields
    public Transaction(int transactionId, Integer scheduleId, Integer requestId, 
                      BigDecimal amount, Date transactionDate, String type, 
                      Integer customerId, Integer staffId) {
        this.transactionId = transactionId;
        this.scheduleId = scheduleId;
        this.requestId = requestId;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.type = type;
        this.customerId = customerId;
        this.staffId = staffId;
    }
    
    // Getters and Setters
    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public Integer getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(Integer scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
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

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getStaffId() {
        return staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
        if (customer != null) {
            this.customerId = customer.getCustomerId();
        }
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
        if (staff != null) {
            this.staffId = staff.getId();
        }
    }

    public RepaymentSchedule getRepaymentSchedule() {
        return repaymentSchedule;
    }

    public void setRepaymentSchedule(RepaymentSchedule repaymentSchedule) {
        this.repaymentSchedule = repaymentSchedule;
        if (repaymentSchedule != null) {
            this.scheduleId = repaymentSchedule.getSchedule_id();
        }
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "transactionId=" + transactionId +
                ", scheduleId=" + scheduleId +
                ", requestId=" + requestId +
                ", amount=" + amount +
                ", transactionDate=" + transactionDate +
                ", type='" + type + '\'' +
                ", customerId=" + customerId +
                ", staffId=" + staffId +
                '}';
    }
}


