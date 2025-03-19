package controller.repayment_schedule;

import context.RepaymentScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.PaymentHistory;

@WebServlet(name = "PaymentHistoryList", urlPatterns = {"/payment-history"})
public class PaymentHistoryList extends HttpServlet {

    private RepaymentScheduleDAO repaymentScheduleDAO = new RepaymentScheduleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get session
        HttpSession session = request.getSession(false);

        // Check session and customer
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get customer from session
        Customer customer = (Customer) session.getAttribute("customer");
        int customerId = customer.getCustomerId();

        // Add customer ID to request for display in JSP
        request.setAttribute("customerId", customerId);

        // Get payment history
        List<PaymentHistory> paymentHistory = repaymentScheduleDAO.getPaymentHistory(customerId);

        // Set attributes for JSP
        request.setAttribute("paymentHistory", paymentHistory);
        request.setAttribute("customer", customer);

        // Forward to JSP
        // Xác nhận đường dẫn chính xác
        request.getRequestDispatcher("/staff-manager/repayment-history.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
