/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.loanrequest;

import context.LoanRequestDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoanRequest;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "EditLoanRequestServlet", urlPatterns = {"/edit-loan-request"})
public class EditLoanRequestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("id"));
        LoanRequestDAO loanRequestDAO = new LoanRequestDAO();
        LoanRequest loanRequest = loanRequestDAO.getLoanRequestById(requestId);

        if (loanRequest != null && "Pending".equals(loanRequest.getStatus())) {
            request.setAttribute("loanRequest", loanRequest);
            RequestDispatcher dispatcher = request.getRequestDispatcher("editLoanRequest.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("viewLoanPackage.jsp?error=Invalid request or status not pending");
        }
    }
}
