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
import javax.lang.model.util.Types;
import model.Feedback;
import model.Feedback_id;

/**
 *
 * @author admin
 */
public class FeedbackDao extends DBContext {

    public void insertFeedback(Feedback feedback) {
        String sql = "INSERT INTO [dbo].[Feedback] ([customer_id], [content], [submitted_at], [rating], [feedback_type], [attachment]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, feedback.getCustomer_id());
            stm.setString(2, feedback.getContent());
            stm.setString(3, feedback.getSubmitted_at());
            stm.setInt(4, feedback.getRating());
            stm.setString(5, feedback.getFeedback_type());
            stm.setBytes(6, feedback.getAttachment());

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                return;
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
                feedback.setFeedback_type(rs.getString("feedback_type"));
                feedback.setAttachment(rs.getBytes("attachment"));
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

    public int getTotalFeedbackByContent(String content) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE content like ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, "%" + content + "%");
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
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalFeedbackByRatingAndType(int rating, String feedback_type) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE rating = ? AND feedback_type = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            stm.setString(2, feedback_type);
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

    public List<Feedback> pagingFeedbackByRatingAndType(int index, int rating, String feedback_type) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE rating = ? and feedback_type = ? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            stm.setString(2, feedback_type);
            stm.setInt(3, (index - 1) * 4);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalFeedbackByRatingAndTypeAndContent(int rating, String feedback_type, String content) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE rating = ? AND feedback_type = ? AND content like ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            stm.setString(2, feedback_type);
            stm.setString(3, "%" + content + "%");
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

