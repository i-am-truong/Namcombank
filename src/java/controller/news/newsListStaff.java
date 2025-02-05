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
        HttpSession session = request.getSession();
        Customer o = (Customer) session.getAttribute("user");
        if (o == null) {
            response.sendRedirect("login");
            return; // Ensure the method returns to avoid further execution
        } else {
            String indexPage = request.getParameter("index");
            String type = request.getParameter("type");
            NewsDAO dao = new NewsDAO();
            ArrayList<News> n = new ArrayList<News>();
            if (type == "" || type == null || type.equals("News")) {
                if (indexPage != null) {
                    int index = Integer.parseInt(indexPage);
                    n = dao.pagging(index);

                } else {

                    n = dao.pagging(1);
                }

                int count = dao.count("");
                int pages = 0;
                if (count % 4 != 0) {
                    pages = (count / 4) + 1;
                } else {
                    pages = count / 4;
                }
                request.setAttribute("n", n);
                request.setAttribute("pages", pages);

                request.getRequestDispatcher("news/newsListStaff.jsp").forward(request, response);
            } else {
                if (o.equals("Customer")) {
                    if (indexPage != null) {
                        int index = Integer.parseInt(indexPage);

                        n = dao.paggingWaitingList(index);

                    } else {

                        n = dao.paggingWaitingList(1);

                    }

                    int count = dao.countWaiting();
                    int pages = 0;
                    if (count % 4 != 0) {
                        pages = (count / 4) + 1;
                    } else {
                        pages = count / 4;
                    }
                    request.setAttribute("n", n);
                    request.setAttribute("pages", pages);

                    request.getRequestDispatcher("news/newsListStaff.jsp").forward(request, response);
                } else {
                    response.sendRedirect("login");
                }

            }

            response.sendRedirect("login");
        }

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
