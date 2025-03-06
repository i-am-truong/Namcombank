package model;
import java.util.Date;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
/**
 *
 * @author ADMIN
 */
public class News {
    private int news_id;           // Matches news_id column in database
    private int staff_id;          // Matches staff_id column in database
    private String title;          // Matches title column in database
    private String description;    // Matches description column in database
    private boolean status;        // Matches status column in database (bit type)
    private Date updateDate;       // Matches updateDate column in database
    
    // Additional fields not in the database but used in the application
    private String authorName;     // To store the name of the staff author
    private String thumbnail;      // To store the thumbnail image URL
    
    // Default constructor
    public News() {
    }
    
    // Constructor with essential fields
    public News(String title, String description, int staff_id, Date updateDate, boolean status) {
        this.title = title;
        this.description = description;
        this.staff_id = staff_id;
        this.updateDate = updateDate;
        this.status = status;
    }
    
    // Full constructor including non-database fields
    public News(int news_id, String title, String description, int staff_id, Date updateDate, boolean status, String authorName, String thumbnail) {
        this.news_id = news_id;
        this.title = title;
        this.description = description;
        this.staff_id = staff_id;
        this.updateDate = updateDate;
        this.status = status;
        this.authorName = authorName;
        this.thumbnail = thumbnail != null ? thumbnail : "assets/img/blog/1.jpg";
    }
    
    // Constructor that extracts thumbnail from the description
    public News(int news_id, String title, String description, int staff_id, Date updateDate, boolean status, String authorName) {
        this(news_id, title, description, staff_id, updateDate, status, authorName, extractFirstImageUrl(description));
    }
    
    // Utility method to extract first image URL from HTML content
    public static String extractFirstImageUrl(String html) {
        Document doc = Jsoup.parse(html);
        Element imgElement = doc.selectFirst("img");
        return imgElement != null ? imgElement.attr("src") : null;
    }
    
    // Getters and Setters
    public int getNews_id() {
        return news_id;
    }
    
    public void setNews_id(int news_id) {
        this.news_id = news_id;
    }
    
    public int getStaff_id() {
        return staff_id;
    }
    
    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public boolean isStatus() {
        return status;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public Date getUpdateDate() {
        return updateDate;
    }
    
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    
    public String getAuthorName() {
        return authorName;
    }
    
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    
    public String getThumbnail() {
        return thumbnail;
    }
    
    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
    
    // For backwards compatibility with existing code that might use these methods
    public int getnId() {
        return news_id;
    }
    
    public void setnId(int nId) {
        this.news_id = nId;
    }
    
    public String getBody() {
        return description;
    }
    
    public void setBody(String body) {
        this.description = body;
    }
    
    public int getAuthor() {
        return staff_id;
    }
    
    public void setAuthor(int author) {
        this.staff_id = author;
    }
    
    public boolean getStatus() {
        return status;
    }
}