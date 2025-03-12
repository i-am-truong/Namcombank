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
        String authorQuery = request.getParameter("author"); // New parameter for author search
        String sortOrder = request.getParameter("sort");
        String searchType = request.getParameter("searchType"); // New parameter to distinguish search types

        NewsDAO dao = new NewsDAO();
        ArrayList<News> n = new ArrayList<News>();

        // Log request parameters for debugging
        System.out.println("Request search parameter: " + searchQuery);
        System.out.println("Request author parameter: " + authorQuery);
        System.out.println("Request searchType parameter: " + searchType);
        System.out.println("Request sort parameter: " + sortOrder);

        int count = 0;
        int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
        boolean hasSearch = searchQuery != null && !searchQuery.trim().isEmpty();
        boolean hasAuthor = authorQuery != null && !authorQuery.trim().isEmpty();

        // Handle combined search (new search form)
        if ("combined".equals(searchType) || (hasSearch && hasAuthor)) {
            // Both title and author search
            if (hasSearch && hasAuthor) {
                n = dao.getNewsByTitleAndAuthor(searchQuery, authorQuery, index, sortOrder);
                count = dao.countNewsByTitleAndAuthor(searchQuery, authorQuery);
            }
            // Only author search
            else if (hasAuthor) {
                if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                    n = dao.getNewsByAuthorSorted(authorQuery, index, sortOrder);
                } else {
                    n = dao.getNewsByAuthor(authorQuery, index);
                }
                count = dao.countNewsByAuthor(authorQuery);
            }
            // Only title search
            else if (hasSearch) {
                if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                    n = dao.getNewByTitleSortedByDate(searchQuery, index, sortOrder);
                } else {
                    n = dao.getNewByTitle(searchQuery, index);
                }
                count = dao.count(searchQuery);
            }
            // No search criteria, just sorting
            else {
                if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                    n = dao.getNewsSortedByDate(index, sortOrder);
                } else {
                    n = dao.pagging(index);
                }
                count = dao.count("");
            }
        }
        // Backward compatibility for old search types
        else if ("author".equals(searchType) && hasAuthor) {
            if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                n = dao.getNewsByAuthorSorted(authorQuery, index, sortOrder);
            } else {
                n = dao.getNewsByAuthor(authorQuery, index);
            }
            count = dao.countNewsByAuthor(authorQuery);
        }
        else if (hasSearch) {
            if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                n = dao.getNewByTitleSortedByDate(searchQuery, index, sortOrder);
            } else {
                n = dao.getNewByTitle(searchQuery, index);
            }
            count = dao.count(searchQuery);
        }
        else {
            if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                n = dao.getNewsSortedByDate(index, sortOrder);
            } else {
                n = dao.pagging(index);
            }
            count = dao.count("");
        }

        int pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;

        request.setAttribute("n", n);
        request.setAttribute("pages", pages);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("searchType", searchType); // Pass search type to view

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
