
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
import model.Customer;
import model.LoanPackage;
import model.LoanRequest;

@WebServlet(name = "LoanRequestServlet", urlPatterns = {"/loan-request"})
public class LoanRequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");

            // Kiểm tra xem khách hàng đã đăng nhập chưa
            if (customer == null) {
                response.sendRedirect("../login");
                return;
            }

            // Lấy dữ liệu từ request
            String packageIdStr = request.getParameter("package_id");
            String amountStr = request.getParameter("amount");

            // Kiểm tra dữ liệu rỗng
            if (packageIdStr == null || amountStr == null
                    || packageIdStr.trim().isEmpty() || amountStr.trim().isEmpty()) {
                response.sendRedirect("create-loan-request.jsp?error=empty-fields");
                return;
            }

            // Chuyển đổi dữ liệu sang kiểu số
            int customerId = customer.getCustomerId();
            int packageId = Integer.parseInt(packageIdStr);
            BigDecimal amount;

            try {
                amount = new BigDecimal(amountStr.trim());
            } catch (NumberFormatException e) {
                response.sendRedirect("create-loan-request.jsp?error=invalid-number-format");
                return;
            }

            // Kiểm tra số tiền có hợp lệ không (phải lớn hơn 0)
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                response.sendRedirect("create-loan-request.jsp?error=invalid-amount");
                return;
            }

            // Kiểm tra số thập phân (ví dụ: không quá 2 chữ số thập phân)
            if (amount.scale() > 2) {
                response.sendRedirect("create-loan-request.jsp?error=too-many-decimals");
                return;
            }

            // Kiểm tra số tiền có phải bội số của 1 triệu không
            BigDecimal multiple = new BigDecimal("1000000");
            if (amount.remainder(multiple).compareTo(BigDecimal.ZERO) != 0) {
                response.sendRedirect("create-loan-request.jsp?error=amount-not-multiple");
                return;
            }

            // Kiểm tra số tiền vay có nằm trong giới hạn của gói vay không
            LoanPackageDAO packageDAO = new LoanPackageDAO();
            LoanPackage loanPackage = packageDAO.getLoanPackageById(packageId);

            if (loanPackage == null) {
                response.sendRedirect("create-loan-request.jsp?error=invalid-package");
                return;
            }

            if (amount.compareTo(loanPackage.getMinAmount()) < 0 || amount.compareTo(loanPackage.getMaxAmount()) > 0) {
                response.sendRedirect("create-loan-request.jsp?error=amount-out-of-range");
                return;
            }

            // Kiểm tra khách hàng có yêu cầu vay nào đang chờ duyệt không       
//            if (loanRequestDAO.hasPendingRequest(customerId)) {
//                response.sendRedirect("create-loan-request.jsp?error=duplicate-request");
//                return;
//            }
            LoanRequestDAO loanRequestDAO = new LoanRequestDAO();
            // Tạo đối tượng LoanRequest
            Date requestDate = Date.valueOf(LocalDate.now());
            String status = "Pending";

            LoanRequest loanRequest = new LoanRequest();
            loanRequest.setCustomerId(customerId);
            loanRequest.setPackageId(packageId);
            loanRequest.setAmount(amount);
            loanRequest.setRequestDate(requestDate);
            loanRequest.setStatus(status);

            // Lưu vào database
            loanRequestDAO.insert(loanRequest);

            // Chuyển hướng về trang yêu cầu vay với thông báo thành công
            response.sendRedirect("customer-loan-requests?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("create-loan-request.jsp?error=internal-error");
        }
    }
}
