/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.news;

import context.NewsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import model.News;
import model.Pagination;
import Utils.SearchUtils;

/**
 *
 * @author ADMIN
 */
public class newsList extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters: use 'page' instead of 'index' to match pagination component
        String pageStr = request.getParameter("page");
        String searchQuery = SearchUtils.preprocessSearchQuery(request.getParameter("search"));
        String authorQuery = SearchUtils.preprocessSearchQuery(request.getParameter("author"));
        String sortOrder = request.getParameter("sort");
        String searchType = request.getParameter("searchType");
        String pageSizeStr = request.getParameter("page-size");

        // Initialize DAO and news list
        NewsDAO dao = new NewsDAO();
        ArrayList<News> n = new ArrayList<>();

        // Set up pagination object
        Pagination pagination = new Pagination();

        // Parse and set current page
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        pagination.setCurrentPage(page);

        // Parse and set page size
        int pageSize = 5; // Default
        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
                if (pageSize < 1) {
                    pageSize = 5;
                }
            } catch (NumberFormatException e) {
                pageSize = 5;
            }
        }
        pagination.setPageSize(pageSize);

        // Configure pagination settings
        pagination.setTotalPagesToShow(5);
        pagination.setUrlPattern("/newsList");

        // Log request parameters for debugging
        System.out.println("Request page: " + pageStr);
        System.out.println("Request search: " + searchQuery);
        System.out.println("Request author: " + authorQuery);
        System.out.println("Request searchType: " + searchType);
        System.out.println("Request sort: " + sortOrder);
        System.out.println("Request page size: " + pageSizeStr);

        // Process request based on parameters
        int count = 0;
        boolean hasSearch = searchQuery != null && !searchQuery.trim().isEmpty();
        boolean hasAuthor = authorQuery != null && !authorQuery.trim().isEmpty();

        // Handle combined search (new search form)
        if ("combined".equals(searchType) || (hasSearch && hasAuthor)) {
            // Both title and author search
            if (hasSearch && hasAuthor) {
                n = dao.getNewsByTitleAndAuthor(searchQuery, authorQuery, page, sortOrder, pageSize);
                count = dao.countNewsByTitleAndAuthor(searchQuery, authorQuery);
            } // Only author search
            else if (hasAuthor) {
                if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                    n = dao.getNewsByAuthorSorted(authorQuery, page, sortOrder, pageSize);
                } else {
                    n = dao.getNewsByAuthor(authorQuery, page, pageSize);
                }
                count = dao.countNewsByAuthor(authorQuery);
            } // Only title search
            else if (hasSearch) {
                if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                    n = dao.getNewByTitleSortedByDate(searchQuery, page, sortOrder, pageSize);
                } else {
                    n = dao.getNewByTitle(searchQuery, page, pageSize);
                }
                count = dao.count(searchQuery);
            } // No search criteria, just sorting
            else {
                if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                    n = dao.getNewsSortedByDate(page, sortOrder, pageSize);
                } else {
                    n = dao.pagging(page, pageSize);
                }
                count = dao.count("");
            }
        } // Backward compatibility for old search types
        else if ("author".equals(searchType) && hasAuthor) {
            if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                n = dao.getNewsByAuthorSorted(authorQuery, page, sortOrder, pageSize);
            } else {
                n = dao.getNewsByAuthor(authorQuery, page, pageSize);
            }
            count = dao.countNewsByAuthor(authorQuery);
        } else if (hasSearch) {
            if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                n = dao.getNewByTitleSortedByDate(searchQuery, page, sortOrder, pageSize);
            } else {
                n = dao.getNewByTitle(searchQuery, page, pageSize);
            }
            count = dao.count(searchQuery);
        } else {
            if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                n = dao.getNewsSortedByDate(page, sortOrder, pageSize);
            } else {
                n = dao.pagging(page, pageSize);
            }
            count = dao.count("");
        }

        // Set total pages in pagination
        int totalPages = count == 0 ? 1 : (count % pageSize != 0) ? (count / pageSize) + 1 : count / pageSize;
        pagination.setTotalPages(totalPages);

        // Build search parameters for pagination
        ArrayList<String> searchFields = new ArrayList<>();
        ArrayList<String> searchValues = new ArrayList<>();

        if (hasSearch) {
            searchFields.add("search");
            searchValues.add(searchQuery);
        }

        if (hasAuthor) {
            searchFields.add("author");
            searchValues.add(authorQuery);
        }

        if (sortOrder != null && !sortOrder.isEmpty()) {
            searchFields.add("sort");
            searchValues.add(sortOrder);
        }

        if (searchType != null && !searchType.isEmpty()) {
            searchFields.add("searchType");
            searchValues.add(searchType);
        }

        // Only set search fields if we have any
        if (!searchFields.isEmpty()) {
            pagination.setSearchFields(searchFields.toArray(new String[0]));
            pagination.setSearchValues(searchValues.toArray(new String[0]));
        }

        // Generate list of available page sizes based on total count
        pagination.setListPageSize(count);

        // Set attributes for the JSP
        request.setAttribute("n", n);
        request.setAttribute("pagination", pagination);
        request.setAttribute("count", count);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("authorQuery", authorQuery);


        // Get recent news for sidebar
        ArrayList<News> recentNews = dao.getRecentNews();
        request.setAttribute("recentNews", recentNews);

        // Forward to JSP
        request.getRequestDispatcher("news/newsList.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
         * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
