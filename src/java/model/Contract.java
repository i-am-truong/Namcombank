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
    private String customerName;
    private String type;
    private double amount;
    private String status;

    public Contract() {
    }

    public Contract(int id, String customerName, String type, double amount, String status) {
        this.id = id;
        this.customerName = customerName;
        this.type = type;
        this.amount = amount;
        this.status = status;
    }
    
    

    public void setId(int id) {
        this.id = id;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getType() {
        return type;
    }

    public double getAmount() {
        return amount;
    }

    public String getStatus() {
        return status;
    }
    
    
}
