/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


/**
 *
 * @author admin
 */
public class Feedback {

    private int customer_id;
    private String content;
    private String submitted_at;
    private int rating;

    public Feedback() {
    }

    public Feedback(int customer_id, String content, String submitted_at, int rating) {
        this.customer_id = customer_id;
        this.content = content;
        this.submitted_at = submitted_at;
        this.rating = rating;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSubmitted_at() {
        return submitted_at;
    }

    public void setSubmitted_at(String submitted_at) {
        this.submitted_at = submitted_at;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "Feedback{" + "customer_id=" + customer_id + ", content=" + content + ", submitted_at=" + submitted_at + ", rating=" + rating + '}';
    }

}
