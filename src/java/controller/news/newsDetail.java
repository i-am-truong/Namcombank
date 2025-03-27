/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.news;

import context.NewsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.News;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class newsDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet newsDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet newsDetail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        NewsDAO dao = new NewsDAO();
        News news = null;
        String newsId = request.getParameter("id");

        try {
            // Check if newsId parameter exists and is a valid integer
            if(newsId != null && !newsId.trim().isEmpty()) {
                int id = Integer.parseInt(newsId);
                news = dao.detail(id);

                // Check if a news article with the given ID exists
                if(news != null && news.getNews_id() > 0) {
                    request.setAttribute("news", news);

                    // Fetch related news articles (3 items)
                    ArrayList<News> relatedNews = dao.getRelatedNews(id, 3);
                    request.setAttribute("relatedNews", relatedNews);

                    request.getRequestDispatcher("news/newsDetail.jsp").forward(request, response);
                    return;
                }
            }

            // If newsId is null, empty, not a valid integer, or no news found with that ID
            // Redirect to the news list page
            response.sendRedirect("newsList");

        } catch(NumberFormatException e) {
            // If newsId is not a valid integer
            System.out.println("Invalid news ID format: " + newsId);
            response.sendRedirect("newsList");
        } catch(Exception e) {
            // Handle any other exceptions
            System.out.println("Error in newsDetail: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("newsList");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
