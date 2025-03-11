package controller.loanrequest;

import context.LoanRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import model.Asset;
import model.LoanRequest;
import model.auth.Staff;

/**
 * Controller for displaying loan request details
 */
@WebServlet(name = "LoanRequestDetailAuth", urlPatterns = {"/loan-request-detail"})
public class LoanRequestDetailAuth extends HttpServlet {

    private LoanRequestDAO loanRequestDAO;

    @Override
    public void init() throws ServletException {
        loanRequestDAO = new LoanRequestDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get loan request ID
            int requestId = Integer.parseInt(request.getParameter("id"));
            
            // Get loan request details
            LoanRequest loanRequest = loanRequestDAO.getLoanRequestById(requestId);
            
            if (loanRequest == null) {
                request.getSession().setAttribute("errorMessage", "Loan request not found");
                response.sendRedirect(request.getContextPath() + "/loan-requests-auth");
                return;
            }
            
            // Get customer's assets
            ArrayList<Asset> customerAssets = loanRequestDAO.getCustomerAssets(loanRequest.getCustomerId());
            
            // Set attributes in request
            request.setAttribute("loanRequest", loanRequest);
            request.setAttribute("customerAssets", customerAssets);
            
            // Forward to detail page
            request.getRequestDispatcher("/loanpackage-admin/viewLoanRequestDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid loan request ID");
            response.sendRedirect(request.getContextPath() + "/loan-requests-auth");
        } catch (Exception e) {
            System.err.println("Detail Controller Error: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/loan-requests-auth");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form information
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String action = request.getParameter("action");
            String notes = request.getParameter("notes");
            
            // Get logged-in user information
            HttpSession session = request.getSession();
            Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff");
            
            boolean success = false;
            String message = "";
            
            // Handle approval or rejection
            if ("approve".equals(action)) {
                success = loanRequestDAO.approveLoanRequest(requestId, notes);
                message = success ? "Loan request has been approved successfully" : "An error occurred during approval";
            } else if ("reject".equals(action)) {
                success = loanRequestDAO.rejectLoanRequest(requestId, loggedInStaff.getId(), notes);
                message = success ? "Loan request has been rejected" : "An error occurred during rejection";
            }
            
            // Set message and redirect
            if (success) {
                request.getSession().setAttribute("successMessage", message);
            } else {
                request.getSession().setAttribute("errorMessage", message);
            }
            
            response.sendRedirect(request.getContextPath() + "/loan-request-detail?id=" + requestId);
            
        } catch (Exception e) {
            System.err.println("Error processing POST request: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/loan-requests-auth");
        }
    }
}
