/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author lenovo
 */
public class Customer {

    private int customerId;
    private String fullname;
    private String username;
    private String password;
    private int active;
    private String email;
    private Date dob;
    private int gender;
    private String phonenumber;
    private float balance;
    private String cid;
    private String address;
    private String avatar; 

    public Customer() {
    }

    public Customer(int customerId, String fullname, String username, String password, int active, String email, Date dob, int gender, String phonenumber, float balance, String cid, String address, String avatar) {
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
        this.cid = cid;
        this.address = address;
        this.avatar = avatar;
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

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
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

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
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

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    
    
}
