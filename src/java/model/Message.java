package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Message {
    private int id; 
    private int senderId;
    private int receiverId;
    private String senderType;
    private String content;
    private Timestamp timestamp;
    private String status;

    // Constructor có tham số
    public Message(int id, int senderId, int receiverId, String senderType, String content, Timestamp timestamp, String status) {
        this.id = id;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.senderType = senderType;
        this.content = content;
        this.timestamp = timestamp;
        this.status = status;
    }

    // Constructor không tham số
    public Message() {}

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getFormattedTimestamp() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        return (timestamp != null) ? sdf.format(timestamp) : "N/A";
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
