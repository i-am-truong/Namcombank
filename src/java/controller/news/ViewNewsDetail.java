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
import model.News;

/**
 *
 * @author Bernie
 */
public class ViewNewsDetail extends HttpServlet {

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
        try {
            // Get news ID from request parameter
            String newsIdParam = request.getParameter("nId");

            if (newsIdParam != null && !newsIdParam.isEmpty()) {
                int newsId = Integer.parseInt(newsIdParam);

                // Retrieve news details using NewsDAO
                NewsDAO newsDAO = new NewsDAO();
                News news = newsDAO.getNewsById(newsId);

                if (news != null) {
                    // Set news as request attribute
                    request.setAttribute("news", news);

                    // Forward to the news detail JSP
                    request.getRequestDispatcher("news/viewNewsDetail.jsp").forward(request, response);
                    return;
                }
            }

            // If news not found or invalid ID, redirect to news list
            response.sendRedirect("newsListStaff");

        } catch (NumberFormatException e) {
            // If parsing fails, redirect to news list
            response.sendRedirect("newsListStaff");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("newsListStaff");
        }
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
        processRequest(request, response);
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
