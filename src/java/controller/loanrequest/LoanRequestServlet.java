
import context.LoanPackageDAO;
import context.LoanRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.LoanPackage;
import model.LoanRequest;

@WebServlet(name = "LoanRequestServlet", urlPatterns = {"/loan-request"})
public class LoanRequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        List<String> errorMessages = new ArrayList<>();
        String packageIdStr = request.getParameter("package_id");
        String amountStr = request.getParameter("amount");
        int packageId = 0;
        BigDecimal amount = null;

        if (packageIdStr == null || amountStr == null || packageIdStr.trim().isEmpty() || amountStr.trim().isEmpty()) {
            errorMessages.add("Vui lòng nhập đầy đủ thông tin.");
        } else {
            try {
                packageId = Integer.parseInt(packageIdStr);
            } catch (NumberFormatException e) {
                errorMessages.add("Gói vay không hợp lệ.");
            }

            try {
                // Loại bỏ dấu phân cách hàng nghìn (dấu chấm hoặc dấu phẩy)
                String normalizedAmount = amountStr.replaceAll("[.,]", "");
                amount = new BigDecimal(normalizedAmount);
            } catch (NumberFormatException e) {
                errorMessages.add("Số tiền vay không hợp lệ.");
            }
        }

        LoanPackageDAO packageDAO = new LoanPackageDAO();
        LoanPackage loanPackage = packageDAO.getLoanPackageById(packageId);
        if (loanPackage == null) {
            errorMessages.add("Gói vay không tồn tại.");
        }

        if (amount != null && loanPackage != null) {
            if (amount.compareTo(BigDecimal.ZERO) <= 0
                    || amount.compareTo(loanPackage.getMinAmount()) < 0
                    || amount.compareTo(loanPackage.getMaxAmount()) > 0) {
                errorMessages.add("Số tiền vay phải nằm trong khoảng từ " + loanPackage.getMinAmount() + " đến " + loanPackage.getMaxAmount() + ".");
            }
        }

        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            request.setAttribute("amount", amountStr);
            request.getRequestDispatcher("loanpackage-customer/create-loan-request.jsp").forward(request, response);
            return;
        }

        LoanRequestDAO loanRequestDAO = new LoanRequestDAO();
        LoanRequest loanRequest = new LoanRequest();
        loanRequest.setCustomerId(customer.getCustomerId());
        loanRequest.setPackageId(packageId);
        loanRequest.setAmount(amount);
        loanRequest.setRequestDate(Date.valueOf(LocalDate.now()));
        loanRequest.setStatus("Pending");

        loanRequestDAO.insert(loanRequest);
        response.sendRedirect("customer-loan-requests?success=true");
    }
}
