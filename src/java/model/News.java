/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
    int nId;
    String title;
    String body;
    int author;
    Date updateDate;
    boolean status;
    String authorName;
    String thumbnail;

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
    public News() {
    }
     public News(String title, String body, int author, Date update_date, boolean status) {
        this.title = title;
        this.body = body;
        this.author = author;
        this.updateDate = update_date;
        this.status = status;
    }
    public News(int nId, String title, String body, int author, Date update_date, boolean status, String authorName, String thumbnail) {
        this.nId = nId;
        this.title = title;
        this.body = body;
        this.author = author;
        this.updateDate = update_date;
        this.status = status;
        this.authorName = authorName;
        this.thumbnail = thumbnail != null ? thumbnail : "assets/img/blog/1.jpg";
    }
     public News(int nId, String title, String body, int author, Date updateDate, boolean status, String authorName) {
        this(nId, title, body, author, updateDate, status, authorName, extractFirstImageUrl(body)); // null hoặc giá trị mặc định
    }
       public static String extractFirstImageUrl(String html) {
        Document doc = Jsoup.parse(html);
        Element imgElement = doc.selectFirst("img");
        return imgElement != null ? imgElement.attr("src") : null;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public int getnId() {
        return nId;
    }

    public void setnId(int nId) {
        this.nId = nId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getAuthor() {
        return author;
    }

    public void setAuthor(int author) {
        this.author = author;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
