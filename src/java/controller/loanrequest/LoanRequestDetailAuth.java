package controller.loanrequest;

import context.LoanRequestDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Asset;
import model.LoanRequest;
import model.auth.Staff;

/**
 * Controller to display loan request details and handle approval/rejection/deletion
 */
@WebServlet(name = "LoanRequestDetailAuth", urlPatterns = {"/loan-request-detail"})
public class LoanRequestDetailAuth extends BaseRBACControlller {

    private static final Logger LOGGER = Logger.getLogger(LoanRequestDetailAuth.class.getName());
    private LoanRequestDAO loanRequestDAO;

    @Override
    public void init() throws ServletException {
        loanRequestDAO = new LoanRequestDAO();
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Get form information
            String requestIdParam = request.getParameter("requestId");
            String action = request.getParameter("action");

            // Validate required parameters
            if (requestIdParam == null || requestIdParam.isEmpty() || action == null || action.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Invalid data. Missing requestId or action.");
                response.sendRedirect("loan-requests-auth");
                return;
            }

            // Parse loan request ID
            int requestId;
            try {
                requestId = Integer.parseInt(requestIdParam);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid loan request ID: " + requestIdParam);
                response.sendRedirect("loan-requests-auth");
                return;
            }

            // Get loan request information
            LoanRequest loanRequest = loanRequestDAO.getLoanRequestById(requestId);
            if (loanRequest == null) {
                request.getSession().setAttribute("errorMessage", "Loan request does not exist.");
                response.sendRedirect("loan-requests-auth");
                return;
            }

            // Get roleId from session
            HttpSession session = request.getSession();
            Integer roleId = (Integer) session.getAttribute("roleId");

            // Set default value if roleId is still null
            if (roleId == null) {
                roleId = 0; // Default value with no permissions
            }

            // Determine approval or deletion rights
            boolean canApprove = (roleId == 1 || roleId == 3); // Admin and HeadOfStaff
            boolean canDelete = (roleId == 1); // Only Admin can delete

            // Check permissions for the requested action
            if (("approve".equals(action) || "reject".equals(action)) && !canApprove) {
                request.getSession().setAttribute("errorMessage", "You don't have permission to perform this action.");
                response.sendRedirect("loan-request-detail?id=" + requestId);
                return;
            }

            if ("delete".equals(action) && !canDelete) {
                request.getSession().setAttribute("errorMessage", "You don't have permission to delete loan requests.");
                response.sendRedirect("loan-request-detail?id=" + requestId);
                return;
            }

            boolean success = false;
            String notes = request.getParameter("notes");

            // Handle approval, rejection, or deletion
            if ("approve".equals(action)) {
                if (notes == null || notes.trim().isEmpty()) {
                    notes = "Approved by " + account.getUsername();
                }

                success = loanRequestDAO.approveLoanRequest(requestId, notes);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Loan request has been approved successfully.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not approve loan request. Please try again.");
                }
                response.sendRedirect("loan-request-detail?id=" + requestId);
                return;
            } else if ("reject".equals(action)) {

                if (notes == null || notes.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMessage", "Rejection reason cannot be empty.");
                    response.sendRedirect("loan-request-detail?id=" + requestId);
                    return;
                }

                success = loanRequestDAO.rejectLoanRequest(requestId, account.getId(), notes);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Loan request has been rejected.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not reject loan request. Please try again.");
                }
                response.sendRedirect("loan-request-detail?id=" + requestId);
                return;
            } else if ("delete".equals(action)) {
                // Perform loan request deletion
                success = loanRequestDAO.deleteLoanRequest(requestId);

                if (success) {
                    request.getSession().setAttribute("successDeleteMessage", "Loan request has been deleted successfully.");
                    // Redirect to loan requests list after deletion
                    response.sendRedirect("loan-requests-auth");
                    return;
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not delete loan request. Please try again.");
                    response.sendRedirect("loan-request-detail?id=" + requestId);
                    return;
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Invalid action: " + action);
                response.sendRedirect("loan-request-detail?id=" + requestId);
                return;
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("loan-requests-auth");
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Check if this is a confirmation from form
            String confirmAction = request.getParameter("confirm");
            String action = request.getParameter("action");

            if ("true".equals(confirmAction) && action != null && !action.isEmpty()) {
                // Get information from session
                HttpSession session = request.getSession();
                Integer requestId = (Integer) session.getAttribute("confirmRequestId");
                String notes = (String) session.getAttribute("confirmNotes");

                if (requestId != null) {
                    // Create a new request with confirmation information
                    request.setAttribute("requestId", requestId.toString());
                    request.setAttribute("action", action);
                    request.setAttribute("notes", notes);
                    request.setAttribute("confirm", "true");

                    // Forward to POST method
                    doAuthorizedPost(request, response, account);
                    return;
                }
            }

            // Get loan request ID
            String requestIdParam = request.getParameter("id");
            if (requestIdParam == null || requestIdParam.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Loan request ID was not provided.");
                response.sendRedirect("loan-requests-auth");
                return;
            }

            int requestId;
            try {
                requestId = Integer.parseInt(requestIdParam);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid loan request ID: " + requestIdParam);
                response.sendRedirect("loan-requests-auth");
                return;
            }

            // Get loan request details
            LoanRequest loanRequest = loanRequestDAO.getLoanRequestById(requestId);

            if (loanRequest == null) {
                request.getSession().setAttribute("errorMessage", "Loan request does not exist.");
                response.sendRedirect("loan-requests-auth");
                return;
            }

            // Get customer's assets
            ArrayList<Asset> customerAssets = loanRequestDAO.getCustomerAssets(loanRequest.getCustomerId());

            // Set attributes in request
            request.setAttribute("loanRequest", loanRequest);
            request.setAttribute("customerAssets", customerAssets);

            // Get role information to check permissions
            HttpSession session = request.getSession();
            Integer roleId = (Integer) session.getAttribute("roleId");
            if (roleId == null) {
                roleId = 0;
            }

            boolean canApprove = (roleId == 1 || roleId == 3); // Admin and HeadOfStaff
            boolean canDelete = (roleId == 1); // Only Admin can delete

            request.setAttribute("canApprove", canApprove);
            request.setAttribute("canDelete", canDelete);
            request.setAttribute("isAdmin", roleId == 1);
            request.setAttribute("isHeadOfStaff", roleId == 3);

            // Forward to detail page
            request.getRequestDispatcher("/loanrequire-admin/viewLoanRequestDetail.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error displaying loan request details: ", e);
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("loan-requests-auth");
        }
    }
}
