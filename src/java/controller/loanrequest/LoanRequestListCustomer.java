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
import model.LoanRequest;
import model.auth.Role;
import model.auth.Staff;

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
        // Kiểm tra phiên đăng nhập

        try {

            // Lấy tham số tìm kiếm
            String customerName = request.getParameter("customerName");
            String packageName = request.getParameter("packageName");
            String status = request.getParameter("status");
            String minAmountStr = request.getParameter("minAmount");
            String maxAmountStr = request.getParameter("maxAmount");
            String requestDateFrom = request.getParameter("requestDateFrom");
            String requestDateTo = request.getParameter("requestDateTo");
            String approvedBy = request.getParameter("approvedBy");
            String approvalDateFrom = request.getParameter("approvalDateFrom");
            String approvalDateTo = request.getParameter("approvalDateTo");
            String hasAssetStr = request.getParameter("hasAsset");

            // Chuyển đổi giá trị tìm kiếm
            Double minAmount = null;
            Double maxAmount = null;
            Boolean hasAsset = null;

            if (minAmountStr != null && !minAmountStr.isEmpty()) {
                try {
                    minAmount = Double.parseDouble(minAmountStr.replace(",", ""));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Số tiền tối thiểu không hợp lệ");
                }
            }

            if (maxAmountStr != null && !maxAmountStr.isEmpty()) {
                try {
                    maxAmount = Double.parseDouble(maxAmountStr.replace(",", ""));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Số tiền tối đa không hợp lệ");
                }
            }

            if (hasAssetStr != null && !hasAssetStr.isEmpty()) {
                hasAsset = "1".equals(hasAssetStr) || "true".equalsIgnoreCase(hasAssetStr);
            }

            // Lấy danh sách yêu cầu vay theo điều kiện tìm kiếm
            ArrayList<LoanRequest> loanRequests = loanRequestDAO.list();
            // Tính toán số lượng yêu cầu vay theo trạng thái (cho các card thống kê)
            int totalRequests = loanRequestDAO.countAllLoanRequests();
            int pendingRequests = loanRequestDAO.countLoanRequestsByStatus("Pending");
            int approvedRequests = loanRequestDAO.countLoanRequestsByStatus("Approved");
            int rejectedRequests = loanRequestDAO.countLoanRequestsByStatus("Rejected");

            // Đặt các thuộc tính vào request
            request.setAttribute("loanRequests", loanRequests);
            request.setAttribute("totalRequests", totalRequests);
            request.setAttribute("pendingRequests", pendingRequests);
            request.setAttribute("approvedRequests", approvedRequests);
            request.setAttribute("rejectedRequests", rejectedRequests);

            // Lưu các tham số tìm kiếm để hiển thị lại trên form
            request.setAttribute("customerName", customerName);
            request.setAttribute("packageName", packageName);
            request.setAttribute("status", status);
            request.setAttribute("minAmount", minAmountStr);
            request.setAttribute("maxAmount", maxAmountStr);
            request.setAttribute("requestDateFrom", requestDateFrom);
            request.setAttribute("requestDateTo", requestDateTo);
            request.setAttribute("approvedBy", approvedBy);
            request.setAttribute("approvalDateFrom", approvalDateFrom);
            request.setAttribute("approvalDateTo", approvalDateTo);
            request.setAttribute("hasAsset", hasAssetStr);

            // Chuyển đến trang danh sách yêu cầu vay
            request.getRequestDispatcher("/loanpackage-customer/viewLoanRequest.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Lỗi Controller: " + e.getMessage());
            e.printStackTrace();

            // Thêm dòng này để hiển thị lỗi chi tiết
            request.setAttribute("errorDetail", e.toString() + ": " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
