/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author lenovo
 */
public class Customer {
    private int customerId;
    private String fullname;
    private String username;
    private String password;
    private Boolean active;
    private String email;
    private Date dob;
    private Boolean gender;
    private String phonenumber;
    private float balance;
    private int cic;

    public Customer() {
    }

    public Customer(int customerId, String fullname, String username, String password, Boolean active, String email, Date dob, Boolean gender, String phonenumber, float balance, int cic) {
        this.customerId = customerId;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.active = active;
        this.email = email;
        this.dob = dob;
        this.gender = gender;
        this.phonenumber = phonenumber;
        this.balance = balance;
        this.cic = cic;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public int getCic() {
        return cic;
    }

    public void setCic(int cic) {
        this.cic = cic;
    }
    
    
}
