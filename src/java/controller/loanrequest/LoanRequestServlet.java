package controller.loanrequest;

import context.LoanRequestDAO;
import jakarta.servlet.annotation.WebServlet;
import model.LoanRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LoanRequestServlet extends HttpServlet {

    private LoanRequestDAO loanRequestDAO = new LoanRequestDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");
        if (customerId == null) {
            response.sendRedirect("../login");
            return;
        }
        int packageId = Integer.parseInt(request.getParameter("package_id"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        LoanRequest loan = new LoanRequest();
        loan.setCustomerId(customerId);
        loan.setPackageId(packageId);
        loan.setAmount(amount);

        loanRequestDAO.insert(loan);
        response.sendRedirect("loanrequest/loan-request-list.jsp");
    }
}
