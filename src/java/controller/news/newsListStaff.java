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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Customer;
import model.News;

/**
 *
 * @author ADMIN
 */
public class newsListStaff extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet newsListStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet newsListStaff at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession(false);

        // The logical error is in this if condition - it's using OR logic incorrectly
        // Fix: Check if session exists and user has valid role (1, 2, 3, or 4)
        if (session == null || session.getAttribute("roleId") == null) {
            response.sendRedirect("admin.login");
            return;
        }

        int roleId = (int) session.getAttribute("roleId");
        if (roleId != 1 && roleId != 2 && roleId != 3 && roleId != 4) {
            response.sendRedirect("admin.login");
            return;
        }

        // Rest of your existing code for displaying news
        String indexPage = request.getParameter("index");
        String type = request.getParameter("type");
        System.out.println("Request type parameter: " + type); // Debug log

        NewsDAO dao = new NewsDAO();
        ArrayList<News> n = new ArrayList<News>();

        // Only show waiting news to role 1 (admin)
        if (type != null && type.equals("WaitingNews") && roleId == 1) {
            // Handle waiting news
            int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
            n = dao.paggingWaitingList(index);
            int count = dao.countWaiting();
            int pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;

            request.setAttribute("n", n);
            request.setAttribute("pages", pages);
            request.setAttribute("type", "WaitingNews"); // Keep the type for the view
        } else {
            // Get published news (default)
            int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
            n = dao.pagging(index);
            int count = dao.count("");
            int pages = (count % 4 != 0) ? (count / 4) + 1 : count / 4;

            request.setAttribute("n", n);
            request.setAttribute("pages", pages);
            request.setAttribute("type", "News"); // For highlighting the active tab
        }

        // Forward to the JSP page
        request.getRequestDispatcher("news/newsListStaff.jsp").forward(request, response);
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
        NewsDAO dao = new NewsDAO();
        int nId = Integer.parseInt(request.getParameter("nId"));
        dao.deleteNews(nId);
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
