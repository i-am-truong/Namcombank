/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

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
import model.Customer;
import model.Feedback;

/**
 *
 * @author admin
 */
public class viewCustomerFeedback extends HttpServlet {

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
            out.println("<title>Servlet viewCustomerFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewCustomerFeedback at " + request.getContextPath() + "</h1>");
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
        
//        HttpSession session = request.getSession(true);
//        Customer user = (Customer) session.getAttribute("user");// chua có login admin
//        if (user != null) {
//            request.getRequestDispatcher("user/addStaff.jsp").forward(request, response);
//        } else {
//
//            response.sendRedirect("login");
//        }

        FeedbackDao dao = new FeedbackDao();
        List<Feedback> list = new ArrayList<>();
        list = dao.getAllFeedback();
        request.setAttribute("list", list);
        request.getRequestDispatcher("feedback/viewCustomerFeedback.jsp").forward(request, response);
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

        FeedbackDao dao = new FeedbackDao();
        List<Feedback> list = new ArrayList<>();
        String ratingStr = request.getParameter("rating");

        if (ratingStr == null || ratingStr.isEmpty()) {
            list = dao.getAllFeedback();
        } else {
            try {
                int rating = Integer.parseInt(ratingStr);

                if (rating == 1) {
                    list = dao.getAllFeedback1();
                } else if (rating == 2) {
                    list = dao.getAllFeedback2();
                } else if (rating == 3) {
                    list = dao.getAllFeedback3();
                } else if (rating == 4) {
                    list = dao.getAllFeedback4();
                } else if (rating == 5) {
                    list = dao.getAllFeedback5();
                } else {
                    list = dao.getAllFeedback();
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                list = dao.getAllFeedback();
            }
        }
        request.setAttribute("list", list);
        request.getRequestDispatcher("feedback/viewCustomerFeedback.jsp").forward(request, response);
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
