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
import java.util.List;
import model.Feedback_id;

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
        if (!checkContent(content)) {
            List<Feedback_id> list = dao.getCusFeedback(customer_id);
            request.setAttribute("errorContent", "Content contains invalid characters");
            request.setAttribute("list", list);
            request.getRequestDispatcher("feedback/myFeedback.jsp").forward(request, response);
            return;
        }
        String submitted_at = request.getParameter("submitted_at");
        String feedback_type = request.getParameter("feedback_type");
        int feedback_id = Integer.parseInt(request.getParameter("feedback_id"));
        String ratingStr = request.getParameter("rating");
        int rating = (ratingStr != null && !ratingStr.isEmpty()) ? Integer.parseInt(ratingStr) : 0;

//        int feedback_id = dao.getFeedbackId(content, submitted_at, rating, feedback_type);
        if (rating > 4) {
            if ((content != null) && (attachment == null)) {
                dao.updateFeedbackNoContentAndAttachment(formatContent(content), submitted_at, rating, feedback_id, feedback_type);
            }
            if ((content == null || content.isEmpty()) && (attachment != null)) {
                dao.updateFeedback(content, submitted_at, rating, feedback_id, feedback_type, attachment);
            }
            if ((content == null || content.isEmpty()) && (attachment == null)) {
                dao.updateFeedbackNoContentAndAttachment(content, submitted_at, rating, feedback_id, feedback_type);

            } else {
                if (attachment == null) {
                    dao.updateFeedbackNoContentAndAttachment(formatContent(content), submitted_at, rating, feedback_id, feedback_type);
//                    dao.updateFeedback(formatContent(content), submitted_at, rating, feedback_id, feedback_type, attachment);
                } else if (attachment != null) {
                    dao.updateFeedback(formatContent(content), submitted_at, rating, feedback_id, feedback_type, attachment);
                } else {
                    dao.updateFeedback(formatContent(content), submitted_at, rating, feedback_id, feedback_type, attachment);
                }
            }
        } else {

            boolean hasAttachment = dao.checkFeedbackAttachment(feedback_id);
            if (content == null || content.isEmpty()) {
                List<Feedback_id> list = dao.getCusFeedback(customer_id);
                request.setAttribute("errorContentNull", "Please give your feedback ratings below 5");
                request.setAttribute("list", list);
                request.getRequestDispatcher("feedback/myFeedback.jsp").forward(request, response);
                return;
            }
            if (content != null && attachment != null) {
                dao.updateFeedback(formatContent(content), submitted_at, rating, feedback_id, feedback_type, attachment);
            } else if (content != null && hasAttachment) {
                dao.updateFeedbackNoAttachment(formatContent(content), submitted_at, rating, feedback_id, feedback_type);
            } else {
                List<Feedback_id> list = dao.getCusFeedback(customer_id);
                request.setAttribute("errorAttachmentNull", "Please provide a photo for ratings below 5");
                request.setAttribute("list", list);
                request.getRequestDispatcher("feedback/myFeedback.jsp").forward(request, response);
                return;
            }
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

    public boolean checkContent(String content) {
        return content.matches("^[\\p{L}0-9\\s.,!?]*$");
    }

    private String formatContent(String content) {
        if (content == null || content.isEmpty()) {
            return null;
        }
        return Character.toUpperCase(content.charAt(0)) + content.substring(1);
    }

    public boolean checkAttachment(Part filePart) {
        return filePart != null && filePart.getSize() > 0;
    }

}
