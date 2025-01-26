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
public class Notification {
    private int notificationId;
    private String message;
    private Date createdAt;
    private int customerId;

    public Notification() {
    }

    public Notification(int notificationId, String message, Date createdAt, int customerId) {
        this.notificationId = notificationId;
        this.message = message;
        this.createdAt = createdAt;
        this.customerId = customerId;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Override
    public String toString() {
        return "Notification{" + "notificationId=" + notificationId + ", message=" + message + ", createdAt=" + createdAt + ", customerId=" + customerId + '}';
    }
    
    
}
