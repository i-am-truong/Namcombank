package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class PaymentHistory {
    private int scheduleId;
    private String status;
    private Date dueDate;
    private BigDecimal amountDue;
    private int requestId;
    private Date transactionDate;
    private int customerId;
    
    // Constructors
    public PaymentHistory() {
    }
    
    public PaymentHistory(int scheduleId, String status, Date dueDate, BigDecimal amountDue, 
            int requestId, Date transactionDate, int customerId) {
        this.scheduleId = scheduleId;
        this.status = status;
        this.dueDate = dueDate;
        this.amountDue = amountDue;
        this.requestId = requestId;
        this.transactionDate = transactionDate;
        this.customerId = customerId;
    }
    
    // Getters and Setters
    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
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

    public BigDecimal getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(BigDecimal amountDue) {
        this.amountDue = amountDue;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
}
