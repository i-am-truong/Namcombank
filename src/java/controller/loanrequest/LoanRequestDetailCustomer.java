package controller.loanrequest;

import context.LoanRequestDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Asset;
import model.LoanRequest;
import model.Customer;
import model.auth.Staff;

@WebServlet(name = "LoanRequestDetailCustomer", urlPatterns = {"/customer-loan-request-detail"})
public class LoanRequestDetailCustomer extends HttpServlet {

    private LoanRequestDAO loanRequestDAO;

    @Override
    public void init() throws ServletException {
        loanRequestDAO = new LoanRequestDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID yêu cầu vay từ tham số
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new NumberFormatException("Thiếu ID yêu cầu vay.");
            }

            int requestId = Integer.parseInt(idParam);
            LoanRequest loanRequest = loanRequestDAO.getLoanRequestById(requestId);

            if (loanRequest == null) {
                request.getSession().setAttribute("errorMessage", "Yêu cầu vay không tồn tại.");
                response.sendRedirect(request.getContextPath() + "/customer-loan-requests");
                return;
            }

            // Kiểm tra quyền truy cập của khách hàng
            HttpSession session = request.getSession();
            Customer loggedInCustomer = (Customer) session.getAttribute("customer");

            if (loggedInCustomer == null || loanRequest.getCustomerId() != loggedInCustomer.getCustomerId()) {
                request.getSession().setAttribute("errorMessage", "Bạn không có quyền xem yêu cầu này.");
                response.sendRedirect(request.getContextPath() + "/customer-loan-requests");
                return;
            }

            // Lấy danh sách tài sản của khách hàng
            ArrayList<Asset> customerAssets = loanRequestDAO.getCustomerAssets(loanRequest.getCustomerId());

            // Gửi dữ liệu đến JSP
            request.setAttribute("loanRequest", loanRequest);
            request.setAttribute("customerAssets", customerAssets);

            request.getRequestDispatcher("/loanpackage-customer/viewLoanRequestDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID yêu cầu vay không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer-loan-requests");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customer-loan-requests");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String action = request.getParameter("action");
            String notes = request.getParameter("notes");

            if (action == null || (!action.equals("approve") && !action.equals("reject"))) {
                request.getSession().setAttribute("errorMessage", "Hành động không hợp lệ.");
                response.sendRedirect(request.getContextPath() + "/customer-loan-request-detail?id=" + requestId);
                return;
            }

            HttpSession session = request.getSession();
            Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff");

            if (loggedInStaff == null) {
                request.getSession().setAttribute("errorMessage", "Bạn cần đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            boolean success = false;
            String message = "";

            if ("approve".equals(action)) {
                success = loanRequestDAO.approveLoanRequest(requestId, notes);
                message = success ? "Yêu cầu vay đã được phê duyệt." : "Lỗi khi phê duyệt.";
            } else if ("reject".equals(action)) {
                success = loanRequestDAO.rejectLoanRequest(requestId, loggedInStaff.getId(), notes);
                message = success ? "Yêu cầu vay đã bị từ chối." : "Lỗi khi từ chối.";
            }

            request.getSession().setAttribute(success ? "successMessage" : "errorMessage", message);
            response.sendRedirect(request.getContextPath() + "/customer-loan-request-detail?id=" + requestId);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer-loan-requests");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customer-loan-requests");
        }
    }
}
