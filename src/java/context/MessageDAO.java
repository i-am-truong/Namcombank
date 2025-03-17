package context;

import context.DBContext;
import model.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO extends DBContext<Message> {

    public List<Integer> getCustomersWithMessages(int staffId) {
        List<Integer> customerList = new ArrayList<>();
        String sql = "SELECT DISTINCT sender_id FROM messages WHERE receiver_id = ? "
                + "UNION SELECT DISTINCT receiver_id FROM messages WHERE sender_id = ?";

        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customerList.add(rs.getInt("sender_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerList;
    }

    public List<Message> getMessagesBetween(int customerId, int staffId) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE "
                + "(sender_id = ? AND receiver_id = ?) OR "
                + "(sender_id = ? AND receiver_id = ?) "
                + "ORDER BY timestamp ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, staffId);
            ps.setInt(3, staffId);
            ps.setInt(4, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setSenderId(rs.getInt("sender_id"));
                msg.setReceiverId(rs.getInt("receiver_id"));
                msg.setSenderType(rs.getString("sender_type"));
                msg.setContent(rs.getString("content"));
                msg.setStatus(rs.getString("status"));
                msg.setTimestamp(rs.getTimestamp("timestamp"));
                messages.add(msg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

    public void insertMessage(Message msg) {
        String sql = "INSERT INTO messages (sender_id, receiver_id, sender_type, content, status) "
                + "VALUES (?, ?, ?, ?, 'sent')";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, msg.getSenderId());
            ps.setInt(2, msg.getReceiverId());
            ps.setString(3, msg.getSenderType());
            ps.setString(4, msg.getContent());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void insert(Message model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Message model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Message model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Message> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Message get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
