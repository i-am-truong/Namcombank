/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import context.FeedbackDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;

/**
 *
 * @author admin
 */
@MultipartConfig
public class editFeedback extends HttpServlet {

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
            out.println("<title>Servlet editFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editFeedback at " + request.getContextPath() + "</h1>");
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
//        HttpSession session = request.getSession();
//        if (session.getAttribute("customer") == null) {
//            response.sendRedirect("login");
//            return;
//        }
//
//        String content = request.getParameter("content");
//        String submitted_at = request.getParameter("submitted_at");
//        String ratingStr = request.getParameter("rating");
//        int rating = Integer.parseInt(ratingStr);
//
//        FeedbackDao dao = new FeedbackDao();
//        int feedback_id = dao.getFeedbackId(content, submitted_at, rating);
//        request.setAttribute("content", content);
//        request.setAttribute("feedback_id", feedback_id);
//        request.setAttribute("submitted_at", submitted_at);
//        request.setAttribute("rating", rating);
//        request.getRequestDispatcher("feedback/editFeedback.jsp").forward(request, response);

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
        Part filePart = request.getPart("attachment");
        byte[] attachment = null;
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                attachment = inputStream.readAllBytes();
            }
        }

        FeedbackDao dao = new FeedbackDao();
        int customer_id = (int) session.getAttribute("customer_id");
        String content = request.getParameter("content");
        String submitted_at = request.getParameter("submitted_at");
        String feedback_type = request.getParameter("feedback_type");

        String ratingStr = request.getParameter("rating");
        int rating = (ratingStr != null && !ratingStr.isEmpty()) ? Integer.parseInt(ratingStr) : 0;

//        int feedback_id = dao.getFeedbackId(content, submitted_at, rating, feedback_type);
        int feedback_id = Integer.parseInt(request.getParameter("feedback_id"));

        if (attachment == null || attachment.length==0) {
            dao.updateFeedback2(content, submitted_at, rating, feedback_id, feedback_type);
        } else {
            dao.updateFeedback(content, submitted_at, rating, feedback_id, feedback_type, attachment);
        }
        response.sendRedirect("cusFeedback?customer_id=" + customer_id);
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
