package controller.contract;

import context.ContractDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Contract;

/**
 * Servlet to handle contract approvals and filtering
 */
public class ContractApprovalServlet extends HttpServlet {

    private final ContractDAO contractDAO = new ContractDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sort = request.getParameter("sort"); // "asc" or "desc"
        String status = request.getParameter("status"); // "pending", "approved", "rejected", "all"
        String search = request.getParameter("search"); // Tìm kiếm theo tên khách hàng
        
        List<Contract> contracts = contractDAO.filterContracts(status, search, sort);

        request.setAttribute("contracts", contracts);
        request.getRequestDispatcher("contract/managerContracts.jsp").forward(request, response); // Corrected JSP redirection
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int contractId = Integer.parseInt(request.getParameter("contractId"));
            String action = request.getParameter("action");

            Contract contract = contractDAO.get(contractId);
            if (contract != null) {
                contract.setStatus("approve".equals(action) ? "approved" : "rejected");
                contractDAO.update(contract);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid contract ID: " + e.getMessage());
        }

        response.sendRedirect("contractApproval"); // Redirect back to contract list
    }

    @Override
    public String getServletInfo() {
        return "Handles contract approval and filtering";
    }
}
