/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.loanrequest;

import context.LoanRequestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "DeleteLoanRequestServlet", urlPatterns = {"/delete-loan-request"})
public class DeleteLoanRequestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("id"));
        LoanRequestDAO loanRequestDAO = new LoanRequestDAO();

        boolean success = loanRequestDAO.deleteLoanRequest(requestId);
        if (success) {
            response.sendRedirect("customer-loan-requests?success=Loan request deleted successfully");
        } else {
            response.sendRedirect("customer-loan-requests?error=Cannot delete loan request");
        }

    }
}