    public List<Feedback> pagingFeedbackByRatingAndTypeAndContent(int index, int rating, String feedback_type, String content) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE rating = ? AND feedback_type=? AND content like ? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            stm.setString(2, feedback_type);
            stm.setString(3, "%" + content + "%");
            stm.setInt(4, (index - 1) * 4);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalFeedbackByTypeAndContent(String feedback_type, String content) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE  feedback_type = ? AND content like ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, feedback_type);
            stm.setString(2, "%" + content + "%");
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

    public int getTotalFeedbackByType(String feedback_type) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE  feedback_type = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, feedback_type);
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

    public int getTotalFeedbackByRatingAndContent(int rating, String content) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Feedback WHERE  rating = ? AND content like ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setInt(1, rating);
            stm.setString(2, "%" + content + "%");
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

    public List<Feedback> pagingFeedbackByRatingAndContent(int index, int rating, String content) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE rating=? AND content like ? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setInt(1, rating);
            stm.setString(2, "%" + content + "%");
            stm.setInt(3, (index - 1) * 4);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> pagingFeedbackByTypeAndContent(int index, String feedback_type, String content) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE feedback_type=?  AND content like ? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, feedback_type);
            stm.setString(2, "%" + content + "%");
            stm.setInt(3, (index - 1) * 4);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> pagingFeedbackByContent(int index, String content) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE content like ? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, "%" + content + "%");
            stm.setInt(2, (index - 1) * 4);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> pagingFeedbackByType(int index, String feedback_type) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE feedback_type=? ORDER BY submitted_at DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, feedback_type);
            stm.setInt(2, (index - 1) * 4);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(new Feedback(rs.getInt("customer_id"),
                            rs.getString("content"),
                            rs.getString("submitted_at"),
                            rs.getInt("rating"),
                            rs.getString("feedback_type"),
                            rs.getBytes("attachment")
                    ));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback_id> getCusFeedback(int customer_id) {
        List<Feedback_id> list = new ArrayList<>();
        String sql = "select * from Feedback where customer_id=?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, customer_id);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Feedback_id feedback = new Feedback_id();
                    feedback.setCustomer_id(rs.getInt("customer_id"));
                    feedback.setContent(rs.getString("content"));
                    feedback.setSubmitted_at(rs.getString("submitted_at"));
                    feedback.setRating(rs.getInt("rating"));
                    feedback.setFeedback_type(rs.getString("feedback_type"));
                    feedback.setAttachment(rs.getBytes("attachment"));
                    feedback.setFeedback_id(rs.getInt("feedback_id"));
                    list.add(feedback);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public byte[] getImageByFeedback(int rating, String content, String submittedAt, String feedbackType) {
        String sql = "SELECT attachment FROM Feedback WHERE rating = ? AND content = ? AND submitted_at = ? AND feedback_type = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, rating);
            stm.setString(2, content);
            stm.setString(3, submittedAt);
            stm.setString(4, feedbackType);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getBytes("attachment");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteFeedbackWithId(int id) {

        String sql = "delete from Feedback where feedback_id=?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            stm.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public boolean checkFeedbackAttachment(int feedback_id) {
        String sql = "SELECT 1 FROM feedback WHERE feedback_id = ? AND attachment IS NOT NULL";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, feedback_id);
            try (ResultSet rs = stm.executeQuery()) {
                return rs.next(); // Nếu có dữ liệu thì feedback có ảnh
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Mặc định không có ảnh
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

    public int getFeedbackId(String content, String submitted_at, int rating, String feedback_type) {
        String sql = "select feedback_id from Feedback where content=? and submitted_at=? and rating=? and feedback_type=?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.setString(4, feedback_type);
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

    public void updateFeedback(String content, String submitted_at, int rating, int feedback_id, String feedback_type, byte[] attachment) {
        String sql = "UPDATE Feedback SET content = ?, submitted_at = ?, rating = ?, feedback_type = ?, attachment = ? WHERE feedback_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.setString(4, feedback_type);
            stm.setBytes(5, attachment);
            stm.setInt(6, feedback_id);

            int rowsAffected = stm.executeUpdate();  // Dùng executeUpdate()
            if (rowsAffected > 0) {
                System.out.println("Cập nhật thành công!");
            } else {
                System.out.println("Không có bản ghi nào được cập nhật.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateFeedbackNoContentAndAttachment(String content, String submitted_at, int rating, int feedback_id, String feedback_type) {
        String sql = "UPDATE Feedback SET content = ?, submitted_at = ?, rating = ?, feedback_type = ? WHERE feedback_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.setString(4, feedback_type);
            stm.setInt(5, feedback_id);

            int rowsAffected = stm.executeUpdate();  // Dùng executeUpdate()
            if (rowsAffected > 0) {
                System.out.println("Cập nhật thành công!");
            } else {
                System.out.println("Không có bản ghi nào được cập nhật.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateFeedbackNoAttachment(String content, String submitted_at, int rating, int feedback_id, String feedback_type) {
        String sql = "UPDATE Feedback SET content = ?, submitted_at = ?, rating = ?, feedback_type = ? WHERE feedback_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, content);
            stm.setString(2, submitted_at);
            stm.setInt(3, rating);
            stm.setString(4, feedback_type);
            stm.setInt(5, feedback_id);

            int rowsAffected = stm.executeUpdate();  // Dùng executeUpdate()
            if (rowsAffected > 0) {
                System.out.println("Cập nhật thành công!");
            } else {
                System.out.println("Không có bản ghi nào được cập nhật.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {

        FeedbackDao dao = new FeedbackDao();

        // Thông tin cần kiểm tra
        String content = "hhee";
        String submitted_at = "2025-02-23"; // Giả định
        int rating = 5;
        String feedback_type = "human";
        byte[] attachment = null; // Nếu cần file ảnh, đọc từ file và chuyển thành byte array

        // Lấy feedback_id trước
        int feedback_id = dao.getFeedbackId(content, submitted_at, rating, feedback_type);

        if (feedback_id != -1) {
            System.out.println("Feedback ID found: " + feedback_id);
            dao.updateFeedback(content, submitted_at, rating, feedback_id, feedback_type, attachment);
        } else {
            System.out.println("No feedback found with the given details.");
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
