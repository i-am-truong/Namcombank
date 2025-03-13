/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Saving {

    private int savings_id;
    private int customer_id;
    private double amount;
    private double interest_rate;
    private int term_months;
    private String opened_date;
    private String status;
    private int saving_request_id;
    private int staff_id;
    private String money_get_date;
    private String customer_name;

    public Saving() {
    }

    public Saving(int savings_id, int customer_id, double amount, double interest_rate, int term_months, String opened_date, String status, int saving_request_id, int staff_id, String money_get_date, String customer_name) {
        this.savings_id = savings_id;
        this.customer_id = customer_id;
        this.amount = amount;
        this.interest_rate = interest_rate;
        this.term_months = term_months;
        this.opened_date = opened_date;
        this.status = status;
        this.saving_request_id = saving_request_id;
        this.staff_id = staff_id;
        this.money_get_date = money_get_date;
        this.customer_name = customer_name;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public int getSavings_id() {
        return savings_id;
    }

    public void setSavings_id(int savings_id) {
        this.savings_id = savings_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getInterest_rate() {
        return interest_rate;
    }

    public void setInterest_rate(double interest_rate) {
        this.interest_rate = interest_rate;
    }

    public int getTerm_months() {
        return term_months;
    }

    public void setTerm_months(int term_months) {
        this.term_months = term_months;
    }

    public String getOpened_date() {
        return opened_date;
    }

    public void setOpened_date(String opened_date) {
        this.opened_date = opened_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getSaving_request_id() {
        return saving_request_id;
    }

    public void setSaving_request_id(int saving_request_id) {
        this.saving_request_id = saving_request_id;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public String getMoney_get_date() {
        return money_get_date;
    }

    public void setMoney_get_date(String money_get_date) {
        this.money_get_date = money_get_date;
    }

}
