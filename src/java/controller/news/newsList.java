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
import java.util.ArrayList;
import model.News;

/**
 *
 * @author ADMIN
 */
public class newsList extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

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
        String indexPage = request.getParameter("index");
        String searchQuery = request.getParameter("search");
           NewsDAO dao = new NewsDAO();
           ArrayList<News> n = new ArrayList<News>();
           if(indexPage != null){
             int index = Integer.parseInt(indexPage);
             if(searchQuery != null && searchQuery != ""){
              n = dao.getNewByTitle(searchQuery, index);
             }
             else{
             n = dao.pagging(index);
             }
           }
           else{
               if(searchQuery != null && searchQuery != ""){
              n = dao.getNewByTitle(searchQuery, 1);
             }
             else{
             n = dao.pagging(1);
             }

           }

        int count = dao.count(searchQuery);
        int pages = 0;
         if(count % 4 != 0){
            pages = (count/4) +1 ;
        }
         else
              pages = count/4;
        request.setAttribute("n", n);
        request.setAttribute("pages", pages);

        // Lấy 3 tin tức mới nhất để hiển thị ở sidebar
        ArrayList<News> recentNews = dao.getRecentNews();
        request.setAttribute("recentNews", recentNews);

        request.getRequestDispatcher("news/newsList.jsp").forward(request, response);
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
