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
public class NewsDAO extends DBContext{
      public ArrayList<News> pagging(int index){
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "select * from News WHERE status = '1'  order by 'nid' DESC  OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index-1)*4);
            ResultSet rs = stm.executeQuery();     
            while (rs.next()) {                
                b.add(new News(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(4))));
            }
        } catch (Exception e) {
        }
        return b;
    }
       public ArrayList<News> paggingWaitingList(int index){
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "select * from News WHERE status = '0'  order by 'nid' DESC  OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index-1)*4);
            ResultSet rs = stm.executeQuery();     
            while (rs.next()) {                
                b.add(new News(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(4))));
            }
        } catch (Exception e) {
        }
        return b;
    }
      public String getAuthorByid(int id){
               String author ="";
        try {
            String sql = "select * from [User] Where uid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();     
            
            if (rs.next()) {                
               author = rs.getString(2);
            }
        } catch (Exception e) {
        }
        return author;
    }
    
    public  int count(String title){
        try {
            ResultSet rs;
            if(title !=null && title != ""){
                String sql = "select count (*) from News WHERE title LIKE ? AND status = '1'  ";
                String searchTitle = "%" + title + "%";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchTitle);
              rs = stm.executeQuery();
            }
            else{
              String sql = "select count (*)  from News  WHERE status = '1'";   
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
    public  int countWaiting(){
        try {
            ResultSet rs;
          
          
              String sql = "select count (*)  from News  WHERE status = 0 ";  
              PreparedStatement stm = connection.prepareStatement(sql);
                rs = stm.executeQuery();
            
            
           
            while (rs.next()) {                
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    public  ArrayList<News> getNewByTitle(String title, int index){
         ArrayList<News> b = new ArrayList<>();
        try {
            String searchTitle = "%" + title + "%";
            String sql = "select * from News WHERE title LIKE ? AND status = 1  order by 'nid' DESC  OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, searchTitle);
            stm.setInt(2, (index-1)*4);
            ResultSet rs = stm.executeQuery();     
            while (rs.next()) {                
                b.add(new News(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(4))));
            }
        } catch (Exception e) {
        }
        return b;
    }
    
    public News detail(int newsId){
        News b = new News();
        try {
            String sql = "select * from News where nid = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, newsId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {                
               b=new News(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(4)));
            }
        } catch (Exception e) {
        }
        return b;
    }
    
    public ArrayList<News> list(){
        ArrayList<News> b = new ArrayList<>();
        try {
            String sql = "select * from News";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b.add(new News(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getTimestamp(6), rs.getBoolean(5), getAuthorByid(rs.getInt(4))));
            }
        } catch (Exception e) {
        }
        return b;
    }
    public void deleteNews(int newsId){
         try {
            String sql = "delete from News where nid = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, newsId);
            stm.executeUpdate();
            
        } catch (Exception e) {
        }
    }
    public void addNews(News news) {
        try {
            String sql = "INSERT INTO News (title, description, uid, status, updateDate) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, news.getTitle());
            stm.setString(2, news.getBody());
            stm.setInt(3, news.getAuthor());
            stm.setBoolean(4, false);
            stm.setDate(5, new java.sql.Date(news.getUpdateDate().getTime()));
            stm.executeUpdate();

          
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void updateNews (News news){
        try {
            String sql = "UPDATE [News]" +
"   SET [title] = ?" +
"      ,[description] = ?" +
"      ,[uid] = ?" +
"      ,[status] = ?" +
"      ,[updateDate] = ?" +
" WHERE [nid] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, news.getTitle());
            stm.setString(2, news.getBody());
            stm.setInt(3, news.getAuthor());
            stm.setBoolean(4, news.getStatus());
            stm.setDate(5, new java.sql.Date(news.getUpdateDate().getTime()));
            stm.setInt(6, news.getnId());
            stm.executeUpdate();

          
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
   public static void main(String[] args) {
        NewsDAO dao = new NewsDAO();
        News news = new News("tesst","tessssst",1,new Date(), false);
        dao.addNews(news);
        System.out.println(dao.count(""));
        }
  
    
    
   

}
