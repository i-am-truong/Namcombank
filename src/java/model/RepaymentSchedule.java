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
public class RepaymentSchedule {
    private int scheduleId;
    private int loanId;
    private String status;
    private Date dueDate;
    private double amountDue;

    public RepaymentSchedule() {
    }

    public RepaymentSchedule(int scheduleId, int loanId, String status, Date dueDate, double amountDue) {
        this.scheduleId = scheduleId;
        this.loanId = loanId;
        this.status = status;
        this.dueDate = dueDate;
        this.amountDue = amountDue;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public double getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(double amountDue) {
        this.amountDue = amountDue;
    }

    @Override
    public String toString() {
        return "RepaymentSchedule{" + "scheduleId=" + scheduleId + ", loanId=" + loanId + ", status=" + status + ", dueDate=" + dueDate + ", amountDue=" + amountDue + '}';
    }
    
    
}
