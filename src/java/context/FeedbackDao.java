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

    public void insertFeedback(Feedback feedback) {
        String sql = "INSERT INTO [dbo].[Feedback] ([customer_id], [content], [submitted_at], [rating]) "
                + "VALUES (?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, feedback.getCustomer_id());
            stm.setString(2, feedback.getContent());
            stm.setString(3, feedback.getSubmitted_at());
            stm.setInt(4, feedback.getRating());

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Feedback inserted successfully.");
            } else {
                System.out.println("Failed to insert feedback.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalFeedback() {
        String sql = "SELECT count(*) FROM Feedback";
        int total = 0;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Feedback> pagingFeedback(int index) {
        List<Feedback> list = new ArrayList<>();
        String sql = "select * from Feedback\n"
                + "Order by feedback_id\n"
                + "OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_id(rs.getInt("customer_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setSubmitted_at(rs.getString("submitted_at"));
                feedback.setRating(rs.getInt("rating"));
                list.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getTotalFeedbackByRating(int rating) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE rating = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Feedback> pagingFeedbackByRating(int index, int rating) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE rating = ? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            stm.setInt(2, (index - 1) * 4);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> getCusFeedback(int customer_id) {
        List<Feedback> list = new ArrayList<>();
        String sql = "select * from Feedback where customer_id=?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, customer_id);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setCustomer_id(rs.getInt("customer_id"));
                    feedback.setContent(rs.getString("content"));
                    feedback.setSubmitted_at(rs.getString("submitted_at"));
                    feedback.setRating(rs.getInt("rating"));
                    list.add(feedback);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteFeedback(String content, String submitted_at, int rating) {

        String sql = "delete from feedback WHERE  content=? and submitted_at=? and rating=?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public int getFeedbackId(String content, String submitted_at, int rating) {
        String sql = "select feedback_id from Feedback where content=? and submitted_at=? and rating=?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.executeQuery();
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("feedback_id");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void updateFeedback(String content, String submitted_at, int rating, int feedback_id) {
        String sql = "UPDATE Feedback\n"
                + "SET\n"
                + "content = ?,\n"
                + "    [submitted_at] = ?,\n"
                + "    [rating] = ?\n"
                + "WHERE \n"
                + "    [feedback_id] = ?\n";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.setInt(4, feedback_id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {

        FeedbackDao dao = new FeedbackDao();
        int total = dao.getTotalFeedback();
        List<Feedback> list = dao.pagingFeedback(2);
        System.out.println(list);

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
