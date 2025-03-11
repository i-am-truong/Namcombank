/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class SavingFeedback {

    private int feedback_id;
    private String content;
    private String submitted_at;
    private String answer;
    private String answer_at;
    private int savings_id;
    private String feedback_type;
    private String attachment;

    public SavingFeedback() {
    }

    public SavingFeedback(int feedback_id, String content, String submitted_at, String answer, String answer_at, int savings_id, String feedback_type, String attachment) {
        this.feedback_id = feedback_id;
        this.content = content;
        this.submitted_at = submitted_at;
        this.answer = answer;
        this.answer_at = answer_at;
        this.savings_id = savings_id;
        this.feedback_type = feedback_type;
        this.attachment = attachment;
    }

   

    public int getFeedback_id() {
        return feedback_id;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
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

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getAnswer_at() {
        return answer_at;
    }

    public void setAnswer_at(String answer_at) {
        this.answer_at = answer_at;
    }

    public int getSavings_id() {
        return savings_id;
    }

    public void setSavings_id(int savings_id) {
        this.savings_id = savings_id;
    }

    public String getFeedback_type() {
        return feedback_type;
    }

    public void setFeedback_type(String feedback_type) {
        this.feedback_type = feedback_type;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }



}
