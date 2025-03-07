package controller.loanrequest;

import context.LoanRequestDAO;
import model.LoanRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoanRequestDetailServlet extends HttpServlet {

    private LoanRequestDAO loanRequestDAO = new LoanRequestDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("request_id"));
        LoanRequest loan = loanRequestDAO.get(requestId);
        request.setAttribute("loan", loan);
        request.getRequestDispatcher("loan/loan_detail.jsp").forward(request, response);
    }
}
