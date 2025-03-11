/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.SavingFeedback;

/**
 *
 * @author admin
 */
public class SavingFeedbackDAO extends DBContext<Object> {

    public void insertSavingFeedback(String content, String submittedAt, int savings_id, String feedbackType, String attachment) {
        String query = "INSERT INTO SavingFeedback "
                + "(content, submitted_at, answer, answer_at, savings_id, feedback_type, attachment) "
                + "VALUES (?, ?, NULL, NULL, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, content);
            ps.setString(2, (submittedAt)); // Chuyển đổi String sang Date
//            ps.setString(3, answer);
//            ps.setString(4, (answerAt));
            ps.setInt(3, savings_id);
            ps.setString(4, feedbackType);
            ps.setString(5, attachment);

            ps.executeUpdate();
            System.out.println("Feedback inserted successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<SavingFeedback> getAllSavingFeedback() {
        List<SavingFeedback> feedbackList = new ArrayList<>();
        String query = "SELECT * FROM SavingFeedback WHERE answer IS NULL and answer_at is null;";  // Truy vấn lấy tất cả phản hồi

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {  // Đúng cú pháp ở đây

            while (rs.next()) {
                SavingFeedback feedback = new SavingFeedback();
                feedback.setFeedback_id(rs.getInt("feedback_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setAnswer(rs.getString("answer"));
                feedback.setAnswer_at(rs.getString("answer_at"));
                feedback.setSavings_id(rs.getInt("savings_id"));
                feedback.setFeedback_type(rs.getString("feedback_type"));
                feedback.setAttachment(rs.getString("attachment"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedbackList;
    }

    public void answer(int feedback_id, String answer, String answer_at) {
        String query = "UPDATE SavingFeedback "
                + "SET answer = ?, answer_at = ? "
                + "WHERE feedback_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            // Set các tham số vào PreparedStatement
            ps.setString(1, answer);
            ps.setString(2, answer_at);
            ps.setInt(3, feedback_id);

            // Thực thi câu lệnh SQL
            ps.executeUpdate();
            System.out.println("Feedback updated successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<SavingFeedback> getAnswer( int savings_id) {
        List<SavingFeedback> feedbackList = new ArrayList<>();

        String query = "SELECT * FROM SavingFeedback WHERE  [answer] IS NOT NULL and savings_id =? ";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
          
            ps.setInt(1, savings_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SavingFeedback feedback = new SavingFeedback();
                    feedback.setFeedback_id(rs.getInt("feedback_id"));
                    feedback.setContent(rs.getString("content"));
                    feedback.setSubmitted_at(rs.getString("submitted_at"));
                    feedback.setAnswer(rs.getString("answer"));
                    feedback.setAnswer_at(rs.getString("answer_at"));
                    feedback.setSavings_id(rs.getInt("savings_id"));
                    feedback.setFeedback_type(rs.getString("feedback_type"));
                    feedback.setAttachment(rs.getString("attachment"));

                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedbackList;
    }

    @Override
    public void insert(Object model
    ) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Object model
    ) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Object model
    ) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Object> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object get(int id
    ) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
