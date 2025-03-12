/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import model.News;

/**
 *
 * @author ADMIN
 */
public class NewsDAO extends DBContext {

    public ArrayList<News> pagging(int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "select * from News WHERE status = '1' order by news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
        }
        return b;
    }

    public ArrayList<News> paggingWaitingList(int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Fix status value to use numeric 0 without quotes
            String sql = "select * from News WHERE status = 0 order by news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();

            System.out.println("Executing waiting news query with offset: " + ((index - 1) * 4)); // Debug output

            int count = 0; // For debug counting
            while (rs.next()) {
                count++;
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                              rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
            System.out.println("Found " + count + " waiting news items"); // Debug output
        } catch (Exception e) {
            System.out.println("Error in paggingWaitingList: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    public String getAuthorByid(int id) {
        String author = "Unknown"; // Default value if not found
        try {
            // Thêm điều kiện chỉ lấy staff đang active
            String sql = "select fullname from [Staff] Where staff_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                author = rs.getString(1);
                System.out.println("Found author: " + author + " for staff_id: " + id);
            } else {
                System.out.println("No author found for staff_id: " + id);
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in getAuthorByid: " + e.getMessage());
            e.printStackTrace();
        }
        return author;
    }

    public int count(String title) {
        try {
            ResultSet rs;
            if (title != null && title != "") {
                String sql = "select count (*) from News WHERE title LIKE ? AND status = 1";
                String searchTitle = "%" + title + "%";
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, searchTitle);
                rs = stm.executeQuery();
            } else {
                String sql = "select count (*) from News WHERE status = '1'";
                PreparedStatement stm = connection.prepareStatement(sql);
                rs = stm.executeQuery();
            }

            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int countWaiting() {
        try {
            // Fix status value to use numeric 0 without quotes
            String sql = "select count(*) from News WHERE status = 0";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            System.out.println("Executing waiting news count query"); // Debug output

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Found " + count + " total waiting news items"); // Debug output
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error in countWaiting: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<News> getNewByTitle(String title, int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            String searchTitle = "%" + title + "%";
            String sql = "select * from News WHERE title LIKE ? AND status = 1 order by news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchTitle);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
        }
        return b;
    }

    // Method to get news by title and sort by date
    public ArrayList<News> getNewByTitleSortedByDate(String title, int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String searchTitle = "%" + title + "%";
            String sql = "select * from News WHERE title LIKE ? AND status = 1 order by updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchTitle);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getNewByTitleSortedByDate: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    public News detail(int newsId) {
        News b = new News();
        try {
            String sql = "select * from News where news_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, newsId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                b = new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2)));
            }
        } catch (Exception e) {
        }
        return b;
    }

    public ArrayList<News> list() {
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "select * from News";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
        }
        return b;
    }

    public void deleteNews(int newsId) {
        try {
            String sql = "delete from News where news_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, newsId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void addNews(News news) {
        try {
            String sql = "INSERT INTO News (staff_id, title, description, status, updateDate) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, news.getStaff_id());
            stm.setString(2, news.getTitle());
            stm.setString(3, news.getDescription());
            stm.setBoolean(4, news.isStatus());

            // Use Timestamp instead of Date to preserve time information
            java.util.Date utilDate = news.getUpdateDate();
            java.sql.Timestamp sqlTimestamp = new java.sql.Timestamp(utilDate.getTime());
            stm.setTimestamp(5, sqlTimestamp);

            stm.executeUpdate();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in addNews: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void updateNews(News news) {
        try {
            String sql = "UPDATE [News] SET [title] = ?, [description] = ?, [staff_id] = ?, [status] = ?, [updateDate] = ? WHERE [news_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, news.getTitle());
            stm.setString(2, news.getDescription());
            stm.setInt(3, news.getStaff_id());
            stm.setBoolean(4, news.isStatus());

            // Use Timestamp instead of Date to preserve time information
            java.util.Date utilDate = news.getUpdateDate();
            java.sql.Timestamp sqlTimestamp = new java.sql.Timestamp(utilDate.getTime());
            stm.setTimestamp(5, sqlTimestamp);

            stm.setInt(6, news.getNews_id());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error in updateNews: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Thêm phương thức mới để lấy danh sách tin theo staffId (tin do staff đăng)
    public ArrayList<News> getNewsByStaffId(int staffId, int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "SELECT * FROM News WHERE staff_id = ? ORDER BY news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                              rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in getNewsByStaffId: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Thêm phương thức đếm số tin theo staffId
    public int countNewsByStaffId(int staffId) {
        try {
            String sql = "SELECT COUNT(*) FROM News WHERE staff_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in countNewsByStaffId: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // Sửa lại phương thức lấy danh sách tin theo roleId chỉ lấy tin đã duyệt (status = 1)
    public ArrayList<News> getNewsByRoleId(int roleId, int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "SELECT n.* FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "INNER JOIN StaffRoles sr ON s.staff_id = sr.staff_id " +
                         "WHERE sr.role_id = ? AND n.status = 1 " +  // Sửa lỗi cú pháp ở đây
                         "ORDER BY n.news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                              rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in getNewsByRoleId: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Sửa lại phương thức đếm số tin theo roleId chỉ đếm tin đã duyệt (status = 1)
    public int countNewsByRoleId(int roleId) {
        try {
            String sql = "SELECT COUNT(*) FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "INNER JOIN StaffRoles sr ON s.staff_id = sr.staff_id " +
                         "WHERE sr.role_id = ? AND n.status = 1";  // Sửa lỗi cú pháp ở đây
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in countNewsByRoleId: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // Thêm phương thức mới để lấy tin đang chờ duyệt của một nhân viên cụ thể
    public ArrayList<News> getPendingNewsByStaffId(int staffId, int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "SELECT * FROM News WHERE staff_id = ? AND status = 0 ORDER BY news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                              rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in getPendingNewsByStaffId: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Thêm phương thức đếm số tin đang chờ duyệt của một nhân viên cụ thể
    public int countPendingNewsByStaffId(int staffId) {
        try {
            String sql = "SELECT COUNT(*) FROM News WHERE staff_id = ? AND status = 0";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in countPendingNewsByStaffId: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách 3 tin tức mới nhất đã được phê duyệt
     * @return ArrayList<News> chứa 3 tin tức mới nhất
     */
    public ArrayList<News> getRecentNews() {
        ArrayList<News> recentNews = new ArrayList<>();
        try {
            // Lấy 3 tin tức mới nhất đã phê duyệt (status = 1)
            String sql = "SELECT TOP 3 * FROM News WHERE status = 1 ORDER BY updateDate DESC";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                recentNews.add(new News(
                    rs.getInt(1),            // news_id
                    rs.getString(3),         // title
                    rs.getString(4),         // description
                    rs.getInt(2),            // staff_id
                    rs.getTimestamp(6),      // updateDate
                    rs.getBoolean(5),        // status
                    getAuthorByid(rs.getInt(2))  // authorName
                ));
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            System.out.println("Error in getRecentNews: " + e.getMessage());
            e.printStackTrace();
        }
        return recentNews;
    }

    // Method to get news sorted by date (newest or oldest first)
    public ArrayList<News> getNewsSortedByDate(int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String sql = "select * from News WHERE status = '1' order by updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getNewsSortedByDate: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Method to get waiting news sorted by date
    public ArrayList<News> getWaitingNewsSortedByDate(int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String sql = "select * from News WHERE status = 0 order by updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                            rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getWaitingNewsSortedByDate: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Method to get role news sorted by date
    public ArrayList<News> getRoleNewsSortedByDate(int roleId, int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String sql = "SELECT n.* FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "INNER JOIN StaffRoles sr ON s.staff_id = sr.staff_id " +
                         "WHERE sr.role_id = ? AND n.status = 1 " +
                         "ORDER BY n.updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                            rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getRoleNewsSortedByDate: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Method to get staff news sorted by date
    public ArrayList<News> getStaffNewsSortedByDate(int staffId, int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String sql = "SELECT * FROM News WHERE staff_id = ? ORDER BY updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                            rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getStaffNewsSortedByDate: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    // Method to get pending staff news sorted by date
    public ArrayList<News> getPendingStaffNewsSortedByDate(int staffId, int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String sql = "SELECT * FROM News WHERE staff_id = ? AND status = 0 ORDER BY updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staffId);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                            rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getPendingStaffNewsSortedByDate: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    /**
     * Get news by author name with pagination
     * @param authorName The author name to search for
     * @param index The page index (starting from 1)
     * @return List of news written by authors matching the search term
     */
    public ArrayList<News> getNewsByAuthor(String authorName, int index) {
        ArrayList<News> b = new ArrayList<>();
        try {
            String searchName = "%" + authorName + "%";
            String sql = "SELECT n.* FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "WHERE s.fullname LIKE ? AND n.status = 1 " +
                         "ORDER BY n.news_id DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchName);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                      rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getNewsByAuthor: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    /**
     * Get news by author name with pagination and sorting
     * @param authorName The author name to search for
     * @param index The page index (starting from 1)
     * @param sortOrder Sort order ("newest" or "oldest")
     * @return List of news written by authors matching the search term, sorted by date
     */
    public ArrayList<News> getNewsByAuthorSorted(String authorName, int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String searchName = "%" + authorName + "%";
            String sql = "SELECT n.* FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "WHERE s.fullname LIKE ? AND n.status = 1 " +
                         "ORDER BY n.updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchName);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                      rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getNewsByAuthorSorted: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    /**
     * Count news written by authors matching the search term
     * @param authorName The author name to search for
     * @return Count of news items
     */
    public int countNewsByAuthor(String authorName) {
        try {
            String searchName = "%" + authorName + "%";
            String sql = "SELECT COUNT(*) FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "WHERE s.fullname LIKE ? AND n.status = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchName);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error in countNewsByAuthor: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Search for news by both title and author name with pagination
     * @param title Search term for title
     * @param authorName Search term for author name
     * @param index Page index
     * @param sortOrder Sort order (newest/oldest)
     * @return List of matching news items
     */
    public ArrayList<News> getNewsByTitleAndAuthor(String title, String authorName, int index, String sortOrder) {
        ArrayList<News> b = new ArrayList<>();
        try {
            // Default to DESC (newest first) if sortOrder is not specified or invalid
            String order = "DESC"; // Default newest first
            if (sortOrder != null && sortOrder.equalsIgnoreCase("oldest")) {
                order = "ASC";
            }

            String searchTitle = "%" + title + "%";
            String searchName = "%" + authorName + "%";

            // Query to search by both title and author
            String sql = "SELECT n.* FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "WHERE n.title LIKE ? AND s.fullname LIKE ? AND n.status = 1 " +
                         "ORDER BY n.updateDate " + order + " OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchTitle);
            stm.setString(2, searchName);
            stm.setInt(3, (index - 1) * 4);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getInt(2),
                      rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(2))));
            }
        } catch (Exception e) {
            System.out.println("Error in getNewsByTitleAndAuthor: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    /**
     * Count news items matching both title and author search criteria
     * @param title Search term for title
     * @param authorName Search term for author name
     * @return Count of matching news items
     */
    public int countNewsByTitleAndAuthor(String title, String authorName) {
        try {
            String searchTitle = "%" + title + "%";
            String searchName = "%" + authorName + "%";

            String sql = "SELECT COUNT(*) FROM News n " +
                         "INNER JOIN Staff s ON n.staff_id = s.staff_id " +
                         "WHERE n.title LIKE ? AND s.fullname LIKE ? AND n.status = 1";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchTitle);
            stm.setString(2, searchName);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error in countNewsByTitleAndAuthor: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        NewsDAO dao = new NewsDAO();
        News news = new News("tesst", "tessssst", 1, new Date(), false);
        dao.addNews(news);
        System.out.println(dao.count(""));
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
    public Object get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
