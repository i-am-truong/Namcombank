/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Date;

public class RepaymentSchedule {

    private int schedule_id;

    private String status;
    private Date dueDate;
    private BigDecimal amountDue;
    private int requestId;
    private int customerId;
    private LoanRequest loanRequest;

    // Add these fields to RepaymentSchedule.java
    private long daysDifference;
    private boolean paymentAvailable;

    public RepaymentSchedule() {
    }


    public long getDaysDifference() {
        return daysDifference;
    }

    public void setDaysDifference(long daysDifference) {
        this.daysDifference = daysDifference;
    }

    public boolean isPaymentAvailable() {
        return paymentAvailable;
    }

    public void setPaymentAvailable(boolean paymentAvailable) {
        this.paymentAvailable = paymentAvailable;
    }

    public int getSchedule_id() {
        return schedule_id;
    }

    public void setSchedule_id(int schedule_id) {
        this.schedule_id = schedule_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(BigDecimal amountDue) {
        this.amountDue = amountDue;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
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

    public LoanRequest getLoanRequest() {
        return loanRequest;
    }

    public void setLoanRequest(LoanRequest loanRequest) {
        this.loanRequest = loanRequest;
    }

}
