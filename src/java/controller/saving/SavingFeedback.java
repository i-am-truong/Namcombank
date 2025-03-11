/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import context.SavingFeedbackDAO;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author admin
 */
@MultipartConfig
public class SavingFeedback extends HttpServlet {

    private final SavingFeedbackDAO dao = new SavingFeedbackDAO();

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
            out.println("<title>Servlet SavingFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SavingFeedback at " + request.getContextPath() + "</h1>");
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
        String savings_idStr = request.getParameter("savings_id");
        int savings_id = Integer.parseInt(savings_idStr);
        request.setAttribute("savings_id", savings_id);
        request.getRequestDispatcher("Saving/SavingFeedback_create.jsp").forward(request, response);
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
        int savings_id = Integer.parseInt(request.getParameter("savings_id"));

        String content = request.getParameter("content");
        String feedbackType = request.getParameter("feedback_type");
        String attachment = request.getParameter("attachment");  // Đọc đường dẫn ảnh từ form

        // Kiểm tra dữ liệu nhập
        if (!checkContent(content)) {
            request.setAttribute("errorC", "Vui lòng không nhập kí tự đặc biệt");
                    request.setAttribute("savings_id", savings_id);
            request.getRequestDispatcher("Saving/SavingFeedback_create.jsp").forward(request, response);
            return;
        } else if (attachment == null || attachment.isEmpty()) {
            request.setAttribute("errorA", "Vui lòng nhập đường dẫn ảnh");
                    request.setAttribute("savings_id", savings_id);
            request.getRequestDispatcher("Saving/SavingFeedback_create.jsp").forward(request, response);
            return;
        }

        String submittedAt = getCurrentDate();
        dao.insertSavingFeedback(content, submittedAt, savings_id, feedbackType, attachment);

        request.setAttribute("savings_id", savings_id);
        request.setAttribute("success", true);  // Hiển thị thông báo thành công
        request.getRequestDispatcher("Saving/SavingFeedback_create.jsp").forward(request, response);
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

    private String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return currentDate.format(formatter);
    }
}
