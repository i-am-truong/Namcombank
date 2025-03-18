package model;

import java.math.BigDecimal;
import java.util.Date;

public class CreditCard {

    private int cardId;
    private int customerId;
    private String cardNumber;
    private String cvv;
    private Date expiryDate;
    private BigDecimal creditLimit;
    private BigDecimal availableBalance;
    private String status;

    public CreditCard() {
    }
    
    

    public CreditCard(int cardId, int customerId, String cardNumber, String cvv, Date expiryDate, BigDecimal creditLimit, BigDecimal availableBalance, String status) {
        this.cardId = cardId;
        this.customerId = customerId;
        this.cardNumber = cardNumber;
        this.cvv = cvv;
        this.expiryDate = expiryDate;
        this.creditLimit = creditLimit;
        this.availableBalance = availableBalance;
        this.status = status;
    }

    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public BigDecimal getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(BigDecimal creditLimit) {
        this.creditLimit = creditLimit;
    }

    public BigDecimal getAvailableBalance() {
        return availableBalance;
    }

    public void setAvailableBalance(BigDecimal availableBalance) {
        this.availableBalance = availableBalance;
    }

    public String getStatus() {
        return status;
    } 

    public void setStatus(String status) {
        this.status = status;
    }
}
