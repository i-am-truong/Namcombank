/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.loanrequest;

import dao.LoanRequestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoanRequest;

/**
 *
 * @author lenovo
 */
public class CreateLoanServlet extends HttpServlet {

    private final LoanRequestDAO loanRequestDAO = new LoanRequestDAO();

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
            out.println("<title>Servlet CreateLoanServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateLoanServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/loanrequest/loan-request-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String customerName = request.getParameter("customerName");
            double loanAmount = Double.parseDouble(request.getParameter("loanAmount"));
            double minAmount = Double.parseDouble(request.getParameter("minAmount"));
            double maxAmount = Double.parseDouble(request.getParameter("maxAmount"));

            if (loanAmount < minAmount || loanAmount > maxAmount) {
                request.setAttribute("error", "Loan amount must be between " + minAmount + " and " + maxAmount + " VND.");
                request.getRequestDispatcher("/loanrequest/loan-request-form.jsp").forward(request, response);
                return;
            }

            LoanRequest loanRequest = new LoanRequest();
            loanRequest.setApprovalStatus("Pending");
            loanRequest.setStaffId(1); // Giá trị giả định, nên lấy từ session

            loanRequest.setCustomerName(customerName);
            loanRequest.setLoanAmount(loanAmount);

            loanRequestDAO.insert(loanRequest);
            response.sendRedirect("loan-request-list");

        } catch (Exception e) {
            System.out.println("Error creating loan request: " + e.getMessage());
            request.setAttribute("error", "Không thể tạo yêu cầu vay");
            request.getRequestDispatcher("/loanrequest/loan-request-form.jsp").forward(request, response);
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

}
