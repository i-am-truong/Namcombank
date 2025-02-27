package model;

/**
 *
 * @author admin
 */
public class Feedback_id {

    private int customer_id;
    private String content;
    private String submitted_at;
    private int rating;
    private String feedback_type;
    private byte[] attachment;
    private int feedback_id;

    public Feedback_id() {
    }

    public Feedback_id(int customer_id, String content, String submitted_at, int rating, String feedback_type, byte[] attachment, int feedback_id) {
        this.customer_id = customer_id;
        this.content = content;
        this.submitted_at = submitted_at;
        this.rating = rating;
        this.feedback_type = feedback_type;
        this.attachment = attachment;
        this.feedback_id = feedback_id;
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

    public String getFeedback_type() {
        return feedback_type;
    }

    public void setFeedback_type(String feedback_type) {
        this.feedback_type = feedback_type;
    }

    public byte[] getAttachment() {
        return attachment;
    }

    public void setAttachment(byte[] attachment) {
        this.attachment = attachment;
    }

    public int getFeedback_id() {
        return feedback_id;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    @Override
    public String toString() {
        return "Feedback{" + "customer_id=" + customer_id + ", content=" + content + ", submitted_at=" + submitted_at + ", rating=" + rating + ", feedback_type=" + feedback_type + ", attachment=" + attachment + '}';
    }

}
