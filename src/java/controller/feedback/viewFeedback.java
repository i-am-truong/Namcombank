/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import context.FeedbackDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;

/**
 *
 * @author admin
 */
public class viewFeedback extends HttpServlet {

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
            out.println("<title>Servlet viewFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewFeedback at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        }

        FeedbackDao dao = new FeedbackDao();
        List<Feedback> list = new ArrayList<>();
        String ratingStr = request.getParameter("rating");
        String indexStr = request.getParameter("index");

        int index = 1; // Mặc định trang đầu tiên
        if (indexStr != null && !indexStr.isEmpty()) {
            try {
                index = Integer.parseInt(indexStr);
            } catch (NumberFormatException e) {
                index = 1; // Nếu lỗi, quay về trang đầu
            }
        }

        int rating = 0; 
        if (ratingStr != null && !ratingStr.isEmpty()) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                rating = 0;
            }
        }

        int count;
        if (rating > 0) {
            count = dao.getTotalFeedbackByRating(rating);
            list = dao.pagingFeedbackByRating(index, rating);
        } else {
            count = dao.getTotalFeedback();
            list = dao.pagingFeedback(index);
        }

        int endPage = (count % 4 == 0) ? count / 4 : (count / 4) + 1;

        request.setAttribute("listPaging", list);
        request.setAttribute("endP", endPage);
        request.setAttribute("selectedRating", rating); // Giữ lại giá trị rating
        request.getRequestDispatcher("feedback/viewFeedback.jsp").forward(request, response);
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

        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        }

        String indexStr = request.getParameter("index");
        int index = 1;

        if (indexStr != null && !indexStr.isEmpty()) {
            try {
                index = Integer.parseInt(indexStr);
            } catch (NumberFormatException e) {
                index = 1;
            }
        }

        String ratingStr = request.getParameter("rating");
        int rating = 0;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                rating = 0;
            }
        }

        FeedbackDao dao = new FeedbackDao();
        int count;
        List<Feedback> listPaging;

        if (rating > 0) {
            count = dao.getTotalFeedbackByRating(rating);
            listPaging = dao.pagingFeedbackByRating(index, rating);
        } else {
            count = dao.getTotalFeedback();
            listPaging = dao.pagingFeedback(index);
        }

        int endPage = count / 4;
        if (count % 4 != 0) {
            endPage++;
        }

        request.setAttribute("listPaging", listPaging);
        request.setAttribute("endP", endPage);
        request.setAttribute("selectedRating", rating);
        request.setAttribute("currentPage", index);
        request.getRequestDispatcher("feedback/viewFeedback.jsp").forward(request, response);
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
