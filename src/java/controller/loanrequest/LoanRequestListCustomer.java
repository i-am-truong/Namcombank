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
import model.Customer;
import model.LoanRequest;

/**
 * Controller for displaying loan requests list
 */
@WebServlet(name = "LoanRequestListCustomer", urlPatterns = {"/customer-loan-requests"})
public class LoanRequestListCustomer extends HttpServlet {

    private LoanRequestDAO loanRequestDAO;

    @Override
    public void init() throws ServletException {
        loanRequestDAO = new LoanRequestDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            
            if (customer == null) {
                response.sendRedirect("login");
                return;
            }

            int customerId = customer.getCustomerId();
            
            // Lấy danh sách yêu cầu vay theo customer_id
            ArrayList<LoanRequest> loanRequests = loanRequestDAO.getLoanRequestsByCustomerId(customerId);

            // Tính toán số lượng yêu cầu vay theo trạng thái
            int totalRequests = loanRequestDAO.countLoanRequestsByCustomer(customerId);
            int pendingRequests = loanRequestDAO.countLoanRequestsByStatusAndCustomer("Pending", customerId);
            int approvedRequests = loanRequestDAO.countLoanRequestsByStatusAndCustomer("Approved", customerId);
            int rejectedRequests = loanRequestDAO.countLoanRequestsByStatusAndCustomer("Rejected", customerId);

            // Đặt các thuộc tính vào request
            request.setAttribute("loanRequests", loanRequests);
            request.setAttribute("totalRequests", totalRequests);
            request.setAttribute("pendingRequests", pendingRequests);
            request.setAttribute("approvedRequests", approvedRequests);
            request.setAttribute("rejectedRequests", rejectedRequests);

            // Lưu các tham số tìm kiếm để hiển thị lại trên form
            request.setAttribute("customerId", customerId);
            request.setAttribute("customerName", customer.getFullname());
            
            // Chuyển đến trang danh sách yêu cầu vay
            request.getRequestDispatcher("/loanpackage-customer/viewLoanRequest.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Lỗi Controller: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorDetail", e.toString() + ": " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
