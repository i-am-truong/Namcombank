/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import context.SavingFeedbackDAO;
import model.SavingFeedback;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class SavingFeedbackAnswer extends BaseRBACControlller {

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
            out.println("<title>Servlet SavingFeedbackAnswer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SavingFeedbackAnswer at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }
        String feedback_idStr = request.getParameter("feedback_id");
        int feedback_id = Integer.parseInt(feedback_idStr);
        String answer = request.getParameter("answer");
        String answer_at = getCurrentDate();

        dao.answer(feedback_id, answer, answer_at);
        List<SavingFeedback> list = dao.getAllSavingFeedback();
        request.setAttribute("list", list);
        request.getRequestDispatcher("Saving/SavingFeedbackAnswer.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }
        List<SavingFeedback> list = dao.getAllSavingFeedback();
        request.setAttribute("list", list);
        request.getRequestDispatcher("Saving/SavingFeedbackAnswer.jsp").forward(request, response);
    }

    private String getCurrentDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(new Date());
    }

}
