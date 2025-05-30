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
import model.Feedback;

/**
 *
 * @author admin
 */
@MultipartConfig
public class addFeedback extends HttpServlet {

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
            out.println("<title>Servlet addFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addFeedback at " + request.getContextPath() + "</h1>");
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
        } else {
            Integer customer_id = Integer.parseInt(session.getAttribute("customer_id").toString());
            request.setAttribute("customer_is", customer_id);
            request.getRequestDispatcher("feedback/feedback-create.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        } else {
            Part filePart = request.getPart("attachment"); // Nhận file từ form
            byte[] attachment = null;
            if (filePart != null && filePart.getSize() > 0) {
                InputStream inputStream = filePart.getInputStream();
                attachment = inputStream.readAllBytes();
            }

            Integer customerId = Integer.parseInt(request.getParameter("customer_id"));
            String content = request.getParameter("content");
            String submittedAt = request.getParameter("submitted_at");
            String feedback_type = request.getParameter("feedback_type");
            int rating = Integer.parseInt(request.getParameter("rating"));

            if (content == null || content.trim().isEmpty()) {
                if (rating < 5) {
                    request.setAttribute("errorContent", "Please give your feedback ratings below 5.");
                    request.getRequestDispatcher("feedback/feedback-create.jsp").forward(request, response);
                    return;
                }
            } else if (!checkContent(content)) {
                request.setAttribute("errorContent", "Content contains invalid characters.");
                request.setAttribute("content", content);
                request.setAttribute("feedback_type", feedback_type);
                request.setAttribute("rating", rating);
                request.getRequestDispatcher("feedback/feedback-create.jsp").forward(request, response);
                return;
            }

            if (rating < 5 && (attachment == null || attachment.length == 0)) {
                request.setAttribute("errorAttachment", "Attachment is required for ratings below 5.");
                request.setAttribute("content", content);
                request.setAttribute("feedback_type", feedback_type);
                request.setAttribute("rating", rating);
                request.getRequestDispatcher("feedback/feedback-create.jsp").forward(request, response);
                return;
            }

            FeedbackDao dao = new FeedbackDao();
            Feedback feedback = new Feedback();
            feedback.setCustomer_id(customerId);
            feedback.setContent(formatContent(content));
            feedback.setRating(rating);
            feedback.setFeedback_type(feedback_type);
            feedback.setSubmitted_at(submittedAt);
            feedback.setAttachment(attachment);

            dao.insertFeedback(feedback);
            response.sendRedirect("feedback/thankYou.jsp");

        }
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
        return content.matches("^[\\p{L}0-9\\s.,!?]+$");
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
