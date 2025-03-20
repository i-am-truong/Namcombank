package controller.loanrequest;

import context.AssetDAO;
import context.LoanPackageDAO;
import context.LoanRequestDAO;
import context.CreditCardDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Asset;
import model.Customer;
import model.LoanPackage;
import model.LoanRequest;

@WebServlet(name = "LoanRequestServlet", urlPatterns = {"/loan-request"})
public class LoanRequestServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoanRequestServlet.class.getName());

    @Override
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
        String assetIdStr = request.getParameter("asset_id");

        int packageId = 0;
        int assetId = 0;
        BigDecimal amount = null;

        // Kiểm tra dữ liệu nhập
        if (packageIdStr == null || amountStr == null || packageIdStr.trim().isEmpty() || amountStr.trim().isEmpty()) {
            errorMessages.add("Vui lòng nhập đầy đủ thông tin.");
        } else {
            try {
                packageId = Integer.parseInt(packageIdStr);
            } catch (NumberFormatException e) {
                errorMessages.add("Gói vay không hợp lệ.");
            }

            try {
                amount = new BigDecimal(amountStr.replaceAll("[^0-9]", ""));
            } catch (NumberFormatException e) {
                errorMessages.add("Số tiền vay không hợp lệ.");
            }

            if (assetIdStr != null && !assetIdStr.trim().isEmpty()) {
                try {
                    assetId = Integer.parseInt(assetIdStr);
                } catch (NumberFormatException e) {
                    errorMessages.add("Asset ID không hợp lệ.");
                }
            }
        }

        // Kiểm tra gói vay
        LoanPackageDAO packageDAO = new LoanPackageDAO();
        LoanPackage loanPackage = packageDAO.getLoanPackageById(packageId);
        if (loanPackage == null) {
            errorMessages.add("Gói vay không tồn tại.");
        }

        // Kiểm tra số tiền vay hợp lệ
        if (amount != null && loanPackage != null) {
            if (amount.compareTo(BigDecimal.ZERO) <= 0
                    || amount.compareTo(loanPackage.getMinAmount()) < 0
                    || amount.compareTo(loanPackage.getMaxAmount()) > 0) {
                errorMessages.add("Số tiền vay phải nằm trong khoảng từ " + loanPackage.getMinAmount() + " đến " + loanPackage.getMaxAmount() + ".");
            }
        }

        // Kiểm tra nếu gói vay là "unsecured", thì không cần tài sản
        Asset asset = null;
        if (!"unsecured".equalsIgnoreCase(loanPackage.getLoanType().trim())) {
            if (assetId > 0) {
                AssetDAO assetDAO = new AssetDAO();
                asset = assetDAO.getAssetById(assetId);
                if (asset == null) {
                    errorMessages.add("Tài sản không tồn tại.");
                }
            } else {
                errorMessages.add("Vui lòng chọn tài sản thế chấp.");
            }
        } else {
            assetId = 0; // Đảm bảo assetId là 0 khi khoản vay không cần tài sản
        }

        // Nếu có lỗi, quay lại trang đăng ký
        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            request.setAttribute("amount", amountStr);
            request.setAttribute("asset_id", assetIdStr);
            request.getRequestDispatcher("loanpackage-customer/create-loan-request.jsp").forward(request, response);
            return;
        }

        // Tạo LoanRequest
        LoanRequestDAO loanRequestDAO = new LoanRequestDAO();
        LoanRequest loanRequest = new LoanRequest();
        loanRequest.setCustomerId(customer.getCustomerId());
        loanRequest.setPackageId(packageId);
        loanRequest.setAmount(amount);
        loanRequest.setRequestDate(Date.valueOf(LocalDate.now()));
        loanRequest.setStatus("Pending");
        // Nếu là unsecured loan, đặt assetId là null
        if ("unsecured".equalsIgnoreCase(loanPackage.getLoanType().trim())) {
            loanRequest.setAssetId(null);
        } else {
            loanRequest.setAssetId(assetId);
        }

        loanRequestDAO.insert(loanRequest);

        // Kiểm tra điều kiện cấp thẻ tín dụng
        checkAndGrantCreditCard(customer.getCustomerId());

        response.sendRedirect("customer-loan-requests?success=true");
    }

    // Kiểm tra điều kiện cấp thẻ tín dụng
    private void checkAndGrantCreditCard(int customerId) {
        LoanRequestDAO loanRequestDAO = new LoanRequestDAO();
        CreditCardDAO cardDAO = new CreditCardDAO();

        BigDecimal totalLoan = loanRequestDAO.getTotalLoanAmount(customerId);
        int loanCount = loanRequestDAO.getLoanCount(customerId);

        if (totalLoan == null) {
            totalLoan = BigDecimal.ZERO;
        }

        boolean hasCreditCard = cardDAO.hasCreditCard(customerId);

        if (totalLoan.compareTo(BigDecimal.valueOf(500000000)) >= 0
                && loanCount >= 3 && !hasCreditCard) {
            BigDecimal creditLimit = BigDecimal.valueOf(100000000);
            cardDAO.createCreditCard(customerId, "Visa", creditLimit);
            LOGGER.log(Level.INFO, "Khách hàng {0} đủ điều kiện nhận thẻ Visa {1}!",
                    new Object[]{customerId, creditLimit});
        } else {
            LOGGER.log(Level.INFO, "Khách hàng {0} chưa đủ điều kiện cấp thẻ.",
                    new Object[]{customerId});
        }
    }
}
