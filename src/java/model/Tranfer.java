/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Tranfer {

    private int transfer_id;
    private String transfer_date;
    private String transfer_content;
    private int customer_id;
    private int customer_id_received;
    private Double transfer_amount;

    public Tranfer(int transfer_id, String transfer_date, String transfer_content, int customer_id, int customer_id_received, Double transfer_amount) {
        this.transfer_id = transfer_id;
        this.transfer_date = transfer_date;
        this.transfer_content = transfer_content;
        this.customer_id = customer_id;
        this.customer_id_received = customer_id_received;
        this.transfer_amount = transfer_amount;
    }

    public int getTransfer_id() {
        return transfer_id;
    }

    public void setTransfer_id(int transfer_id) {
        this.transfer_id = transfer_id;
    }

    public String getTransfer_date() {
        return transfer_date;
    }

    public void setTransfer_date(String transfer_date) {
        this.transfer_date = transfer_date;
    }

    public String getTransfer_content() {
        return transfer_content;
    }

    public void setTransfer_content(String transfer_content) {
        this.transfer_content = transfer_content;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getCustomer_id_received() {
        return customer_id_received;
    }

    public void setCustomer_id_received(int customer_id_received) {
        this.customer_id_received = customer_id_received;
    }

    public Double getTransfer_amount() {
        return transfer_amount;
    }

    public void setTransfer_amount(Double transfer_amount) {
        this.transfer_amount = transfer_amount;
    }
    
}

