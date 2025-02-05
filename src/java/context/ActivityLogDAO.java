/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author duong
 */
class ActivityLogDAO {
    private int id;
    private int userId;
    private String action;
    private LocalDateTime timestamp;
    private String details;
    private String username;

    List<ActivityLog> getRecentActivities(int userId, int i) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    void insertActivity(ActivityLog activityLog) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
