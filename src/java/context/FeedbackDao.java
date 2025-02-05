/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import model.Feedback;

/**
 *
 * @author admin
 */
public class FeedbackDao extends DBContext {
    
 public List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedback]";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public List<Feedback> getAllFeedback1() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedback] where rating=1 ";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public List<Feedback> getAllFeedback2() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedback] where rating=2 ";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public List<Feedback> getAllFeedback3() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedback] where rating=3 ";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public List<Feedback> getAllFeedback4() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedback] where rating=4 ";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public List<Feedback> getAllFeedback5() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedback] where rating=5 ";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public static void main(String[] args) {
        FeedbackDao feedbackDao = new FeedbackDao();
        List<Feedback> feedbackList = feedbackDao.getAllFeedback();

        if (feedbackList.isEmpty()) {
            System.out.println("No feedback found.");
        } else {
            for (Feedback feedback : feedbackList) {
                System.out.println("Customer ID: " + feedback.getCustomer_id());
                System.out.println("Content: " + feedback.getContent());
                System.out.println("Date: " + feedback.getSubmitted_at());
                System.out.println("Rating: " + feedback.getRating());
                System.out.println("-------------------------------");
            }
        }
    }
    @Override
    public void insert(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Object> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
